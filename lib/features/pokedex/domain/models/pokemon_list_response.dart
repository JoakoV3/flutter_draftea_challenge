import 'package:equatable/equatable.dart';
import 'package:flutter_draftea_challenge/features/pokedex/domain/models/pokemon_list_item.dart';

/// Respuesta de la lista de Pokemon con metadata de paginación
class PokemonListResponse extends Equatable {
  /// Lista de Pokemon en esta página
  final List<PokemonListItem> pokemons;

  /// Indica si hay más Pokemon disponibles para cargar
  final bool hasMore;

  /// Total de Pokemon disponibles (opcional)
  final int? count;

  const PokemonListResponse({
    required this.pokemons,
    required this.hasMore,
    this.count,
  });

  @override
  List<Object?> get props => [pokemons, hasMore, count];

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) {
    return PokemonListResponse(
      pokemons: List<PokemonListItem>.from(
        json['results'].map((x) => PokemonListItem.fromJson(x)),
      ),
      hasMore: json['next'] != null,
      count: json['count'],
    );
  }
}
