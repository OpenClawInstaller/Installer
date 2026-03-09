import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:openclaw_installer/gen_l10n/app_localizations.dart';
import '../services/installer_service.dart';
import '../services/download_service.dart';
import '../services/interactive_process_runner.dart';
import '../utils/platform_utils.dart';
import '../theme/app_theme.dart';

class InstallerScreen extends StatefulWidget {
  final void Function(ThemeMode) onThemeModeChanged;
  final void Function(Locale?) onLocaleChanged;
  final ThemeMode themeMode;
  final Locale? locale;

  const InstallerScreen({
    super.key,
    required this.onThemeModeChanged,
    required this.onLocaleChanged,
    required this.themeMode,
    required this.locale,
  });

  @override
  State<InstallerScreen> createState() => _InstallerScreenState();
}

class _InstallerScreenState extends State<InstallerScreen> {
  int _currentStep = 0;
  InstallType? _installType;
  EnvCheckResult? _envResult;
  bool _isChecking = true;
  bool _isInstalling = false;
  final List<String> _logLines = [];
  bool _installSuccess = false;
  String? _nodeDownloadUrl;
  String? _dockerDirectUrl;

  bool _isDownloading = false;
  double _downloadProgress = 0;
  File? _downloadedFile;
  String? _downloadError;

