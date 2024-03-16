import 'package:flutter/material.dart';

///Tailwind颜色定义
@immutable
class TWColors extends ThemeExtension<TWColors> {
  ///gray
  static const int _grayPrimaryValue = 0xFF6B7280;
  static const MaterialColor gray = MaterialColor(
    _grayPrimaryValue,
    <int, Color>{
      50: Color(0xFFF9FAFB),
      100: Color(0xFFF3F4F6),
      200: Color(0xFFE5E7EB),
      300: Color(0xFFD1D5DB),
      400: Color(0xFF9CA3AF),
      500: Color(0xFF6B7280),
      600: Color(0xFF4B5563),
      700: Color(0xFF374151),
      800: Color(0xFF1F2937),
      900: Color(0xFF111827),
    },
  );

  ///neutral
  static const int _neutralPrimaryValue = 0xFF737373;
  static const MaterialColor neutral = MaterialColor(
    _neutralPrimaryValue,
    <int, Color>{
      50: Color(0xFFFAFAFA),
      100: Color(0xFFF5F5F5),
      200: Color(0xFFE5E5E5),
      300: Color(0xFFD4D4D4),
      400: Color(0xFFA3A3A3),
      500: Color(0xFF737373),
      600: Color(0xFF525252),
      700: Color(0xFF404040),
      800: Color(0xFF262626),
      900: Color(0xFF171717),
    },
  );

  ///red
  static const int _redPrimaryValue = 0xFFEF4444;
  static const MaterialColor red = MaterialColor(
    _redPrimaryValue,
    <int, Color>{
      50: Color(0xFFFEF2F2),
      100: Color(0xFFFEE2E2),
      200: Color(0xFFFECACA),
      300: Color(0xFFFCA5A5),
      400: Color(0xFFF87171),
      500: Color(0xFFEF4444),
      600: Color(0xFFDC2626),
      700: Color(0xFFB91C1C),
      800: Color(0xFF991B1B),
      900: Color(0xFF7F1D1D),
    },
  );

  ///green
  static const int _greenPrimaryValue = 0xFF22C55E;
  static const MaterialColor green = MaterialColor(
    _greenPrimaryValue,
    <int, Color>{
      50: Color(0xFFF0FDF4),
      100: Color(0xFFDCFCE7),
      200: Color(0xFFBBF7D0),
      300: Color(0xFF86EFAC),
      400: Color(0xFF4ADE80),
      500: Color(0xFF22C55E),
      600: Color(0xFF16A34A),
      700: Color(0xFF15803D),
      800: Color(0xFF166534),
      900: Color(0xFF14532D),
    },
  );

  ///yellow
  static const int _yellowPrimaryValue = 0xFFEAB308;
  static const MaterialColor yellow = MaterialColor(
    _yellowPrimaryValue,
    <int, Color>{
      50: Color(0xFFFEFCE8),
      100: Color(0xFFFEF9C3),
      200: Color(0xFFFEF08A),
      300: Color(0xFFFDE047),
      400: Color(0xFFFACC15),
      500: Color(0xFFEAB308),
      600: Color(0xFFCA8A04),
      700: Color(0xFFA16207),
      800: Color(0xFF854D0E),
      900: Color(0xFF713F12),
    },
  );

