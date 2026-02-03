import 'package:drift/native.dart';
import 'package:flutter_draftea_challenge/core/persistence/app_database.dart';
import 'package:flutter_draftea_challenge/features/pokedex/data/datasources/pokemon_local_datasource.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/pokemon_fixtures.dart';

void main() {
  late AppDatabase database;
  late PokemonLocalDatasourceImpl localDatasource;

  setUp(() {
    // Crear base de datos en memoria para cada test
    database = AppDatabase(NativeDatabase.memory());
    localDatasource = PokemonLocalDatasourceImpl(database);
  });

  tearDown(() async {
    // Cerrar la base de datos después de cada test
    await database.close();
  });

  group('PokemonLocalDatasource', () {
    group('savePokemonList y getPokemonList', () {
      test('debe guardar y recuperar lista de Pokemon correctamente', () async {
        // Arrange
        final pokemonList = PokemonFixtures.pokemonListResponse;

        // Act - Guardar
        await localDatasource.savePokemonList(pokemonList);

        // Act - Recuperar
        final result = await localDatasource.getPokemonList();

        // Assert
        expect(result.pokemons, isNotEmpty);
        expect(result.pokemons.length, 3);
        expect(result.pokemons.first.name, 'bulbasaur');
        expect(result.pokemons.first.id, 1);
        expect(result.count, 3);
        expect(result.hasMore, false); // No hay más porque recuperamos todo
      });

      test(
        'debe retornar lista vacía cuando la base de datos está vacía',
        () async {
          // Act
          final result = await localDatasource.getPokemonList();

          // Assert
          expect(result.pokemons, isEmpty);
          expect(result.count, 0);
          expect(result.hasMore, false);
        },
      );

      test(
        'debe manejar paginación correctamente con limit y offset',
        () async {
          // Arrange - Guardar datos
          await localDatasource.savePokemonList(
            PokemonFixtures.pokemonListResponse,
          );

          // Act - Obtener primera página (2 elementos)
          final firstPage = await localDatasource.getPokemonList(
            limit: 2,
            offset: 0,
          );

          // Assert - Primera página
          expect(firstPage.pokemons.length, 2);
          expect(firstPage.pokemons.first.name, 'bulbasaur');
          expect(firstPage.hasMore, true); // Hay más datos
          expect(firstPage.count, 3);

          // Act - Obtener segunda página
          final secondPage = await localDatasource.getPokemonList(
            limit: 2,
            offset: 2,
          );

          // Assert - Segunda página
          expect(secondPage.pokemons.length, 1);
          expect(secondPage.pokemons.first.name, 'venusaur');
          expect(secondPage.hasMore, false); // No hay más datos
        },
      );

      test('debe ordenar Pokemon por ID ascendente', () async {
        // Arrange - Guardar en orden aleatorio
        await localDatasource.savePokemonList(
          PokemonFixtures.pokemonListResponse,
        );

        // Act
        final result = await localDatasource.getPokemonList();

        // Assert - Verificar orden
        expect(result.pokemons[0].id, 1);
        expect(result.pokemons[1].id, 2);
        expect(result.pokemons[2].id, 3);
      });

      test(
        'debe actualizar Pokemon existente sin sobrescribir datos de detalle',
        () async {
          // Arrange - Guardar detalle completo primero
          final detail = PokemonFixtures.pokemonDetail;
          await localDatasource.savePokemonDetail(detail);

          // Act - Guardar lista (solo datos básicos)
          await localDatasource.savePokemonList(
            PokemonFixtures.pokemonListResponse,
          );

          // Assert - Verificar que el detalle sigue existiendo
          final savedDetail = await localDatasource.getPokemonDetail(1);
          expect(savedDetail, isNotNull);
          expect(savedDetail!.height, 7); // Datos de detalle preservados
          expect(savedDetail.weight, 69);
        },
      );
    });

    group('savePokemonDetail y getPokemonDetail', () {
      test('debe guardar y recuperar detalle completo de Pokemon', () async {
        // Arrange
        final detail = PokemonFixtures.pokemonDetail;

        // Act - Guardar
        await localDatasource.savePokemonDetail(detail);

        // Act - Recuperar
        final result = await localDatasource.getPokemonDetail(1);

        // Assert
        expect(result, isNotNull);
        expect(result!.id, 1);
        expect(result.name, 'bulbasaur');
        expect(result.height, 7);
        expect(result.weight, 69);
        expect(result.types, ['grass', 'poison']);
        expect(result.abilities, ['overgrow']);
        expect(result.stats['hp'], 45);
        expect(result.sprites.frontDefault, isNotEmpty);
      });

      test('debe retornar null cuando el Pokemon no existe', () async {
        // Act
        final result = await localDatasource.getPokemonDetail(999);

        // Assert
        expect(result, isNull);
      });

      test(
        'debe retornar null cuando el Pokemon no tiene datos completos',
        () async {
          // Arrange - Guardar solo datos básicos (sin detalle)
          await localDatasource.savePokemonList(
            PokemonFixtures.pokemonListResponse,
          );

          // Act - Intentar obtener detalle
          final result = await localDatasource.getPokemonDetail(1);

          // Assert - Debe retornar null porque no tiene datos completos
          expect(result, isNull);
        },
      );

      test(
        'debe actualizar Pokemon existente con nuevos datos de detalle',
        () async {
          // Arrange - Guardar datos básicos primero
          await localDatasource.savePokemonList(
            PokemonFixtures.pokemonListResponse,
          );

          // Act - Guardar detalle completo
          final detail = PokemonFixtures.pokemonDetail;
          await localDatasource.savePokemonDetail(detail);

          // Act - Recuperar
          final result = await localDatasource.getPokemonDetail(1);

          // Assert - Ahora debe tener datos completos
          expect(result, isNotNull);
          expect(result!.height, 7);
          expect(result.weight, 69);
          expect(result.types, isNotEmpty);
        },
      );

      test(
        'debe serializar y deserializar correctamente los sprites',
        () async {
          // Arrange
          final detail = PokemonFixtures.pokemonDetail;

          // Act
          await localDatasource.savePokemonDetail(detail);
          final result = await localDatasource.getPokemonDetail(1);

          // Assert - Verificar todos los sprites
          expect(result!.sprites.frontDefault, detail.sprites.frontDefault);
          expect(result.sprites.frontShiny, detail.sprites.frontShiny);
          expect(
            result.sprites.officialArtwork,
            detail.sprites.officialArtwork,
          );
          expect(result.sprites.dreamWorld, detail.sprites.dreamWorld);
        },
      );

      test(
        'debe serializar y deserializar correctamente las estadísticas',
        () async {
          // Arrange
          final detail = PokemonFixtures.pokemonDetail;

          // Act
          await localDatasource.savePokemonDetail(detail);
          final result = await localDatasource.getPokemonDetail(1);

          // Assert - Verificar todas las stats
          expect(result!.stats['hp'], 45);
          expect(result.stats['attack'], 49);
          expect(result.stats['defense'], 49);
          expect(result.stats['special-attack'], 65);
          expect(result.stats['special-defense'], 65);
          expect(result.stats['speed'], 45);
        },
      );
    });

    group('Casos edge', () {
      test('debe manejar múltiples guardados del mismo Pokemon', () async {
        // Arrange
        final detail = PokemonFixtures.pokemonDetail;

        // Act - Guardar múltiples veces
        await localDatasource.savePokemonDetail(detail);
        await localDatasource.savePokemonDetail(detail);
        await localDatasource.savePokemonDetail(detail);

        // Assert - Solo debe haber un registro
        final allPokemon = await localDatasource.getPokemonList();
        expect(allPokemon.count, 1);

        final savedDetail = await localDatasource.getPokemonDetail(1);
        expect(savedDetail, isNotNull);
      });

      test('debe manejar límite de 0 correctamente', () async {
        // Arrange
        await localDatasource.savePokemonList(
          PokemonFixtures.pokemonListResponse,
        );

        // Act
        final result = await localDatasource.getPokemonList(limit: 0);

        // Assert - Debe retornar lista vacía
        expect(result.pokemons, isEmpty);
      });

      test('debe manejar offset mayor que el total de registros', () async {
        // Arrange
        await localDatasource.savePokemonList(
          PokemonFixtures.pokemonListResponse,
        );

        // Act
        final result = await localDatasource.getPokemonList(
          limit: 10,
          offset: 100,
        );

        // Assert
        expect(result.pokemons, isEmpty);
        expect(result.hasMore, false);
      });
    });
  });
}
