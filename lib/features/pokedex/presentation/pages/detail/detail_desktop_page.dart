import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_draftea_challenge/core/widgets/widgets.dart';
import 'package:flutter_draftea_challenge/features/pokedex/domain/models/pokemon_detail.dart';
import 'package:flutter_draftea_challenge/features/pokedex/presentation/cubit/pokemon_detail/pokemon_detail_cubit.dart';
import 'package:flutter_draftea_challenge/features/pokedex/presentation/cubit/pokemon_detail/pokemon_detail_state.dart';
import 'package:flutter_draftea_challenge/features/pokedex/presentation/pages/detail/widgets/detail_widgets.dart';

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
      appBar: DetailAppbar(),
      body: BlocBuilder<PokemonDetailCubit, PokemonDetailState>(
        builder: (context, state) {
          return switch (state.status) {
            PokemonDetailStatus.initial || PokemonDetailStatus.loading =>
              const PokemonLoadingWidget(message: 'Cargando Pokémon...'),
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
                    child: PokemonImage(
                      type: pokemon.types.first,
                      imageUrl:
                          pokemon.sprites.officialArtwork ??
                          pokemon.sprites.frontDefault,
                    ),
                  ),
                  const SizedBox(width: 32),
                  // Columna derecha: Información
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 24,
                      children: [
                        PokemonHeader(name: pokemon.name, id: pokemon.id),
                        PokemonTypes(types: pokemon.types),
                        IntrinsicHeight(
                          child: Row(
                            spacing: 16,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: PokemonBasicInfo(
                                  height: pokemon.height,
                                  weight: pokemon.weight,
                                  isMobile: false,
                                  titleStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: PokemonAbilities(
                                  abilities: pokemon.abilities,
                                  titleStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium
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
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              PokemonStats(stats: pokemon.stats),
            ],
          ),
        ),
      ),
    );
  }
}