  ///blue
  static const int _bluePrimaryValue = 0xFF3B82F6;
  static const MaterialColor blue = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      50: Color(0xFFEFF6FF),
      100: Color(0xFFDBEAFE),
      200: Color(0xFFBFDBFE),
      300: Color(0xFF93C5FD),
      400: Color(0xFF60A5FA),
      500: Color(0xFF3B82F6),
      600: Color(0xFF2563EB),
      700: Color(0xFF1D4ED8),
      800: Color(0xFF1E40AF),
      900: Color(0xFF1E3A8A),
    },
  );

  const TWColors({
    required this.primary,
    required this.primaryHover,
    required this.primaryDisable,
    required this.primaryBackgroundColor,
    required this.secondBackgroundColor,
    required this.thirdBackgroundColor,
    required this.primaryTextColor,
    required this.secondTextColor,
    required this.thirdTextColor,
    required this.dangerTitleTextColor,
    required this.dangerContentTextColor,
    required this.brandTitleTextColor,
    required this.brandContentTextColor,
    required this.warningTitleTextColor,
    required this.warningContentTextColor,
    required this.successTitleTextColor,
    required this.successContentTextColor,
    required this.dialogBackgroundColor,
    required this.dividerBackgroundColor,
    required this.strokeBackgroundColor,
    required this.fillOffBackgroundColor,
    required this.fillDisableBackgroundColor,
    required this.chatMeBackgroundColor,
  });

  /// blue/default
  ///
  /// 亮色模式为#2563EB，暗色模式为#3B82F6
  final Color? primary;

  /// blue/hovered
  ///
  /// 亮色模式为#1D4ED8，暗色模式为#2563EB
  final Color? primaryHover;

  /// blue/disable
  ///
  /// 亮色模式为#2563EB，暗色模式为#3B82F6
  final Color? primaryDisable;

  /// 通用背景/background-content
  ///
  /// 1级背景色：亮色模式为纯白色，暗色模式为#25262A
  final Color? primaryBackgroundColor;

  /// 通用背景/background
  ///
  /// 2级背景色：亮色模式为#F3F4F6，暗色模式为#17181C
  final Color? secondBackgroundColor;

  /// background-更深一层
  ///
  /// 3级背景色：亮色模式为#E5E7EB，暗色模式为#36373C
  final Color? thirdBackgroundColor;

  /// text/1级文字，强调、正文
  ///
  /// 亮色模式为#111827，暗色模式为纯白色
  final Color? primaryTextColor;

  /// text/2级文字，次强调
  ///
  /// 亮色模式为#6B7280，暗色模式为#D1D5DB
  final Color? secondTextColor;

  /// text/3级文字，placeholder
  ///
  /// 亮色模式为#9CA3AF，暗色模式为#6B7280
  final Color? thirdTextColor;

  /// danger-title
  final Color? dangerTitleTextColor;

  /// danger-content
  final Color? dangerContentTextColor;

  /// brand-title
  final Color? brandTitleTextColor;

  /// brand-content
  final Color? brandContentTextColor;

  /// warning-title
  final Color? warningTitleTextColor;

  /// warning-content
  final Color? warningContentTextColor;

  /// success-title
  final Color? successTitleTextColor;

  /// success-content
  final Color? successContentTextColor;

  /// 弹窗背景颜色
  ///
  /// 亮色模式为纯白色，暗色模式为#25262A
  final Color? dialogBackgroundColor;

  /// gray/分割线
  ///
  /// 亮色模式为#F5F5F5，暗色模式为#525252
  final Color? dividerBackgroundColor;

  /// gray/描边
  ///
  /// 亮色模式为#E5E5E5，暗色模式为#404040
  final Color? strokeBackgroundColor;

  ///填充-背景-off
  ///
  /// 亮色模式为#E5E7EB，暗色模式为#4B5563
  final Color? fillOffBackgroundColor;

  ///填充-disable
  ///
  /// 亮色模式为#F3F4F6，暗色模式为#404040
  final Color? fillDisableBackgroundColor;

  /// chat-me
  ///
  /// 亮色模式为#BFDBFE，暗色模式为#573B82F6
  final Color? chatMeBackgroundColor;

  @override
  TWColors copyWith(
      {Color? primaryColor,
      Color? primaryHoverColor,
      Color? primaryDisableColor,
      Color? primaryBackgroundColor,
      Color? secondBackgroundColor,
      Color? thirdBackgroundColor,
      Color? primaryTextColor,
      Color? secondTextColor,
      Color? thirdTextColor,
      Color? dangerTitleTextColor,
      Color? dangerContentTextColor,
      Color? brandTitleTextColor,
      Color? brandContentTextColor,
      Color? warningTitleTextColor,
      Color? warningContentTextColor,
      Color? successTitleTextColor,
      Color? successContentTextColor,
      Color? dialogBackgroundColor,
      Color? dividerBackgroundColor,
      Color? strokeBackgroundColor,
      Color? fillOffBackgroundColor,
      Color? fillDisableBackgroundColor,
      Color? chatMeBackgroundColor}) {
    return TWColors(
        primary: primaryColor ?? this.primary,
        primaryHover: primaryHoverColor ?? this.primaryHover,
        primaryDisable: primaryDisableColor ?? this.primaryDisable,
        primaryBackgroundColor:
            primaryBackgroundColor ?? this.primaryBackgroundColor,
        secondBackgroundColor:
            secondBackgroundColor ?? this.secondBackgroundColor,
        thirdBackgroundColor: thirdBackgroundColor ?? this.thirdBackgroundColor,
        primaryTextColor: primaryTextColor ?? this.primaryTextColor,
        secondTextColor: secondTextColor ?? this.secondTextColor,
        thirdTextColor: thirdTextColor ?? this.thirdTextColor,
        dangerTitleTextColor: dangerTitleTextColor ?? this.dangerTitleTextColor,
        dangerContentTextColor:
            dangerContentTextColor ?? this.dangerContentTextColor,
        brandTitleTextColor: brandTitleTextColor ?? this.brandTitleTextColor,
        brandContentTextColor:
            brandContentTextColor ?? this.brandContentTextColor,
        warningTitleTextColor:
            warningTitleTextColor ?? this.warningTitleTextColor,
        warningContentTextColor:
            warningContentTextColor ?? this.warningContentTextColor,
        successTitleTextColor:
            successTitleTextColor ?? this.successTitleTextColor,
        successContentTextColor:
            successContentTextColor ?? this.successContentTextColor,
        dialogBackgroundColor:
            dialogBackgroundColor ?? this.dialogBackgroundColor,
        dividerBackgroundColor:
            dividerBackgroundColor ?? this.dividerBackgroundColor,
        strokeBackgroundColor:
            strokeBackgroundColor ?? this.strokeBackgroundColor,
        fillOffBackgroundColor:
            fillOffBackgroundColor ?? this.fillOffBackgroundColor,
        fillDisableBackgroundColor:
            fillDisableBackgroundColor ?? this.fillDisableBackgroundColor,
        chatMeBackgroundColor:
            chatMeBackgroundColor ?? this.chatMeBackgroundColor);
  }

  @override
  TWColors lerp(TWColors? other, double t) {
    if (other is! TWColors) {
      return this;
    }
    return TWColors(
      primary: Color.lerp(primary, other.primary, t),
      primaryHover: Color.lerp(primaryHover, other.primaryHover, t),
      primaryDisable: Color.lerp(primaryDisable, other.primaryDisable, t),
      primaryBackgroundColor:
          Color.lerp(primaryBackgroundColor, other.primaryBackgroundColor, t),
      secondBackgroundColor:
          Color.lerp(secondBackgroundColor, other.secondBackgroundColor, t),
      thirdBackgroundColor:
          Color.lerp(thirdBackgroundColor, other.thirdBackgroundColor, t),
      primaryTextColor: Color.lerp(primaryTextColor, other.primaryTextColor, t),
      secondTextColor: Color.lerp(secondTextColor, other.secondTextColor, t),
      thirdTextColor: Color.lerp(thirdTextColor, other.thirdTextColor, t),
      dangerTitleTextColor:
          Color.lerp(dangerTitleTextColor, other.dangerTitleTextColor, t),
      dangerContentTextColor:
          Color.lerp(dangerContentTextColor, other.dangerContentTextColor, t),
      brandTitleTextColor:
          Color.lerp(brandTitleTextColor, other.brandTitleTextColor, t),
      brandContentTextColor:
          Color.lerp(brandContentTextColor, other.brandContentTextColor, t),
      warningTitleTextColor:
          Color.lerp(warningTitleTextColor, other.warningTitleTextColor, t),
      warningContentTextColor:
          Color.lerp(warningContentTextColor, other.warningContentTextColor, t),
      successTitleTextColor:
          Color.lerp(successTitleTextColor, other.successTitleTextColor, t),
      successContentTextColor:
          Color.lerp(successContentTextColor, other.successContentTextColor, t),
      dialogBackgroundColor:
          Color.lerp(dialogBackgroundColor, other.dialogBackgroundColor, t),
      dividerBackgroundColor:
          Color.lerp(dividerBackgroundColor, other.dividerBackgroundColor, t),
      strokeBackgroundColor:
          Color.lerp(strokeBackgroundColor, other.strokeBackgroundColor, t),
      fillOffBackgroundColor:
          Color.lerp(fillOffBackgroundColor, other.fillOffBackgroundColor, t),
      fillDisableBackgroundColor: Color.lerp(
          fillDisableBackgroundColor, other.fillDisableBackgroundColor, t),
      chatMeBackgroundColor:
          Color.lerp(chatMeBackgroundColor, other.chatMeBackgroundColor, t),
    );
  }
}
