import 'package:flutter_draftea_challenge/features/pokedex/domain/models/pokemon_detail.dart';
import 'package:flutter_draftea_challenge/features/pokedex/domain/models/pokemon_list_response.dart';

abstract interface class PokemonRepository {
  /// Obtener la lista de pokemons con offset y limit
  Stream<PokemonListResponse> getPokemonList({
    required int limit,
    required int offset,
  });

  /// Obtener el detalle de un pokemon por id
  Stream<PokemonDetail> getPokemonDetail(int id);
}
