import 'package:flutter/material.dart';
import 'package:flutter_draftea_challenge/core/theme/app_colors.dart';

/// Utilidad para colores de tipos de Pokemon
class PokemonTypeColors {
  static Color getColor(String type) {
    return AppColors.typeColors[type.toLowerCase()] ?? Colors.grey;
  }
}
