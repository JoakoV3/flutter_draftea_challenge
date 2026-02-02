import 'package:bloc/bloc.dart';
import 'package:flutter_draftea_challenge/features/pokedex/domain/models/pokemon_list_item.dart';
import 'package:flutter_draftea_challenge/features/pokedex/domain/repositories/pokemon_repository.dart';

import 'pokemon_list_state.dart';

class PokemonListCubit extends Cubit<PokemonListState> {
  final PokemonRepository _repository;

  static const int _pageSize = 20;

  PokemonListCubit(this._repository) : super(const PokemonListState());

  /// Carga la primera página de Pokemon
  Future<void> loadPokemons() async {
    // Evitar múltiples llamadas simultáneas o recargar si ya hay datos
    if (state.status == PokemonListStatus.loading ||
        state.status == PokemonListStatus.loadingMore) {
      return;
    }

    // Si ya hay datos cargados, no recargar (usar refresh() para forzar recarga)
    if (state.pokemons.isNotEmpty && state.status == PokemonListStatus.loaded) {
      return;
    }

    try {
      emit(state.copyWith(status: PokemonListStatus.loading));

      // await for itera sobre cada emisión del Stream
      // Primero: datos locales (si existen)
      // Segundo: datos remotos (sobrescribe los locales)
      await for (final response in _repository.getPokemonList(
        limit: _pageSize,
        offset: 0,
      )) {
        emit(
          state.copyWith(
            status: PokemonListStatus.loaded,
            pokemons: response.pokemons,
            hasMore: response.hasMore,
            currentOffset: _pageSize,
            errorMessage: null,
          ),
        );
      }
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

      // Guardar la lista actual para mantenerla durante las emisiones
      final previousPokemons = state.pokemons;
      final newOffset = state.currentOffset;

      // await for itera sobre cada emisión del Stream
      // Primera emisión: datos locales de esta página (si existen)
      // Segunda emisión: datos remotos de esta página (sobrescribe)
      // Usamos merge por ID para evitar duplicados
      await for (final response in _repository.getPokemonList(
        limit: _pageSize,
        offset: newOffset,
      )) {
        // Merge inteligente: actualiza por ID en lugar de solo concatenar
        final mergedPokemons = _mergePokemonLists(
          previousPokemons,
          response.pokemons,
        );

        emit(
          state.copyWith(
            status: PokemonListStatus.loaded,
            pokemons: mergedPokemons,
            hasMore: response.hasMore,
            currentOffset: newOffset + _pageSize,
            errorMessage: null,
          ),
        );
      }
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

  /// Merge inteligente de listas de Pokemon por ID
  /// Los nuevos Pokemon sobrescriben los existentes con el mismo ID
  /// y se agregan los que no existen
  List<PokemonListItem> _mergePokemonLists(
    List<PokemonListItem> existing,
    List<PokemonListItem> newPokemons,
  ) {
    // Crear un mapa con los pokemon existentes indexados por ID
    final Map<int, PokemonListItem> pokemonMap = {
      for (var pokemon in existing) pokemon.id: pokemon,
    };

    // Actualizar/agregar los nuevos pokemon
    for (var pokemon in newPokemons) {
      pokemonMap[pokemon.id] = pokemon;
    }

    // Convertir de vuelta a lista
    final mergedList = pokemonMap.values.toList();

    return mergedList;
  }
}
