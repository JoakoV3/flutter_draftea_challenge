import 'package:equatable/equatable.dart';

/// Modelo para el detalle completo de un Pokemon
class PokemonDetail extends Equatable {
  final int id;
  final String name;
  final int height;
  final int weight;
  final List<String> types;
  final List<String> abilities;
  final Map<String, int> stats;
  final PokemonSprites sprites;

  const PokemonDetail({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
    required this.abilities,
    required this.stats,
    required this.sprites,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    height,
    weight,
    types,
    abilities,
    stats,
    sprites,
  ];
}

/// Modelo para los sprites del Pokemon
class PokemonSprites extends Equatable {
  final String frontDefault;
  final String? frontShiny;
  final String? officialArtwork;
  final String? dreamWorld;

  const PokemonSprites({
    required this.frontDefault,
    this.frontShiny,
    this.officialArtwork,
    this.dreamWorld,
  });

  @override
  List<Object?> get props => [
    frontDefault,
    frontShiny,
    officialArtwork,
    dreamWorld,
  ];
}
