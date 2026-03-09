import 'package:flutter/material.dart';

/// 应用主题配置：亮色与深色配色
class AppTheme {
  AppTheme._();

  // 主色 - 蓝色
  static const Color _primary = Color(0xFF4fc3f7);
  static const Color _primaryLight = Color(0xFF0288d1);

  // 深色主题配色
  static const Color _darkBg1 = Color(0xFF1a1a2e);
  static const Color _darkBg2 = Color(0xFF16213e);
  static const Color _darkBg3 = Color(0xFF0f3460);
  static const Color _darkSurface = Color(0xFF1a1a2e);
  static const Color _darkCard = Color(0x14FFFFFF);

  // 亮色主题配色
  static const Color _lightBg1 = Color(0xFFf5f7fa);
  static const Color _lightBg2 = Color(0xFFe8ecf1);
  static const Color _lightBg3 = Color(0xFFdce2e9);
  static const Color _lightSurface = Color(0xFFFFFFFF);
  static const Color _lightCard = Color(0x0A000000);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: _primary,
        onPrimary: Colors.white,
        surface: _darkSurface,
        onSurface: Colors.white,
        surfaceContainerHighest: _darkCard,
      ),
      scaffoldBackgroundColor: _darkBg1,
      cardColor: _darkCard,
      extensions: [
        AppThemeColors(
          gradientColors: [_darkBg1, _darkBg2, _darkBg3],
          cardColor: _darkCard,
          textPrimary: Colors.white.withValues(alpha: 0.95),
          textSecondary: Colors.white.withValues(alpha: 0.7),
          textMuted: Colors.white.withValues(alpha: 0.6),
          linkColor: _primary,
          successColor: Colors.greenAccent,
          warningColor: Colors.orange,
        ),
      ],
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: _primaryLight,
        onPrimary: Colors.white,
        surface: _lightSurface,
        onSurface: const Color(0xFF1a1a2e),
        surfaceContainerHighest: _lightCard,
      ),
      scaffoldBackgroundColor: _lightBg1,
      cardColor: _lightCard,
      extensions: [
        AppThemeColors(
          gradientColors: [_lightBg1, _lightBg2, _lightBg3],
          cardColor: _lightCard,
          textPrimary: const Color(0xFF1a1a2e),
          textSecondary: const Color(0xFF4a5568),
          textMuted: const Color(0xFF718096),
          linkColor: _primaryLight,
          successColor: Colors.green.shade700,
          warningColor: Colors.orange.shade700,
        ),
      ],
    );
  }
}

/// 扩展主题数据，用于自定义颜色
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  final List<Color> gradientColors;
  final Color cardColor;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color linkColor;
  final Color successColor;
  final Color warningColor;

  const AppThemeColors({
    required this.gradientColors,
    required this.cardColor,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.linkColor,
    required this.successColor,
    required this.warningColor,
  });

  @override
  AppThemeColors copyWith({
    List<Color>? gradientColors,
    Color? cardColor,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? linkColor,
    Color? successColor,
    Color? warningColor,
  }) {
    return AppThemeColors(
      gradientColors: gradientColors ?? this.gradientColors,
      cardColor: cardColor ?? this.cardColor,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      linkColor: linkColor ?? this.linkColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
    );
  }

  @override
  AppThemeColors lerp(
      covariant ThemeExtension<AppThemeColors>? other, double t) {
    if (other is! AppThemeColors) return this;
    return AppThemeColors(
      gradientColors: gradientColors,
      cardColor: Color.lerp(cardColor, other.cardColor, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      linkColor: Color.lerp(linkColor, other.linkColor, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      warningColor: Color.lerp(warningColor, other.warningColor, t)!,
    );
  }
}

/// 便捷获取扩展主题
extension AppThemeExtension on BuildContext {
  AppThemeColors get appColors =>
      Theme.of(this).extension<AppThemeColors>()!;
}
