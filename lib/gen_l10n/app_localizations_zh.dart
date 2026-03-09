// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'OpenClaw 安装器';

  @override
  String appSubtitle(String platform) {
    return 'Personal AI Assistant · $platform';
  }

  @override
  String get selectInstallMethod => '选择安装方式';

  @override
  String get localInstall => '本地安装 (npm)';

  @override
  String get localInstallSubtitle => '直接安装到系统，需要 Node.js 22+';

  @override
  String get dockerInstall => 'Docker 安装';

  @override
  String get dockerInstallSubtitle => '容器化运行，需要 Docker';

  @override
  String get scriptInstall => '官方脚本安装';

  @override
  String get scriptInstallSubtitle =>
      '一键安装 Node.js + OpenClaw（macOS/Linux/Windows）';

  @override
  String get aboutOpenClaw =>
      'OpenClaw 是开源的个人 AI 助手，可通过 WhatsApp、Telegram、Discord 等与您对话。';

  @override
  String get learnMore => '了解更多 → openclaw.ai';

  @override
  String get checkingEnv => '正在检测环境...';

  @override
  String get needNodeJs => '需要安装 Node.js';

  @override
  String get needDocker => '需要安装 Docker';

  @override
  String get nodeJsTitle => 'Node.js 22+';

  @override
  String get nodeJsDesc => 'OpenClaw 本地安装需要 Node.js 22 或更高版本';

  @override
  String get downloadNodeJs => '下载 Node.js';

  @override
  String get downloadFailed => '下载失败';

  @override
  String get installNow => '立即安装';

  @override
  String get builtinDownload => '内置下载';

  @override
  String get browserDownload => '浏览器下载';

  @override
  String get restartAfterNode => '安装完成后请重启本安装器';

  @override
  String get dockerDesktopTitle => 'Docker Desktop';

  @override
  String get dockerDesktopDesc => 'Docker 方式需要先安装 Docker Desktop';

  @override
  String get downloadDocker => '下载 Docker';

  @override
  String get linuxDockerHint => 'Linux 用户请参考官方文档安装 Docker Engine';

  @override
  String get restartAfterDocker => '安装并启动 Docker 后请重启本安装器';

  @override
  String get back => '返回';

  @override
  String get recheck => '重新检测';

  @override
  String get continueInstall => '继续安装';

  @override
  String get localInstallTitle => '本地安装';

  @override
  String get dockerInstallTitle => 'Docker 安装';

  @override
  String get scriptInstallTitle => '脚本安装';

  @override
  String get startInstall => '开始安装';

  @override
  String get installing => '安装中...';

  @override
  String get installComplete => '安装完成';

  @override
  String get installSuccess => '安装完成！';

  @override
  String get installEnded => '安装过程已结束';

  @override
  String get installSuccessDesc => 'OpenClaw 已成功安装。您可以打开控制面板完成首次配置。';

  @override
  String get installEndedDesc => '请查看上方日志了解详情。如需帮助请访问 openclaw.ai';

  @override
  String get openControlPanel => '打开控制面板';

  @override
  String get reinstall => '重新安装';

  @override
  String get terminalInputHint => '在此输入并按回车发送到进程';

  @override
  String get terminalSend => '发送';

  @override
  String get errorLogTitle => '错误日志';
}
