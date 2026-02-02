import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_draftea_challenge/features/pokedex/data/repositories_impl/pokemon_repository_impl.dart';
import 'package:flutter_draftea_challenge/features/pokedex/presentation/cubit/pokemon_list/pokemon_list_cubit.dart';
import 'package:flutter_draftea_challenge/features/pokedex/presentation/pages/home/home_page.dart';
import 'package:go_router/go_router.dart';

/// Clase que contiene todas las rutas de la aplicación
///
/// (No manejamos autenticación por lo que no hay rutas protegidas)
class AppRoutes {
  // Nombres de las rutas
  static const String home = '/';

  // Definición de todas las rutas
  static List<RouteBase> routes = [
    GoRoute(
      path: home,
      name: 'home',
      builder: (context, _) {
        return BlocProvider(
          create: (context) =>
              PokemonListCubit(context.read<PokemonRepositoryImpl>())
                ..loadPokemons(),
          child: const HomePage(),
        );
      },
    ),
  ];
}
