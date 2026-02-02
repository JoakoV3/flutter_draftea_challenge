import 'package:flutter/material.dart';

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
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, size: iconSize, color: Colors.blue[700]),
                      const SizedBox(width: 8),
                      Text(
                        ability.replaceAll('-', ' ').toUpperCase(),
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontWeight: FontWeight.w600,
                          fontSize: fontSize,
                        ),
                      ),
                    ],
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
