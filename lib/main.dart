import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_draftea_challenge/core/network/dio_client.dart';
import 'package:flutter_draftea_challenge/core/persistence/app_database.dart';
import 'package:flutter_draftea_challenge/core/router/app_router.dart';
import 'package:flutter_draftea_challenge/core/theme/app_theme.dart';
import 'package:flutter_draftea_challenge/features/pokedex/data/datasources/pokemon_local_datasource.dart';
import 'package:flutter_draftea_challenge/features/pokedex/data/datasources/pokemon_remote_datasource.dart';
import 'package:flutter_draftea_challenge/features/pokedex/data/repositories_impl/pokemon_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar base de datos
  final database = AppDatabase();

  runApp(MainApp(database: database));
}

class MainApp extends StatelessWidget {
  final AppDatabase database;

  const MainApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // Inyectar el repositorio de pokemones
        RepositoryProvider(
          create: (context) => PokemonRepositoryImpl(
            localDatasource: PokemonLocalDatasourceImpl(database),
            remoteDatasource: PokemonRemoteDatasourceImpl(DioClient()),
          ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: 'Draftea Pokedex Challenge',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
