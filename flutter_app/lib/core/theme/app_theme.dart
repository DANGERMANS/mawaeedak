import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Mawaeedak Official Brand Identity
/// Source: docs/MAWAEEDAK_VISUAL_IDENTITY_SOURCE_OF_TRUTH.md

class AppColors {
  // === Official Brand Colors ===
  
  // Primary Gold Gradient
  static const Color gold = Color(0xFFC9A063);
  static const Color goldSoft = Color(0xFFE3C383);
  static const Color goldDark = Color(0xFF8A6B3D);
  
  // Backgrounds - Cream & Paper
  static const Color paper = Color(0xFFFAF7F2);
  static const Color card = Color(0xFFFFFCF7);
  static const Color cream = Color(0xFFF3E8D6);
  
  // Text Colors
  static const Color ink = Color(0xFF2F2B25);
  static const Color muted = Color(0xFF6F6557);
  
  // Semantic Colors
  static const Color error = Color(0xFFB9483F);
  static const Color success = Color(0xFF7A9A74);
  static const Color info = Color(0xFF4A7FB5);
  static const Color warning = Color(0xFFD4A843);
  
  // Border & Shadow
  static const Color border = Color(0x3DC9A063); // ~24% opacity
  static const Color borderLight = Color(0xFFDCD7CF);
  static const Color shadow = Color(0x1E8A6B3D); // ~12% opacity
  
  // Gradients
  static const LinearGradient goldGradient = LinearGradient(
    colors: [gold, goldDark],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFFFFF8EB), paper, cream],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.34, 1.0],
  );
  
  // Surface Colors
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceOverlay = Color(0xD6FFFFFF); // 84% opacity
}

class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

class AppRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double full = 999;
}

class AppShadows {
  static List<BoxShadow> get card => [
    BoxShadow(
      color: const Color(0x1E8A6B3D),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> get elevated => [
    BoxShadow(
      color: const Color(0x17A6B3D),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];
  
  static List<BoxShadow> get glass => [
    BoxShadow(
      color: const Color(0x148A6B3D),
      blurRadius: 34,
      offset: const Offset(0, 14),
    ),
  ];
}

class AppTypography {
  static TextStyle get displayLarge => GoogleFonts.cairo(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.ink,
    height: 1.2,
  );
  
  static TextStyle get displayMedium => GoogleFonts.cairo(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
    height: 1.3,
  );
  
  static TextStyle get titleLarge => GoogleFonts.cairo(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
    height: 1.4,
  );
  
  static TextStyle get titleMedium => GoogleFonts.cairo(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.ink,
    height: 1.4,
  );
  
  static TextStyle get bodyLarge => GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.ink,
    height: 1.5,
  );
  
  static TextStyle get bodyMedium => GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.muted,
    height: 1.5,
  );
  
  static TextStyle get label => GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.ink,
    height: 1.4,
  );
  
  static TextStyle get caption => GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.muted,
    height: 1.4,
  );
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'Cairo',
      
      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.gold,
        onPrimary: Colors.white,
        secondary: AppColors.goldDark,
        onSecondary: Colors.white,
        tertiary: AppColors.goldSoft,
        surface: AppColors.card,
        onSurface: AppColors.ink,
        surfaceContainerHighest: AppColors.cream,
        error: AppColors.error,
        onError: Colors.white,
        outline: AppColors.border,
      ),
      
      scaffoldBackgroundColor: AppColors.paper,
      
      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.paper,
        foregroundColor: AppColors.ink,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.titleLarge,
        iconTheme: const IconThemeData(color: AppColors.ink),
      ),
      
      // Card
      cardTheme: CardTheme(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xxl),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      
      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          textStyle: AppTypography.label,
        ),
      ),
      
      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.gold,
          side: const BorderSide(color: AppColors.gold, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
        ),
      ),
      
      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.gold,
          textStyle: AppTypography.label,
        ),
      ),
      
      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.card,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: const BorderSide(color: AppColors.gold, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        labelStyle: AppTypography.bodyMedium,
        hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.muted),
      ),
      
      // Bottom Navigation
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceOverlay,
        elevation: 0,
        selectedItemColor: AppColors.gold,
        unselectedItemColor: AppColors.muted,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: AppTypography.caption.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.gold,
        ),
        unselectedLabelStyle: AppTypography.caption,
      ),
      
      // Navigation Bar (Material 3)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surfaceOverlay,
        elevation: 0,
        height: 72,
        indicatorColor: AppColors.gold.withValues(alpha: 0.15),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTypography.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.gold,
            );
          }
          return AppTypography.caption.copyWith(color: AppColors.muted);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.gold, size: 24);
          }
          return const IconThemeData(color: AppColors.muted, size: 24);
        }),
      ),
      
      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),
      
      // Icon
      iconTheme: const IconThemeData(
        color: AppColors.gold,
        size: 24,
      ),
      
      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        titleLarge: AppTypography.titleLarge,
        titleMedium: AppTypography.titleMedium,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        labelLarge: AppTypography.label,
        labelMedium: AppTypography.caption,
      ),
    );
  }
}