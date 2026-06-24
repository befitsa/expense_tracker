import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

// kc colors

  static const Color kcPrimary = Color(0xFF5B5FEF);
  static const Color kcPrimaryDark = Color(0xFF3D3FC4);
  static const Color kcSecondary = Color(0xFF00C2A8);
  static const Color kcBackground = Color(0xFFF6F7FB);
  static const Color kcSurface = Color(0xFFFFFFFF);
  static const Color kcCardDark = Color(0xFF1E1F3B);

  static const Color kcTextPrimary = Color(0xFF1A1B2E);
  static const Color kcTextSecondary = Color(0xFF8C8DA3);
  static const Color kcTextOnDark = Color(0xFFFFFFFF);
  static const Color kcTextOnDarkMuted = Color(0xFFC7C8E0);

  static const Color kcSuccess = Color(0xFF2ECC71);
  static const Color kcError = Color(0xFFFF5A5F);
  static const Color kcWarning = Color(0xFFFFB020);

  static const Color kcBorder = Color(0xFFE7E8F1);
  static const Color kcShadow = Color(0x1A1A1B2E);
//default kc color
  static Color kcDarkGreyColor = Color(0xFF1A1B1E);
  static const Color kcMediumGrey = Color(0xFF474A54);
  static const Color kcLightGrey = Color.fromARGB(255, 187, 187, 187);
  static const Color kcVeryLightGrey = Color(0xFFE3E3E3);

  // Gradients
  static const LinearGradient kcGradientPrimary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6B6FF0), Color(0xFF3D3FC4)],
  );

  static const LinearGradient kcGradientSecondary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00D2B8), Color(0xFF00A88F)],
  );

  static const LinearGradient kcGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2A2C52), Color(0xFF15162B)],
  );

  // Category colors map (fallback palette; see category_config.dart for assignment)
  static const List<Color> kcCategoryPalette = [
    Color(0xFF5B5FEF),
    Color(0xFF00C2A8),
    Color(0xFFFFB020),
    Color(0xFFFF5A5F),
    Color(0xFF9B5DE5),
    Color(0xFF00BBF9),
    Color(0xFFF15BB5),
    Color(0xFF38B000),
  ];
}
