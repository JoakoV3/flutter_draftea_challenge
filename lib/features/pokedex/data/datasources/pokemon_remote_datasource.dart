import 'package:flutter_draftea_challenge/core/network/dio_client.dart';
import 'package:flutter_draftea_challenge/features/pokedex/data/models/pokemon_detail.dart';
import 'package:flutter_draftea_challenge/features/pokedex/data/models/pokemon_list_response.dart';

/// DataSource remoto para obtener datos de Pokemon desde la API
abstract interface class PokemonRemoteDatasource {
  Future<PokemonListResponse> getPokemonList({
    required int limit,
    required int offset,
  });

  Future<PokemonDetail> getPokemonDetail(int id);
}

class PokemonRemoteDatasourceImpl implements PokemonRemoteDatasource {
  final DioClient _httpClient;

  PokemonRemoteDatasourceImpl(this._httpClient);

  @override
  Future<PokemonListResponse> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    final url = '/pokemon?limit=$limit&offset=$offset';
    final response = await _httpClient.get(url);
    return PokemonListResponse.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<PokemonDetail> getPokemonDetail(int id) async {
    final url = '/pokemon/$id';
    final response = await _httpClient.get(url);
    return PokemonDetail.fromJson(response as Map<String, dynamic>);
  }
}
