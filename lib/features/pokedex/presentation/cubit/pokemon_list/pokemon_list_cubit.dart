import 'package:bloc/bloc.dart';
import 'package:flutter_draftea_challenge/features/pokedex/domain/repositories/pokemon_repository.dart';

import 'pokemon_list_state.dart';

class PokemonListCubit extends Cubit<PokemonListState> {
  final PokemonRepository _repository;

  static const int _pageSize = 15;

  PokemonListCubit(this._repository) : super(const PokemonListState());

  /// Carga la primera página de Pokemon
  Future<void> loadPokemons() async {
    try {
      emit(state.copyWith(status: PokemonListStatus.loading));

      final response = await _repository.getPokemonList(
        limit: _pageSize,
        offset: 0,
      );

      emit(
        state.copyWith(
          status: PokemonListStatus.loaded,
          pokemons: response.pokemons,
          hasMore: response.hasMore,
          currentOffset: _pageSize,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PokemonListStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Carga más Pokemon (para scroll infinito)
  Future<void> loadMorePokemons() async {
    // Solo cargar más si estamos en estado loaded y hay más datos
    if (state.status != PokemonListStatus.loaded || !state.hasMore) {
      return;
    }

    try {
      emit(state.copyWith(status: PokemonListStatus.loadingMore));

      final response = await _repository.getPokemonList(
        limit: _pageSize,
        offset: state.currentOffset,
      );

      emit(
        state.copyWith(
          status: PokemonListStatus.loaded,
          pokemons: [...state.pokemons, ...response.pokemons],
          hasMore: response.hasMore,
          currentOffset: state.currentOffset + _pageSize,
          errorMessage: null,
        ),
      );
    } catch (e) {
      // En caso de error, volver a loaded manteniendo los datos actuales
      emit(
        state.copyWith(
          status: PokemonListStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Recarga la lista desde cero
  Future<void> refresh() async {
    await loadPokemons();
  }
}
