import 'package:flutter/material.dart';

/// Widget que muestra un estado vacío con un GIF de Pikachu llorando.
///
/// Se utiliza cuando no hay datos para mostrar en una lista o pantalla.
class PokemonEmptyStateWidget extends StatelessWidget {
  /// El tamaño del GIF. Por defecto es 250x250.
  final double size;

  /// Mensaje principal que se muestra debajo del GIF.
  final String message;

  /// Mensaje secundario opcional con más detalles.
  final String? subtitle;

  /// Widget de acción opcional (como un botón de retry).
  final Widget? action;

  const PokemonEmptyStateWidget({
    super.key,
    this.size = 250,
    required this.message,
    this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pikachu llorando GIF
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 24,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/gifs/pikachu_cry.gif',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback a un icono si el GIF falla
                    return Center(
                      child: Icon(
                        Icons.inbox_outlined,
                        size: size * 0.5,
                        color: Colors.grey[400],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Mensaje principal
            Text(
              message,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 12),
              // Mensaje secundario
              Text(
                subtitle!,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[const SizedBox(height: 24), action!],
          ],
        ),
      ),
    );
  }
}
