import 'package:flutter/material.dart';
import 'detail_desktop_page.dart';
import 'detail_mobile_page.dart';

/// Página de detalle del Pokemon que se adapta según el tamaño de pantalla
class DetailPage extends StatelessWidget {
  final int pokemonId;

  const DetailPage({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Usar versión desktop si el ancho es mayor a 600px
        if (constraints.maxWidth > 600) {
          return DetailDesktopPage(pokemonId: pokemonId);
        } else {
          return DetailMobilePage(pokemonId: pokemonId);
        }
      },
    );
  }
}
