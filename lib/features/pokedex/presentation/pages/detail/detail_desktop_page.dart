import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_draftea_challenge/features/pokedex/domain/models/pokemon_detail.dart';
import '../../cubit/pokemon_detail/pokemon_detail_cubit.dart';
import '../../cubit/pokemon_detail/pokemon_detail_state.dart';
import 'widgets/pokemon_detail_widgets.dart';

class DetailDesktopPage extends StatefulWidget {
  final int pokemonId;

  const DetailDesktopPage({super.key, required this.pokemonId});

  @override
  State<DetailDesktopPage> createState() => _DetailDesktopPageState();
}

class _DetailDesktopPageState extends State<DetailDesktopPage> {
  @override
  void initState() {
    super.initState();
    context.read<PokemonDetailCubit>().loadPokemonById(widget.pokemonId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // TODO: Implementar funcionalidad de favoritos
            },
          ),
        ],
      ),
      body: BlocBuilder<PokemonDetailCubit, PokemonDetailState>(
        builder: (context, state) {
          return switch (state.status) {
            PokemonDetailStatus.initial || PokemonDetailStatus.loading =>
              const Center(child: CircularProgressIndicator()),
            PokemonDetailStatus.error => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${state.errorMessage ?? "Unknown error"}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context
                        .read<PokemonDetailCubit>()
                        .loadPokemonById(widget.pokemonId),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
            PokemonDetailStatus.loaded => _PokemonDetailContent(
              pokemon: state.pokemon!,
            ),
          };
        },
      ),
    );
  }
}

class _PokemonDetailContent extends StatelessWidget {
  final PokemonDetail pokemon;

  const _PokemonDetailContent({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Columna izquierda: Imagen
                  Expanded(
                    flex: 2,
                    child: _PokemonImage(
                      imageUrl:
                          pokemon.sprites.officialArtwork ??
                          pokemon.sprites.frontDefault,
                    ),
                  ),
                  const SizedBox(width: 32),
                  // Columna derecha: Información
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PokemonHeader(name: pokemon.name, id: pokemon.id),
                        const SizedBox(height: 24),
                        PokemonTypes(types: pokemon.types),
                        const SizedBox(height: 24),
                        PokemonBasicInfo(
                          height: pokemon.height,
                          weight: pokemon.weight,
                          isMobile: false,
                        ),
                        const SizedBox(height: 24),
                        PokemonAbilities(abilities: pokemon.abilities),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
              PokemonStats(stats: pokemon.stats),
            ],
          ),
        ),
      ),
    );
  }
}

class _PokemonImage extends StatelessWidget {
  final String imageUrl;

  const _PokemonImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.catching_pokemon, size: 200, color: Colors.grey),
        ),
      ),
    );
  }
}
