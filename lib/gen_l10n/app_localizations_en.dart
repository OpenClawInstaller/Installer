// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'OpenClaw Installer';

  @override
  String appSubtitle(String platform) {
    return 'Personal AI Assistant · $platform';
  }

  @override
  String get selectInstallMethod => 'Select installation method';

  @override
  String get localInstall => 'Local install (npm)';

  @override
  String get localInstallSubtitle =>
      'Install directly to system, requires Node.js 22+';

  @override
  String get dockerInstall => 'Docker install';

  @override
  String get dockerInstallSubtitle => 'Containerized run, requires Docker';

  @override
  String get scriptInstall => 'Official script install';

  @override
  String get scriptInstallSubtitle =>
      'One-click install Node.js + OpenClaw (macOS/Linux/Windows)';

  @override
  String get aboutOpenClaw =>
      'OpenClaw is an open-source personal AI assistant that can chat with you via WhatsApp, Telegram, Discord, and more.';

  @override
  String get learnMore => 'Learn more → openclaw.ai';

  @override
  String get checkingEnv => 'Checking environment...';

  @override
  String get needNodeJs => 'Node.js 22+ required';

  @override
  String get needDocker => 'Docker required';

  @override
  String get nodeJsTitle => 'Node.js 22+';

  @override
  String get nodeJsDesc =>
      'OpenClaw local install requires Node.js 22 or higher';

  @override
  String get downloadNodeJs => 'Download Node.js';

  @override
  String get downloadFailed => 'Download failed';

  @override
  String get installNow => 'Install now';

  @override
  String get builtinDownload => 'Built-in download';

  @override
  String get browserDownload => 'Browser download';

  @override
  String get restartAfterNode =>
      'Please restart this installer after installation';

  @override
  String get dockerDesktopTitle => 'Docker Desktop';

  @override
  String get dockerDesktopDesc => 'Docker installation requires Docker Desktop';

  @override
  String get downloadDocker => 'Download Docker';

  @override
  String get linuxDockerHint =>
      'Linux users please refer to official docs for Docker Engine';

  @override
  String get restartAfterDocker =>
      'Please restart this installer after Docker is installed and running';

  @override
  String get back => 'Back';

  @override
  String get recheck => 'Recheck';

  @override
  String get continueInstall => 'Continue install';

  @override
  String get localInstallTitle => 'Local install';

  @override
  String get dockerInstallTitle => 'Docker install';

  @override
  String get scriptInstallTitle => 'Script install';

  @override
  String get startInstall => 'Start install';

  @override
  String get installing => 'Installing...';

  @override
  String get installComplete => 'Install complete';

  @override
  String get installSuccess => 'Installation complete!';

  @override
  String get installEnded => 'Installation ended';

  @override
  String get installSuccessDesc =>
      'OpenClaw has been installed successfully. You can open the control panel to complete initial setup.';

  @override
  String get installEndedDesc =>
      'Please check the log above for details. Visit openclaw.ai for help.';

  @override
  String get openControlPanel => 'Open control panel';

  @override
  String get reinstall => 'Reinstall';

  @override
  String get terminalInputHint =>
      'Type here and press Enter to send input to the process';

  @override
  String get terminalSend => 'Send';
}
