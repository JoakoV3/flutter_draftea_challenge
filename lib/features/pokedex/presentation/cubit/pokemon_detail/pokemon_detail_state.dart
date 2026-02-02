import 'package:equatable/equatable.dart';
import '../../../domain/models/pokemon_detail.dart';

/// Enum para los diferentes estados del cubit
enum PokemonDetailStatus { initial, loading, loaded, error }

/// Estado inmutable del cubit de detalle de Pokemon
class PokemonDetailState extends Equatable {
  final PokemonDetailStatus status;
  final PokemonDetail? pokemon;
  final String? errorMessage;

  const PokemonDetailState({
    this.status = PokemonDetailStatus.initial,
    this.pokemon,
    this.errorMessage,
  });

  PokemonDetailState copyWith({
    PokemonDetailStatus? status,
    PokemonDetail? pokemon,
    String? errorMessage,
  }) {
    return PokemonDetailState(
      status: status ?? this.status,
      pokemon: pokemon ?? this.pokemon,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, pokemon, errorMessage];
}
