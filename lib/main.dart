import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_draftea_challenge/core/network/dio_client.dart';
import 'package:flutter_draftea_challenge/core/router/app_router.dart';
import 'package:flutter_draftea_challenge/features/pokedex/data/datasources/pokemon_local_datasource.dart';
import 'package:flutter_draftea_challenge/features/pokedex/data/datasources/pokemon_remote_datasource.dart';
import 'package:flutter_draftea_challenge/features/pokedex/data/repositories_impl/pokemon_repository_impl.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // Inyectar el repositorio de pokemones
        RepositoryProvider(
          create: (context) => PokemonRepositoryImpl(
            localDatasource: PokemonLocalDatasourceImpl(),
            remoteDatasource: PokemonRemoteDatasourceImpl(DioClient()),
          ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: 'Draftea Pokedex Challenge',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
