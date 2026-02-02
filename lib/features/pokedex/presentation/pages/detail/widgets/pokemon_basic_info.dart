import 'package:flutter/material.dart';
import 'pokemon_info_item_desktop.dart';
import 'pokemon_info_item_mobile.dart';

/// Card con información básica (altura y peso)
class PokemonBasicInfo extends StatelessWidget {
  final int height;
  final int weight;
  final TextStyle? titleStyle;
  final bool isMobile;

  const PokemonBasicInfo({
    super.key,
    required this.height,
    required this.weight,
    this.titleStyle,
    this.isMobile = false,
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
              'Atributos Físicos',
              style:
                  titleStyle ??
                  Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: isMobile
                      ? PokemonInfoItemMobile(
                          icon: Icons.height,
                          label: 'Altura',
                          value: '${(height / 10).toStringAsFixed(1)} m',
                        )
                      : PokemonInfoItemDesktop(
                          icon: Icons.height,
                          label: 'Altura',
                          value: '${(height / 10).toStringAsFixed(1)} m',
                        ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: isMobile
                      ? PokemonInfoItemMobile(
                          icon: Icons.monitor_weight,
                          label: 'Peso',
                          value: '${(weight / 10).toStringAsFixed(1)} kg',
                        )
                      : PokemonInfoItemDesktop(
                          icon: Icons.monitor_weight,
                          label: 'Peso',
                          value: '${(weight / 10).toStringAsFixed(1)} kg',
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
