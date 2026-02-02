import 'package:flutter/material.dart';
import 'pokemon_stat_colors.dart';

/// Barra de progreso individual para una estadística
class PokemonStatBar extends StatelessWidget {
  final String label;
  final int value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final double minHeight;
  final double borderRadius;

  const PokemonStatBar({
    super.key,
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
    this.minHeight = 8,
    this.borderRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    // Máximo valor de stats es 255
    final percentage = (value / 255).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style:
                  labelStyle ??
                  Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              value.toString(),
              style:
                  valueStyle ??
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              PokemonStatColors.getColor(percentage),
            ),
            minHeight: minHeight,
          ),
        ),
      ],
    );
  }
}
