import 'package:flutter/material.dart';
import 'pokemon_stat_bar.dart';
import 'pokemon_stat_formatter.dart';

/// Card con las estadísticas base del Pokemon
class PokemonStats extends StatelessWidget {
  final Map<String, int> stats;
  final TextStyle? titleStyle;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final double spacing;
  final double minHeight;
  final double borderRadius;

  const PokemonStats({
    super.key,
    required this.stats,
    this.titleStyle,
    this.labelStyle,
    this.valueStyle,
    this.spacing = 12,
    this.minHeight = 8,
    this.borderRadius = 0,
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
              'Estadísticas base',
              style:
                  titleStyle ??
                  Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: spacing),
            ...stats.entries.map((entry) {
              return Padding(
                padding: EdgeInsets.only(bottom: spacing),
                child: PokemonStatBar(
                  label: PokemonStatFormatter.formatName(entry.key),
                  value: entry.value,
                  labelStyle: labelStyle,
                  valueStyle: valueStyle,
                  minHeight: minHeight,
                  borderRadius: borderRadius,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