  /// 桌面平台交互式进程（支持实时输出 + 用户输入）
  InteractiveProcessRunner? _interactiveRunner;
  StreamSubscription<String>? _outputSubscription;
  final _terminalInputController = TextEditingController();
  final _terminalScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _checkEnvironment();
    _loadUrls();
  }

  @override
  void dispose() {
    _outputSubscription?.cancel();
    _interactiveRunner?.kill();
    _terminalInputController.dispose();
    _terminalScrollController.dispose();
    super.dispose();
  }

  Future<void> _loadUrls() async {
    _nodeDownloadUrl = await PlatformUtils.getNodeJsDownloadUrl();
    _dockerDirectUrl = await PlatformUtils.getDockerDirectDownloadUrl();
  }

  Future<void> _checkEnvironment() async {
    setState(() => _isChecking = true);
    final result = await InstallerService.checkEnvironment();
    setState(() {
      _envResult = result;
      _isChecking = false;
    });
  }

  void _selectInstallType(InstallType type) {
    setState(() {
      _installType = type;
      _downloadedFile = null;
      _downloadError = null;
    });
    if (type == InstallType.script) {
      _currentStep = 2;
    } else if (type == InstallType.local && _envResult?.canInstallLocal == true) {
      _currentStep = 2;
    } else if (type == InstallType.docker && _envResult?.canInstallDocker == true) {
      _currentStep = 2;
    } else {
      _currentStep = 1;
    }
  }

  Future<void> _downloadEnv(String url, String filename) async {
    if (_isDownloading || url.isEmpty) return;
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0;
      _downloadError = null;
      _downloadedFile = null;
    });

    final file = await DownloadService.downloadWithProgress(
      url,
      filename: filename,
      onProgress: (p) {
        if (mounted) setState(() => _downloadProgress = p.percent);
      },
    );

    if (!mounted) return;
    setState(() {
      _isDownloading = false;
      _downloadedFile = file;
      _downloadError = file == null ? AppLocalizations.of(context).downloadFailed : null;
    });
  }

  Future<void> _runDownloadedInstaller() async {
    if (_downloadedFile == null) return;
    await DownloadService.runInstaller(_downloadedFile!);
  }

  Future<void> _startInstall() async {
    if (_installType == null) return;

    setState(() {
      _isInstalling = true;
      _logLines.clear();
      _interactiveRunner = null;
    });
    if (_outputSubscription != null) {
      await _outputSubscription!.cancel();
      _outputSubscription = null;
    }

    _terminalInputController.clear();

    if (PlatformUtils.isDesktop) {
      await _startInstallInteractive();
    } else {
      await _startInstallStream();
    }
  }

  Future<void> _startInstallInteractive() async {
    final result = await InstallerService.startInteractiveInstall(_installType!);
    if (!mounted || result == null) {
      _startInstallStream();
      return;
    }

    setState(() => _logLines.addAll(result.initialLines));
    _interactiveRunner = result.runner;

    _outputSubscription = result.runner.outputStream.listen((line) {
      if (!mounted) return;
      setState(() => _logLines.add(line));
      _scrollToTerminalBottom();
    });

    result.runner.exitCodeFuture.then((code) async {
      if (!mounted) return;
      final isLocal = _installType == InstallType.local;
      final npmSuccess = isLocal && code == 0;

      if (npmSuccess) {
        setState(() => _logLines.add('npm 安装成功，正在打开系统终端运行配置向导...'));
        final opened = await InstallerService.runOnboardInSystemTerminal();
        if (!mounted) return;
        setState(() {
          _logLines.add(opened
              ? '已打开系统终端，请在终端中完成配置向导。'
              : '请手动在终端中运行: ${InstallerService.onboardCommand}');
        });
      }

      if (!mounted) return;
      setState(() {
        _logLines.add(''); // 空行分隔
        _logLines.add('[进程已退出，退出码: $code]');
        _isInstalling = false;
        _installSuccess = _logLines.any((l) =>
            l.contains('成功') || l.contains('已启动') || l.contains('完成') ||
            l.contains('success') || l.contains('started') || l.contains('complete'));
        _currentStep = 3;
      });
      _outputSubscription?.cancel();
      _interactiveRunner = null;
    });
  }

  void _scrollToTerminalBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_terminalScrollController.hasClients) {
        _terminalScrollController.jumpTo(_terminalScrollController.position.maxScrollExtent);
      }
    });
  }

  void _sendTerminalInput() {
    final text = _terminalInputController.text.trim();
    if (text.isEmpty || _interactiveRunner == null) return;

    setState(() {
      _logLines.add('\$ $text');
    });
    _terminalInputController.clear();
    _interactiveRunner!.writeLine(text);
    _scrollToTerminalBottom();
  }

  Future<void> _startInstallStream() async {
    Stream<String> stream;
    switch (_installType!) {
      case InstallType.script:
        stream = InstallerService.installWithScript();
        break;
      case InstallType.local:
        stream = InstallerService.installLocal();
        break;
      case InstallType.docker:
        stream = InstallerService.installDocker();
        break;
    }

    await for (final line in stream) {
      if (!mounted) return;
      setState(() => _logLines.add(line));
    }

    if (!mounted) return;
    setState(() {
      _isInstalling = false;
      _installSuccess = _logLines.any((l) =>
          l.contains('成功') || l.contains('已启动') || l.contains('完成') ||
          l.contains('success') || l.contains('started') || l.contains('complete'));
      _currentStep = 3;
    });
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _cycleThemeMode() {
    final modes = [ThemeMode.light, ThemeMode.dark, ThemeMode.system];
    final idx = modes.indexOf(widget.themeMode);
    widget.onThemeModeChanged(modes[(idx + 1) % modes.length]);
  }

  void _cycleLocale() {
    const locales = [Locale('en'), Locale('zh'), null];
    final current = widget.locale;
    int idx = current == null ? 2 : (current.languageCode == 'zh' ? 1 : 0);
    widget.onLocaleChanged(locales[(idx + 1) % 3]);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.appColors;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors.gradientColors,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(l10n, colors),
              Expanded(
                child: _currentStep == 0
                    ? _buildWelcomeStep(l10n, colors)
                    : _currentStep == 1
                        ? _buildEnvStep(l10n, colors)
                        : _currentStep == 2
                            ? _buildInstallStep(l10n, colors)
                            : _buildResultStep(l10n, colors),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n, AppThemeColors colors) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          const Text('🦞', style: TextStyle(fontSize: 40)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.appTitle,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
                Text(
                  l10n.appSubtitle(PlatformUtils.platformName),
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              widget.themeMode == ThemeMode.dark
                  ? Icons.dark_mode
                  : widget.themeMode == ThemeMode.light
                      ? Icons.light_mode
                      : Icons.brightness_auto,
              color: colors.textSecondary,
            ),
            onPressed: _cycleThemeMode,
            tooltip: 'Theme',
          ),
          IconButton(
            icon: Text(
              widget.locale?.languageCode == 'zh' ? '中' : 'EN',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colors.textSecondary,
              ),
            ),
            onPressed: _cycleLocale,
            tooltip: 'Language',
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeStep(AppLocalizations l10n, AppThemeColors colors) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.selectInstallMethod,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          _buildInstallOption(
            icon: '📦',
            title: l10n.localInstall,
            subtitle: l10n.localInstallSubtitle,
            onTap: () => _selectInstallType(InstallType.local),
            colors: colors,
          ),
          const SizedBox(height: 16),
          _buildInstallOption(
            icon: '🐳',
            title: l10n.dockerInstall,
            subtitle: l10n.dockerInstallSubtitle,
            onTap: () => _selectInstallType(InstallType.docker),
            colors: colors,
          ),
          if (PlatformUtils.supportsOfficialScript) ...[
            const SizedBox(height: 16),
            _buildInstallOption(
              icon: '📜',
              title: l10n.scriptInstall,
              subtitle: l10n.scriptInstallSubtitle,
              onTap: () => _selectInstallType(InstallType.script),
              colors: colors,
            ),
          ],
          const SizedBox(height: 40),
          Text(
            l10n.aboutOpenClaw,
            style: TextStyle(
              fontSize: 14,
              color: colors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => _openUrl('https://openclaw.ai'),
            child: Text(
              l10n.learnMore,
              style: TextStyle(
                fontSize: 14,
                color: colors.linkColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstallOption({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required AppThemeColors colors,
  }) {
    return Material(
      color: colors.cardColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 48)),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: colors.textMuted),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnvStep(AppLocalizations l10n, AppThemeColors colors) {
    if (_isChecking) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: colors.linkColor),
            const SizedBox(height: 24),
            Text(
              l10n.checkingEnv,
              style: TextStyle(color: colors.textSecondary),
            ),
          ],
        ),
      );
    }

    final needNode = _installType == InstallType.local && !_envResult!.canInstallLocal;
    final needDocker = _installType == InstallType.docker && !_envResult!.canInstallDocker;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            needNode ? l10n.needNodeJs : l10n.needDocker,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          if (needNode) ...[
            _buildEnvCard(
              l10n: l10n,
              title: l10n.nodeJsTitle,
              desc: l10n.nodeJsDesc,
              downloadUrl: _nodeDownloadUrl ?? 'https://nodejs.org',
              fallbackUrl: 'https://nodejs.org/en/download',
              filename: PlatformUtils.isWindows
                  ? 'node-installer.msi'
                  : PlatformUtils.isMacOS
                      ? 'node-installer.pkg'
                      : 'node-installer.tar.xz',
              colors: colors,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.restartAfterNode,
              style: TextStyle(color: colors.textMuted, fontSize: 14),
            ),
          ],
          if (needDocker && !PlatformUtils.isLinux) ...[
            _buildEnvCard(
              l10n: l10n,
              title: l10n.dockerDesktopTitle,
              desc: l10n.dockerDesktopDesc,
              downloadUrl: _dockerDirectUrl ?? '',
              fallbackUrl: 'https://www.docker.com/products/docker-desktop/',
              filename: PlatformUtils.isWindows
                  ? 'DockerDesktopInstaller.exe'
                  : 'Docker.dmg',
              colors: colors,
            ),
          ],
          if (needDocker && PlatformUtils.isLinux) ...[
            _buildEnvCard(
              l10n: l10n,
              title: l10n.dockerDesktopTitle,
              desc: l10n.dockerDesktopDesc,
              downloadUrl: '',
              fallbackUrl: 'https://docs.docker.com/engine/install/',
              filename: null,
              colors: colors,
            ),
            const SizedBox(height: 16),
            Text(
              PlatformUtils.isLinux ? l10n.linuxDockerHint : l10n.restartAfterDocker,
              style: TextStyle(color: colors.textMuted, fontSize: 14),
            ),
          ],
          const SizedBox(height: 32),
          Row(
            children: [
              OutlinedButton(
                onPressed: () => setState(() => _currentStep = 0),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.textSecondary,
                  side: BorderSide(color: colors.textMuted),
                ),
                child: Text(l10n.back),
              ),
              const SizedBox(width: 16),
              FilledButton(
                onPressed: _checkEnvironment,
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                child: Text(l10n.recheck),
              ),
              const Spacer(),
              if (!needNode && !needDocker)
                FilledButton(
                  onPressed: () => setState(() => _currentStep = 2),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(l10n.continueInstall),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEnvCard({
    required AppLocalizations l10n,
    required String title,
    required String desc,
    required String downloadUrl,
    required String fallbackUrl,
    required String? filename,
    required AppThemeColors colors,
  }) {
    final canBuiltinDownload = downloadUrl.isNotEmpty && filename != null;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            desc,
            style: TextStyle(
              fontSize: 14,
              color: colors.textSecondary,
            ),
          ),
          if (_isDownloading) ...[
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: _downloadProgress,
              backgroundColor: colors.textMuted,
              valueColor: AlwaysStoppedAnimation<Color>(colors.linkColor),
            ),
            const SizedBox(height: 8),
            Text(
              '${(_downloadProgress * 100).toStringAsFixed(0)}%',
              style: TextStyle(fontSize: 12, color: colors.textSecondary),
            ),
          ],
          if (_downloadError != null) ...[
            const SizedBox(height: 8),
            Text(
              _downloadError!,
              style: TextStyle(color: colors.warningColor, fontSize: 12),
            ),
          ],
          if (_downloadedFile != null) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                FilledButton.icon(
                  onPressed: _runDownloadedInstaller,
                  icon: const Icon(Icons.install_desktop, size: 20),
                  label: Text(l10n.installNow),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _downloadedFile!.path,
                    style: TextStyle(
                      fontSize: 11,
                      color: colors.textMuted,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              if (canBuiltinDownload &&
                  !_isDownloading &&
                  _downloadedFile == null)
                FilledButton.icon(
                  onPressed: () => _downloadEnv(downloadUrl, filename),
                  icon: const Icon(Icons.download, size: 20),
                  label: Text(l10n.builtinDownload),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              if (canBuiltinDownload &&
                  !_isDownloading &&
                  _downloadedFile == null)
                const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () => _openUrl(fallbackUrl),
                icon: const Icon(Icons.open_in_browser, size: 18),
                label: Text(l10n.browserDownload),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.textSecondary,
                  side: BorderSide(color: colors.textMuted),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInstallStep(AppLocalizations l10n, AppThemeColors colors) {
    if (!_isInstalling && _logLines.isEmpty) {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _installType == InstallType.local
                  ? l10n.localInstallTitle
                  : _installType == InstallType.docker
                      ? l10n.dockerInstallTitle
                      : l10n.scriptInstallTitle,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _startInstall,
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(l10n.startInstall),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => setState(() => _currentStep = 0),
              style: OutlinedButton.styleFrom(
                foregroundColor: colors.textSecondary,
                side: BorderSide(color: colors.textMuted),
              ),
              child: Text(l10n.back),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _installType == InstallType.local
                ? l10n.localInstallTitle
                : _installType == InstallType.docker
                    ? l10n.dockerInstallTitle
                    : l10n.scriptInstallTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_isInstalling)
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colors.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            l10n.installing,
                            style: TextStyle(color: colors.textPrimary),
                          ),
                        ],
                      )
                    else
                      Text(
                        l10n.installComplete,
                        style: TextStyle(
                          color: _installSuccess
                              ? colors.successColor
                              : colors.warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _terminalScrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _logLines
                              .map((line) => Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Text(
                                      line,
                                      style: TextStyle(
                                        fontFamily: 'monospace',
                                        fontSize: 12,
                                        color: colors.textSecondary,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                    if (_isInstalling && _interactiveRunner != null) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _terminalInputController,
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 12,
                                  color: colors.textPrimary,
                                ),
                                decoration: InputDecoration(
                                  hintText: l10n.terminalInputHint,
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: colors.textMuted,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                onSubmitted: (_) => _sendTerminalInput(),
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: Icon(Icons.send, size: 18, color: colors.linkColor),
                              onPressed: _sendTerminalInput,
                              tooltip: l10n.terminalSend,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildResultStep(AppLocalizations l10n, AppThemeColors colors) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            _installSuccess ? Icons.check_circle : Icons.info,
            size: 64,
            color: _installSuccess
                ? colors.successColor
                : colors.warningColor,
          ),
          const SizedBox(height: 24),
          Text(
            _installSuccess ? l10n.installSuccess : l10n.installEnded,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _installSuccess
                ? l10n.installSuccessDesc
                : l10n.installEndedDesc,
            style: TextStyle(
              fontSize: 14,
              color: colors.textSecondary,
              height: 1.5,
            ),
          ),
          if (!_installSuccess && _logLines.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(
              l10n.errorLogTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colors.warningColor,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              constraints: const BoxConstraints(maxHeight: 240),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: _logLines
                      .map((line) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: SelectableText(
                              line,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 11,
                                color: colors.textSecondary,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
          const SizedBox(height: 32),
          if (_installSuccess) ...[
            FilledButton.icon(
              onPressed: () => InstallerService.openDashboard(),
              icon: const Icon(Icons.open_in_browser),
              label: Text(l10n.openControlPanel),
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'http://127.0.0.1:18789/',
              style: TextStyle(
                fontSize: 14,
                color: colors.linkColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
          const SizedBox(height: 32),
          OutlinedButton(
            onPressed: () {
              setState(() {
                _currentStep = 0;
                _installType = null;
                _logLines.clear();
              });
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: colors.textSecondary,
              side: BorderSide(color: colors.textMuted),
            ),
            child: Text(l10n.reinstall),
          ),
        ],
      ),
    );
  }
}
