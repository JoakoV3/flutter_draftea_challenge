import 'package:flutter/material.dart';
import 'package:flutter_draftea_challenge/core/theme/app_colors.dart';

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
    final backImage =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/back/$id.gif';
    final frontImage =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/$id.gif';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: AppColors.blueGradient,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: AppColors.redGradient,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  frontImage,
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
                        shadows: const [
                          Shadow(offset: Offset(-2, 3), color: Colors.black),
                        ],
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
                  backImage,
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
