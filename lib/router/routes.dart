import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Clase que contiene todas las rutas de la aplicación
///
/// (No manejamos autenticación por lo que no hay rutas protegidas)
class AppRoutes {
  // Nombres de las rutas
  static const String home = '/';
  static const String profile = '/profile';
  static const String settings = '/settings';

  // Definición de todas las rutas
  static List<RouteBase> routes = [
    GoRoute(
      path: home,
      name: 'home',
      builder: (context, state) {
        return const Placeholder();
      },
    ),
  ];
}
