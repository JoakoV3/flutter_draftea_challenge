import 'package:flutter/material.dart';

/// Header con el nombre y ID del Pokemon
class PokemonHeader extends StatelessWidget {
  final String name;
  final int id;
  final TextStyle? nameStyle;
  final TextStyle? idStyle;
  final bool showID;

  const PokemonHeader({
    super.key,
    required this.name,
    required this.id,
    this.nameStyle,
    this.idStyle,
    this.showID = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1976D2), // Azul más claro
                Color(0xFF0D47A1), // Azul más oscuro
              ],
              stops: [0.5, 0.5],
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE53935), // Rojo
                  Color(0xFFB71C1C), // Rojo oscuro
                ],
                stops: [0.5, 0.5],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/$id.gif',
                  height: 50,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox(height: 50, width: 50),
                ),
                Text(
                  name.toUpperCase(),
                  style:
                      nameStyle ??
                      Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Superstar',
                      ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                if (showID)
                  Text(
                    'N.º ${id.toString().padLeft(3, '0')}',
                    style:
                        idStyle ??
                        Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(color: Colors.white70),
                  ),
                Image.network(
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/back/$id.gif',
                  height: 50,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox(height: 50, width: 50),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

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

/// Item de información individual - versión desktop
class PokemonInfoItemDesktop extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const PokemonInfoItemDesktop({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 32, color: Colors.blue),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

/// Item de información individual - versión mobile
class PokemonInfoItemMobile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const PokemonInfoItemMobile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Colors.blue),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

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

/// Utilidad para formatear nombres de estadísticas
class PokemonStatFormatter {
  static String formatName(String statName) {
    const Map<String, String> statNames = {
      'hp': 'PS',
      'attack': 'Ataque',
      'defense': 'Defensa',
      'special-attack': 'Atq. Esp.',
      'special-defense': 'Def. Esp.',
      'speed': 'Velocidad',
    };
    return statNames[statName] ?? statName.toUpperCase();
  }
}

/// Utilidad para colores de estadísticas
class PokemonStatColors {
  static Color getColor(double percentage) {
    if (percentage >= 0.7) return Colors.green;
    if (percentage >= 0.4) return Colors.orange;
    return Colors.red;
  }
}

/// Utilidad para colores de tipos de Pokemon
class PokemonTypeColors {
  static Color getColor(String type) {
    const Map<String, Color> typeColors = {
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
    return typeColors[type.toLowerCase()] ?? Colors.grey;
  }
}
