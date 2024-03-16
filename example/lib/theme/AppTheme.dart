import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'TWColors.dart';

const SystemUiOverlayStyle SystemUiLight = SystemUiOverlayStyle(
  systemNavigationBarColor: Color(0xFF000000),
  systemNavigationBarDividerColor: null,
  statusBarColor: null,
  systemNavigationBarIconBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.dark,
);
const SystemUiOverlayStyle SystemUiDark = SystemUiOverlayStyle(
  systemNavigationBarColor: Color(0xFF000000),
  systemNavigationBarDividerColor: null,
  statusBarColor: null,
  systemNavigationBarIconBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.light,
);

enum AppTheme {
  PureLight,
  PureDark,
}

extension TailwindTheme on ThemeData {
  TWColors get twColors => extension<TWColors>()!;
}

final LightTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.light,
  primaryColor: Color(0xFF2563EB),
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF2563EB),
    onPrimary: Color(0xFF2563EB),
    secondary: Color(0xFF4B7BFF),
    onSecondary: Color(0xFF4B7BFF),
    error: Colors.red,
    onError: Colors.red,
    background: Colors.white,
    onBackground: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
  ),
  appBarTheme: AppBarTheme(elevation: 0, color: Colors.white),
  extensions: const <ThemeExtension<dynamic>>[
    TWColors(
        primary: Color(0xFF2563EB),
        primaryHover: Color(0xFF1D4ED8),
        primaryDisable: Color(0xFF2563EB),
        primaryBackgroundColor: Color(0xFFFFFFFF),
        secondBackgroundColor: Color(0xFFF3F4F6),
        thirdBackgroundColor: Color(0xFFE5E7EB),
        primaryTextColor: Color(0xFF111827),
        secondTextColor: Color(0xFF6B7280),
        thirdTextColor: Color(0xFF9CA3AF),
        dangerTitleTextColor: Color(0xFFB91C1C),
        dangerContentTextColor: Color(0xFFDC2626),
        brandTitleTextColor: Color(0XFF1D4ED8),
        brandContentTextColor: Color(0XFF2563EB),
        warningTitleTextColor: Color(0xFFA16207),
        warningContentTextColor: Color(0xFFCA8A04),
        successTitleTextColor: Color(0xFF15803D),
        successContentTextColor: Color(0xFF16A34A),
        dialogBackgroundColor: Color(0xFFFFFFFF),
        dividerBackgroundColor: Color(0xFFF5F5F5),
        strokeBackgroundColor: Color(0xFFE5E5E5),
        fillOffBackgroundColor: Color(0xFFE5E7EB),
        fillDisableBackgroundColor: Color(0xFFF3F4F6),
        chatMeBackgroundColor: Color(0xFFBFDBFE)),
  ],
);

final DarkTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.dark,
  primaryColor: Color(0xFF3B82F6),
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF3B82F6),
    onPrimary: Color(0xFF3B82F6),
    secondary: Color(0xFF658AFF),
    onSecondary: Color(0xFF658AFF),
    error: Colors.red,
    onError: Colors.red,
    background: Colors.black,
    onBackground: Colors.black,
    surface: Colors.black,
    onSurface: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: Color(0xFF25262A),
  ),
  extensions: const <ThemeExtension<dynamic>>[
    TWColors(
        primary: Color(0xFF3B82F6),
        primaryHover: Color(0xFF2563EB),
        primaryDisable: Color(0xFF3B82F6),
        primaryBackgroundColor: Color(0xFF25262A),
        secondBackgroundColor: Color(0xFF17181C),
        thirdBackgroundColor: Color(0xFF36373C),
        primaryTextColor: Color(0xFFFFFFFF),
        secondTextColor: Color(0xFFD1D5DB),
        thirdTextColor: Color(0xFF6B7280),
        dangerTitleTextColor: Color(0xFFEF4444),
        dangerContentTextColor: Color(0xFFEF4444),
        brandTitleTextColor: Color(0xFF3B82F6),
        brandContentTextColor: Color(0xFF3B82F6),
        warningTitleTextColor: Color(0xFFEAB308),
        warningContentTextColor: Color(0xFFEAB308),
        successTitleTextColor: Color(0xFF22C55E),
        successContentTextColor: Color(0xFF22C55E),
        dialogBackgroundColor: Color(0xFF25262A),
        dividerBackgroundColor: Color(0xFF525252),
        strokeBackgroundColor: Color(0xFF404040),
        fillOffBackgroundColor: Color(0xFF4B5563),
        fillDisableBackgroundColor: Color(0xFF404040),
        chatMeBackgroundColor: Color(0x573B82F6)),
  ],
);
