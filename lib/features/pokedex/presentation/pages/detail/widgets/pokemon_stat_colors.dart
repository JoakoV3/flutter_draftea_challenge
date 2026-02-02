import 'package:flutter/material.dart';
import 'package:flutter_draftea_challenge/core/theme/app_colors.dart';

/// Utilidad para colores de estadísticas
class PokemonStatColors {
  static Color getColor(double percentage) {
    if (percentage >= 0.7) return AppColors.statHigh;
    if (percentage >= 0.4) return AppColors.statMedium;
    return AppColors.statLow;
  }
}
