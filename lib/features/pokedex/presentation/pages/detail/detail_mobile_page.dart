import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_draftea_challenge/features/pokedex/domain/models/pokemon_detail.dart';
import '../../cubit/pokemon_detail/pokemon_detail_cubit.dart';
import '../../cubit/pokemon_detail/pokemon_detail_state.dart';
import 'widgets/pokemon_detail_widgets.dart';

class DetailMobilePage extends StatefulWidget {
  final int pokemonId;

  const DetailMobilePage({super.key, required this.pokemonId});

  @override
  State<DetailMobilePage> createState() => _DetailMobilePageState();
}

class _DetailMobilePageState extends State<DetailMobilePage> {
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${state.errorMessage ?? "Unknown error"}',
                      textAlign: TextAlign.center,
                    ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Imagen del Pokemon
          _PokemonImage(
            imageUrl:
                pokemon.sprites.officialArtwork ?? pokemon.sprites.frontDefault,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PokemonHeader(
                  name: pokemon.name,
                  id: pokemon.id,
                  showID: false,
                  nameStyle: Theme.of(context).textTheme.headlineLarge
                      ?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: const [
                          Shadow(offset: Offset(-2, 3), color: Colors.black),
                        ],
                        fontFamily: 'Superstar',
                      ),
                ),
                const SizedBox(height: 16),
                PokemonTypes(types: pokemon.types, fontSize: 12),
                const SizedBox(height: 16),
                PokemonBasicInfo(
                  height: pokemon.height,
                  weight: pokemon.weight,
                  isMobile: true,
                  titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                PokemonAbilities(
                  abilities: pokemon.abilities,
                  titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  iconSize: 14,
                  fontSize: 12,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  borderRadius: 16,
                ),
                const SizedBox(height: 16),
                PokemonStats(
                  stats: pokemon.stats,
                  titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  labelStyle: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                  valueStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                  spacing: 10,
                  minHeight: 6,
                  borderRadius: 4,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PokemonImage extends StatelessWidget {
  final String imageUrl;

  const _PokemonImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.catching_pokemon, size: 150, color: Colors.grey),
        ),
      ),
    );
  }
}
