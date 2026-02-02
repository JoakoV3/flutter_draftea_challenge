import 'package:flutter/material.dart';
import 'package:flutter_draftea_challenge/core/theme/app_colors.dart';

/// Card con las habilidades del Pokemon
class PokemonAbilities extends StatelessWidget {
  final List<String> abilities;
  final TextStyle? titleStyle;
  final double iconSize;
  final double fontSize;
  final EdgeInsets padding;
  final double borderRadius;

  const PokemonAbilities({
    super.key,
    required this.abilities,
    this.titleStyle,
    this.iconSize = 16,
    this.fontSize = 14,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.borderRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Habilidades',
              style:
                  titleStyle ??
                  Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: abilities.map((ability) {
                return Container(
                  padding: padding,
                  decoration: BoxDecoration(
                    color: AppColors.pokemonBlueLight,
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: Border.all(color: AppColors.pokemonBlueDark),
                  ),
                  child: Text(
                    ability.replaceAll('-', ' ').toUpperCase(),
                    style: TextStyle(
                      color: AppColors.pokemonBlueDark,
                      fontWeight: FontWeight.w600,
                      fontSize: fontSize,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
