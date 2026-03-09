import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:openclaw_installer/gen_l10n/app_localizations.dart';
import 'screens/installer_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const OpenClawInstallerApp());
}

class OpenClawInstallerApp extends StatefulWidget {
  const OpenClawInstallerApp({super.key});

  @override
  State<OpenClawInstallerApp> createState() => _OpenClawInstallerAppState();
}

class _OpenClawInstallerAppState extends State<OpenClawInstallerApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  Locale? _locale;

  void _setThemeMode(ThemeMode mode) {
    setState(() => _themeMode = mode);
  }

  void _setLocale(Locale? locale) {
    setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenClaw 安装器',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: InstallerScreen(
        onThemeModeChanged: _setThemeMode,
        onLocaleChanged: _setLocale,
        themeMode: _themeMode,
        locale: _locale,
      ),
    );
  }
}
