import 'package:flutter_draftea_challenge/features/pokedex/data/models/pokemon_detail.dart';
import 'package:flutter_draftea_challenge/features/pokedex/data/models/pokemon_list_response.dart';
import 'package:flutter_draftea_challenge/features/pokedex/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  @override
  Future<PokemonDetail> getPokemonDetail(int id) {
    // TODO: implement getPokemonDetail
    throw UnimplementedError();
  }

  @override
  Future<PokemonListResponse> getPokemonList({
    required int limit,
    required int offset,
  }) {
    // TODO: implement getPokemonList
    throw UnimplementedError();
  }

  /// Extrae el ID de la URL del Pokemon
  /// Ejemplo: "https://pokeapi.co/api/v2/pokemon/1/" -> 1
  int _extractIdFromUrl(String url) {
    return int.parse(url.split('/').reversed.elementAt(1));
  }

  /// Construye la URL de la imagen oficial del Pokemon
  String _buildImageUrl(int id) {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
  }
}
