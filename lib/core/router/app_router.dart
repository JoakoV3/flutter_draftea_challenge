import 'package:go_router/go_router.dart';
import 'package:flutter_draftea_challenge/core/pages/error_page.dart';
import 'routes.dart';

/// Configuración principal del router de la aplicación
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: AppRoutes.routes,
  errorBuilder: (context, state) {
    return ErrorPage();
  },
);
