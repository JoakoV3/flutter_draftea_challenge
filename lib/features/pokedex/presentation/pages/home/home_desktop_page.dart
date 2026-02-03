import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_draftea_challenge/core/router/routes.dart';
import 'package:flutter_draftea_challenge/core/widgets/widgets.dart';
import 'package:flutter_draftea_challenge/features/pokedex/presentation/cubit/pokemon_list/pokemon_list_cubit.dart';
import 'package:flutter_draftea_challenge/features/pokedex/presentation/cubit/pokemon_list/pokemon_list_state.dart';
import 'package:go_router/go_router.dart';

class HomeDesktopPage extends StatelessWidget {
  const HomeDesktopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/poke_logo.png', width: 130),
      ),

      body: BlocBuilder<PokemonListCubit, PokemonListState>(
        builder: (context, state) {
          return switch (state.status) {
            PokemonListStatus.initial => const Center(
              child: Text('Initializing...'),
            ),
            PokemonListStatus.loading => const PokemonLoadingWidget(
              message: 'Cargando Pokédex...',
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
      return PokemonEmptyStateWidget(
        message: 'No se encontraron Pokémones',
        subtitle: 'Intenta recargar la página',
        action: ElevatedButton.icon(
          onPressed: () => context.read<PokemonListCubit>().refresh(),
          icon: const Icon(Icons.refresh),
          label: const Text('Recargar'),
        ),
      );
    }

    const double cardWidth = 250;
    const double cardHeight = 312.5;
    const double spacing = 16;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: [
          // Generar tarjetas de Pokemon
          for (final pokemon in state.pokemons)
            SizedBox(
              width: cardWidth,
              height: cardHeight,
              child: Card(
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
                        child: Text(
                          pokemon.name.toUpperCase(),
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          // Mostrar indicador de carga al final si hay más datos
          if (state.hasMore)
            SizedBox(
              width: cardWidth,
              height: cardHeight,
              child: Builder(
                builder: (context) {
                  // Cargar más cuando se muestre el indicador
                  if (state.status != PokemonListStatus.loadingMore) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.read<PokemonListCubit>().loadMorePokemons();
                    });
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
        ],
      ),
    );
  }
}
