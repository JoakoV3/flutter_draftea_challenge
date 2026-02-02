import 'package:bloc/bloc.dart';
import 'package:flutter_draftea_challenge/features/pokedex/domain/repositories/pokemon_repository.dart';

import 'pokemon_detail_state.dart';

class PokemonDetailCubit extends Cubit<PokemonDetailState> {
  final PokemonRepository _repository;

  PokemonDetailCubit(this._repository) : super(const PokemonDetailState());

  /// Carga el detalle de un Pokemon por ID
  Future<void> loadPokemonById(int id) async {
    try {
      emit(state.copyWith(status: PokemonDetailStatus.loading));

      // Escuchar el stream del repositorio (emite local primero, luego remoto)
      await for (final pokemon in _repository.getPokemonDetail(id)) {
        emit(
          state.copyWith(
            status: PokemonDetailStatus.loaded,
            pokemon: pokemon,
            errorMessage: null,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: PokemonDetailStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Alterna el estado de favorito del Pokemon actual
  Future<void> toggleFavorite() async {
    if (state.pokemon == null) {
      return;
    }

    try {
      final newFavoriteStatus = !state.isFavorite;

      // TODO: Actualizar en la base de datos local
      // if (newFavoriteStatus) {
      //   await _repository.addToFavorites(state.pokemon!);
      // } else {
      //   await _repository.removeFromFavorites(state.pokemon!.id);
      // }

      emit(state.copyWith(isFavorite: newFavoriteStatus));
    } catch (e) {
      // En caso de error, mantener el estado actual
      // Opcionalmente podrías emitir un estado de error o mostrar un snackbar
    }
  }

  /// Recarga el Pokemon actual
  Future<void> refresh() async {
    if (state.pokemon != null) {
      await loadPokemonById(state.pokemon!.id);
    }
  }
}
