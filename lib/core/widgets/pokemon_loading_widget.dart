import 'package:flutter/material.dart';

/// Widget que muestra un GIF de Pikachu cargando y un mensaje opcional.
class PokemonLoadingWidget extends StatelessWidget {
  /// El tamaño del GIF de Pikachu.
  final double size;

  /// Un mensaje opcional que se muestra debajo del GIF de carga.
  final String? message;

  const PokemonLoadingWidget({super.key, this.size = 200, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/gifs/pikachu.gif',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to CircularProgressIndicator if GIF fails to load
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 24),
            Text(
              message!,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
