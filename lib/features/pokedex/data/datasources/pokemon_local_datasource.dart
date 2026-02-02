import 'package:flutter_draftea_challenge/features/pokedex/domain/models/pokemon_list_response.dart';

abstract interface class PokemonLocalDatasource {
  Future<void> savePokemonList(PokemonListResponse pokemonList);

  Future<PokemonListResponse> getPokemonList();
}

//TODO: Implementar
class PokemonLocalDatasourceImpl implements PokemonLocalDatasource {
  @override
  Future<void> savePokemonList(PokemonListResponse pokemonList) async {
    return;
  }

  @override
  Future<PokemonListResponse> getPokemonList() async {
    return PokemonListResponse(pokemons: [], hasMore: false);
  }
}
