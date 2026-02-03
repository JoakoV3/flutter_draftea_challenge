import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_draftea_challenge/core/widgets/pokemon_loading_widget.dart';
import 'package:flutter_draftea_challenge/features/pokedex/domain/models/pokemon_detail.dart';
import '../../cubit/pokemon_detail/pokemon_detail_cubit.dart';
import '../../cubit/pokemon_detail/pokemon_detail_state.dart';
import 'widgets/detail_widgets.dart';

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
      appBar: DetailAppbar(),
      body: BlocBuilder<PokemonDetailCubit, PokemonDetailState>(
        builder: (context, state) {
          return switch (state.status) {
            PokemonDetailStatus.initial || PokemonDetailStatus.loading =>
              const PokemonLoadingWidget(message: 'Cargando Pokémon...'),
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
          PokemonImage(
            imageUrl:
                pokemon.sprites.officialArtwork ?? pokemon.sprites.frontDefault,
            type: pokemon.types.first,
            isMobile: true,
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
                ),
                const SizedBox(height: 16),
                PokemonTypes(types: pokemon.types, fontSize: 12),
                const SizedBox(height: 16),
                IntrinsicHeight(
                  child: Row(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: PokemonBasicInfo(
                          height: pokemon.height,
                          weight: pokemon.weight,
                          isMobile: true,
                          titleStyle: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: PokemonAbilities(
                          abilities: pokemon.abilities,
                          titleStyle: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          iconSize: 14,
                          fontSize: 12,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          borderRadius: 16,
                        ),
                      ),
                    ],
                  ),
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
