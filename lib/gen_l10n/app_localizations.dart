import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'OpenClaw Installer'**
  String get appTitle;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Personal AI Assistant · {platform}'**
  String appSubtitle(String platform);

  /// No description provided for @selectInstallMethod.
  ///
  /// In en, this message translates to:
  /// **'Select installation method'**
  String get selectInstallMethod;

  /// No description provided for @localInstall.
  ///
  /// In en, this message translates to:
  /// **'Local install (npm)'**
  String get localInstall;

  /// No description provided for @localInstallSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Install directly to system, requires Node.js 22+'**
  String get localInstallSubtitle;

  /// No description provided for @dockerInstall.
  ///
  /// In en, this message translates to:
  /// **'Docker install'**
  String get dockerInstall;

  /// No description provided for @dockerInstallSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Containerized run, requires Docker'**
  String get dockerInstallSubtitle;

  /// No description provided for @scriptInstall.
  ///
  /// In en, this message translates to:
  /// **'Official script install'**
  String get scriptInstall;

  /// No description provided for @scriptInstallSubtitle.
  ///
  /// In en, this message translates to:
  /// **'One-click install Node.js + OpenClaw (macOS/Linux/Windows)'**
  String get scriptInstallSubtitle;

  /// No description provided for @aboutOpenClaw.
  ///
  /// In en, this message translates to:
  /// **'OpenClaw is an open-source personal AI assistant that can chat with you via WhatsApp, Telegram, Discord, and more.'**
  String get aboutOpenClaw;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn more → openclaw.ai'**
  String get learnMore;

  /// No description provided for @checkingEnv.
  ///
  /// In en, this message translates to:
  /// **'Checking environment...'**
  String get checkingEnv;

  /// No description provided for @needNodeJs.
  ///
  /// In en, this message translates to:
  /// **'Node.js 22+ required'**
  String get needNodeJs;

  /// No description provided for @needDocker.
  ///
  /// In en, this message translates to:
  /// **'Docker required'**
  String get needDocker;

  /// No description provided for @nodeJsTitle.
  ///
  /// In en, this message translates to:
  /// **'Node.js 22+'**
  String get nodeJsTitle;

  /// No description provided for @nodeJsDesc.
  ///
  /// In en, this message translates to:
  /// **'OpenClaw local install requires Node.js 22 or higher'**
  String get nodeJsDesc;

  /// No description provided for @downloadNodeJs.
  ///
  /// In en, this message translates to:
  /// **'Download Node.js'**
  String get downloadNodeJs;

  /// No description provided for @downloadFailed.
  ///
  /// In en, this message translates to:
  /// **'Download failed'**
  String get downloadFailed;

  /// No description provided for @installNow.
  ///
  /// In en, this message translates to:
  /// **'Install now'**
  String get installNow;

  /// No description provided for @builtinDownload.
  ///
  /// In en, this message translates to:
  /// **'Built-in download'**
  String get builtinDownload;

  /// No description provided for @browserDownload.
  ///
  /// In en, this message translates to:
  /// **'Browser download'**
  String get browserDownload;

  /// No description provided for @restartAfterNode.
  ///
  /// In en, this message translates to:
  /// **'Please restart this installer after installation'**
  String get restartAfterNode;

  /// No description provided for @dockerDesktopTitle.
  ///
  /// In en, this message translates to:
  /// **'Docker Desktop'**
  String get dockerDesktopTitle;

  /// No description provided for @dockerDesktopDesc.
  ///
  /// In en, this message translates to:
  /// **'Docker installation requires Docker Desktop'**
  String get dockerDesktopDesc;

  /// No description provided for @downloadDocker.
  ///
  /// In en, this message translates to:
  /// **'Download Docker'**
  String get downloadDocker;

  /// No description provided for @linuxDockerHint.
  ///
  /// In en, this message translates to:
  /// **'Linux users please refer to official docs for Docker Engine'**
  String get linuxDockerHint;

  /// No description provided for @restartAfterDocker.
  ///
  /// In en, this message translates to:
  /// **'Please restart this installer after Docker is installed and running'**
  String get restartAfterDocker;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @recheck.
  ///
  /// In en, this message translates to:
  /// **'Recheck'**
  String get recheck;

  /// No description provided for @continueInstall.
  ///
  /// In en, this message translates to:
  /// **'Continue install'**
  String get continueInstall;

  /// No description provided for @localInstallTitle.
  ///
  /// In en, this message translates to:
  /// **'Local install'**
  String get localInstallTitle;

  /// No description provided for @dockerInstallTitle.
  ///
  /// In en, this message translates to:
  /// **'Docker install'**
  String get dockerInstallTitle;

  /// No description provided for @scriptInstallTitle.
  ///
  /// In en, this message translates to:
  /// **'Script install'**
  String get scriptInstallTitle;

  /// No description provided for @startInstall.
  ///
  /// In en, this message translates to:
  /// **'Start install'**
  String get startInstall;

  /// No description provided for @installing.
  ///
  /// In en, this message translates to:
  /// **'Installing...'**
  String get installing;

  /// No description provided for @installComplete.
  ///
  /// In en, this message translates to:
  /// **'Install complete'**
  String get installComplete;

  /// No description provided for @installSuccess.
  ///
  /// In en, this message translates to:
  /// **'Installation complete!'**
  String get installSuccess;

  /// No description provided for @installEnded.
  ///
  /// In en, this message translates to:
  /// **'Installation ended'**
  String get installEnded;

  /// No description provided for @installSuccessDesc.
  ///
  /// In en, this message translates to:
  /// **'OpenClaw has been installed successfully. You can open the control panel to complete initial setup.'**
  String get installSuccessDesc;

  /// No description provided for @installEndedDesc.
  ///
  /// In en, this message translates to:
  /// **'Please check the log above for details. Visit openclaw.ai for help.'**
  String get installEndedDesc;

  /// No description provided for @openControlPanel.
  ///
  /// In en, this message translates to:
  /// **'Open control panel'**
  String get openControlPanel;

  /// No description provided for @reinstall.
  ///
  /// In en, this message translates to:
  /// **'Reinstall'**
  String get reinstall;

  /// No description provided for @terminalInputHint.
  ///
  /// In en, this message translates to:
  /// **'Type here and press Enter to send input to the process'**
  String get terminalInputHint;

  /// No description provided for @terminalSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get terminalSend;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
