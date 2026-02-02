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

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      id: json['id'] as int,
      name: json['name'] as String,
      height: json['height'] as int,
      weight: json['weight'] as int,
      types: _extractTypes(json['types'] as List),
      abilities: _extractAbilities(json['abilities'] as List),
      stats: _extractStats(json['stats'] as List),
      sprites: PokemonSprites.fromJson(json['sprites'] as Map<String, dynamic>),
    );
  }

  /// Extrae los tipos del Pokemon del JSON
  /// Ejemplo: [{"type": {"name": "grass"}}, ...] -> ["grass", ...]
  static List<String> _extractTypes(List types) {
    return types.map((type) => type['type']['name'] as String).toList();
  }

  /// Extrae las habilidades del Pokemon del JSON
  /// Ejemplo: [{"ability": {"name": "overgrow"}}, ...] -> ["overgrow", ...]
  static List<String> _extractAbilities(List abilities) {
    return abilities
        .where((ability) => !(ability['is_hidden'] as bool))
        .map((ability) => ability['ability']['name'] as String)
        .toList();
  }

  /// Extrae las estadísticas del Pokemon del JSON
  /// Ejemplo: [{"stat": {"name": "hp"}, "base_stat": 45}, ...] -> {"hp": 45, ...}
  static Map<String, int> _extractStats(List stats) {
    final Map<String, int> statsMap = {};
    for (var stat in stats) {
      final statName = stat['stat']['name'] as String;
      final baseStat = stat['base_stat'] as int;
      statsMap[statName] = baseStat;
    }
    return statsMap;
  }
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

  factory PokemonSprites.fromJson(Map<String, dynamic> json) {
    // Extraer sprites anidados
    final other = json['other'] as Map<String, dynamic>?;

    return PokemonSprites(
      frontDefault: json['front_default'] as String? ?? '',
      frontShiny: json['front_shiny'] as String?,
      officialArtwork: other?['official-artwork']?['front_default'] as String?,
      dreamWorld: other?['dream_world']?['front_default'] as String?,
    );
  }
}
