import 'package:equatable/equatable.dart';
import 'package:flutter_draftea_challenge/features/pokedex/data/models/pokemon_list_item.dart';

/// Respuesta de la lista de Pokemon con metadata de paginación
class PokemonListResponse extends Equatable {
  /// Lista de Pokemon en esta página
  final List<PokemonListItem> pokemons;

  /// Indica si hay más Pokemon disponibles para cargar
  final bool hasMore;

  /// Total de Pokemon disponibles (opcional)
  final int? total;

  const PokemonListResponse({
    required this.pokemons,
    required this.hasMore,
    this.total,
  });

  @override
  List<Object?> get props => [pokemons, hasMore, total];
}
