import 'package:equatable/equatable.dart';
import '../../../domain/models/pokemon_list_item.dart';

/// Enum para los diferentes estados del cubit
enum PokemonListStatus { initial, loading, loaded, loadingMore, error }

/// Estado inmutable del cubit de lista de Pokemon
class PokemonListState extends Equatable {
  final PokemonListStatus status;
  final List<PokemonListItem> pokemons;
  final bool hasMore;
  final int currentOffset;
  final String? errorMessage;

  const PokemonListState({
    this.status = PokemonListStatus.initial,
    this.pokemons = const [],
    this.hasMore = true,
    this.currentOffset = 0,
    this.errorMessage,
  });

  PokemonListState copyWith({
    PokemonListStatus? status,
    List<PokemonListItem>? pokemons,
    bool? hasMore,
    int? currentOffset,
    String? errorMessage,
  }) {
    return PokemonListState(
      status: status ?? this.status,
      pokemons: pokemons ?? this.pokemons,
      hasMore: hasMore ?? this.hasMore,
      currentOffset: currentOffset ?? this.currentOffset,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    pokemons,
    hasMore,
    currentOffset,
    errorMessage,
  ];
}
