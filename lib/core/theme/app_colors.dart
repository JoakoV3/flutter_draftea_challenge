import 'package:flutter/material.dart';

/// Colores de la aplicación Pokédex
class AppColors {
  // Colores principales - Rojo Pokemon
  static const Color pokemonRed = Color(0xFFE53935);
  static const Color pokemonRedDark = Color(0xFFB71C1C);

  // Colores secundarios - Azul Pokemon
  static const Color pokemonBlue = Color(0xFF1976D2);
  static const Color pokemonBlueDark = Color(0xFF0D47A1);
  static const Color pokemonBlueLight = Color(0xFFE3F2FD);

  // Gradientes
  static LinearGradient redGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [pokemonRed, pokemonRedDark],
    stops: [0.5, 0.5],
  );

  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [pokemonBlue, pokemonBlueDark],
    stops: [0.5, 0.5],
  );

  // Colores de tipos de Pokemon
  static const Map<String, Color> typeColors = {
    'normal': Color(0xFFA8A878),
    'fire': Color(0xFFF08030),
    'water': Color(0xFF6890F0),
    'electric': Color(0xFFF8D030),
    'grass': Color(0xFF78C850),
    'ice': Color(0xFF98D8D8),
    'fighting': Color(0xFFC03028),
    'poison': Color(0xFFA040A0),
    'ground': Color(0xFFE0C068),
    'flying': Color(0xFFA890F0),
    'psychic': Color(0xFFF85888),
    'bug': Color(0xFFA8B820),
    'rock': Color(0xFFB8A038),
    'ghost': Color(0xFF705898),
    'dragon': Color(0xFF7038F8),
    'dark': Color(0xFF705848),
    'steel': Color(0xFFB8B8D0),
    'fairy': Color(0xFFEE99AC),
  };

  // Colores de estadísticas
  static const Color statHigh = Colors.green;
  static const Color statMedium = Colors.orange;
  static const Color statLow = Colors.red;
}
