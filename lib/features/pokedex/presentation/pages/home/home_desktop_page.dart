import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_draftea_challenge/core/router/routes.dart';
import 'package:flutter_draftea_challenge/features/pokedex/presentation/cubit/pokemon_list/pokemon_list_cubit.dart';
import 'package:flutter_draftea_challenge/features/pokedex/presentation/cubit/pokemon_list/pokemon_list_state.dart';
import 'package:go_router/go_router.dart';

class HomeDesktopPage extends StatelessWidget {
  const HomeDesktopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokédex')),
      body: BlocBuilder<PokemonListCubit, PokemonListState>(
        builder: (context, state) {
          return switch (state.status) {
            PokemonListStatus.initial => const Center(
              child: Text('Initializing...'),
            ),
            PokemonListStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
            PokemonListStatus.loaded ||
            PokemonListStatus.loadingMore => _buildPokemonGrid(context, state),
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

  Widget _buildPokemonGrid(BuildContext context, PokemonListState state) {
    if (state.pokemons.isEmpty) {
      return const Center(child: Text('No Pokemon found'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: state.pokemons.length + (state.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        // Mostrar indicador de carga al final si hay más datos
        if (index == state.pokemons.length) {
          // Cargar más cuando llegue al final
          if (state.status != PokemonListStatus.loadingMore) {
            context.read<PokemonListCubit>().loadMorePokemons();
          }
          return const Center(child: CircularProgressIndicator());
        }

        final pokemon = state.pokemons[index];
        return Card(
          child: InkWell(
            onTap: () =>
                context.push(AppRoutes.pokemonDetailPath(id: pokemon.id)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.network(
                    pokemon.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error, size: 50),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        pokemon.name,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'ID: ${pokemon.id}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
