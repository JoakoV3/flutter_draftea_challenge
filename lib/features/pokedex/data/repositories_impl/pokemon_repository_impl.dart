import 'package:flutter_draftea_challenge/features/pokedex/data/datasources/pokemon_local_datasource.dart';
import 'package:flutter_draftea_challenge/features/pokedex/data/datasources/pokemon_remote_datasource.dart';
import 'package:flutter_draftea_challenge/features/pokedex/domain/models/pokemon_detail.dart';
import 'package:flutter_draftea_challenge/features/pokedex/domain/models/pokemon_list_response.dart';
import 'package:flutter_draftea_challenge/features/pokedex/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDatasource _remoteDatasource;
  final PokemonLocalDatasource _localDatasource;

  PokemonRepositoryImpl({
    required PokemonRemoteDatasource remoteDatasource,
    required PokemonLocalDatasource localDatasource,
  }) : _remoteDatasource = remoteDatasource,
       _localDatasource = localDatasource;

  @override
  Stream<PokemonDetail> getPokemonDetail(int id) async* {
    //TODO: Implementar llamada a local
    final response = await _remoteDatasource.getPokemonDetail(id);
    yield response;
  }

  @override
  Stream<PokemonListResponse> getPokemonList({
    required int limit,
    required int offset,
  }) async* {
    //TODO: Implementar llamada a local
    final response = await _remoteDatasource.getPokemonList(
      limit: limit,
      offset: offset,
    );
    yield response;
  }
}
