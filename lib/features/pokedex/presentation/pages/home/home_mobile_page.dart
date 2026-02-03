import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_draftea_challenge/core/router/routes.dart';
import 'package:flutter_draftea_challenge/core/widgets/widgets.dart';
import 'package:flutter_draftea_challenge/features/pokedex/presentation/cubit/pokemon_list/pokemon_list_cubit.dart';
import 'package:flutter_draftea_challenge/features/pokedex/presentation/cubit/pokemon_list/pokemon_list_state.dart';
import 'package:go_router/go_router.dart';

class HomeMobilePage extends StatelessWidget {
  const HomeMobilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokédex')),
      body: BlocBuilder<PokemonListCubit, PokemonListState>(
        builder: (context, state) {
          return switch (state.status) {
            PokemonListStatus.initial || PokemonListStatus.loading =>
              const PokemonLoadingWidget(message: 'Cargando Pokédex...'),
            PokemonListStatus.loaded ||
            PokemonListStatus.loadingMore => _buildPokemonList(context, state),
            PokemonListStatus.error => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.errorMessage}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<PokemonListCubit>().refresh(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          };
        },
      ),
    );
  }

  Widget _buildPokemonList(BuildContext context, PokemonListState state) {
    if (state.pokemons.isEmpty) {
      return const Center(child: Text('No Pokemon found'));
    }

    return ListView.builder(
      itemCount: state.pokemons.length + (state.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        // Mostrar indicador de carga al final si hay más datos
        if (index == state.pokemons.length) {
          // Cargar más cuando llegue al final
          if (state.status != PokemonListStatus.loadingMore) {
            context.read<PokemonListCubit>().loadMorePokemons();
          }
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final pokemon = state.pokemons[index];
        return ListTile(
          leading: Image.network(
            pokemon.imageUrl,
            width: 50,
            height: 50,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error),
          ),
          title: Text(pokemon.name),
          onTap: () =>
              context.push(AppRoutes.pokemonDetailPath(id: pokemon.id)),
        );
      },
    );
  }
}
