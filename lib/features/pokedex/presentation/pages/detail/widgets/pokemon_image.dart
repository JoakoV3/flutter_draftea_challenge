import 'package:flutter/material.dart';
import 'package:flutter_draftea_challenge/core/theme/app_colors.dart';

/// Widget para mostrar la imagen del Pokemon con fondo de color del tipo
class PokemonImage extends StatelessWidget {
  final String imageUrl;
  final String type;
  final bool isMobile;

  const PokemonImage({
    super.key,
    required this.imageUrl,
    required this.type,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Container(
        height: 300,
        decoration: BoxDecoration(
          color: AppColors.typeColors[type.toLowerCase()]?.withValues(
            alpha: 0.6,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.catching_pokemon, size: 150, color: Colors.grey),
        ),
      );
    }

    // Desktop version
    return Card(
      color: AppColors.typeColors[type.toLowerCase()]?.withValues(alpha: 0.5),
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.catching_pokemon, size: 200, color: Colors.grey),
        ),
      ),
    );
  }
}
