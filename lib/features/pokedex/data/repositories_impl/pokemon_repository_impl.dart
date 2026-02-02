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
    // 1. Emitir detalle local si existe (offline-first)
    final localDetail = await _localDatasource.getPokemonDetail(id);
    if (localDetail != null) {
      yield localDetail;
    }

    // 2. Obtener detalle remoto
    try {
      final remoteDetail = await _remoteDatasource.getPokemonDetail(id);

      // 3. Guardar en BD
      await _localDatasource.savePokemonDetail(remoteDetail);

      // 4. Emitir detalle remoto
      yield remoteDetail;
    } catch (e) {
      // Si falla la API y ya emitimos datos locales, no hacer nada
      // Si no hay datos locales, propagar el error
      if (localDetail == null) {
        rethrow;
      }
    }
  }

  @override
  Stream<PokemonListResponse> getPokemonList({
    required int limit,
    required int offset,
  }) async* {
    // 1. Emitir datos locales (offline-first)
    final localData = await _localDatasource.getPokemonList(
      limit: limit,
      offset: offset,
    );
    if (localData.pokemons.isNotEmpty) {
      yield localData;
    }

    // 2. Obtener datos remotos
    try {
      final remoteData = await _remoteDatasource.getPokemonList(
        limit: limit,
        offset: offset,
      );

      // 3. Guardar en BD
      await _localDatasource.savePokemonList(remoteData);

      // 4. Emitir datos remotos
      yield remoteData;
    } catch (e) {
      // Si falla la API y ya emitimos datos locales, no hacer nada
      // Si no hay datos locales, propagar el error
      if (localData.pokemons.isEmpty) {
        rethrow;
      }
    }
  }
}
