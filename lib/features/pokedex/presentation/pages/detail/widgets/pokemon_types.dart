import 'package:flutter/material.dart';
import 'pokemon_type_colors.dart';

/// Chips de tipos del Pokemon
class PokemonTypes extends StatelessWidget {
  final List<String> types;
  final double fontSize;

  const PokemonTypes({super.key, required this.types, this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: types.map((type) {
        return Chip(
          label: Text(
            type.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
          backgroundColor: PokemonTypeColors.getColor(type),
        );
      }).toList(),
    );
  }
}
