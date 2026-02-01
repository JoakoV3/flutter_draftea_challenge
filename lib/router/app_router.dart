import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

/// Configuración principal del router de la aplicación
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: AppRoutes.routes,
  errorBuilder: (context, state) {
    //TODO: implementar pantalla de error
    return const Placeholder();
  },
  debugLogDiagnostics: true,
);
