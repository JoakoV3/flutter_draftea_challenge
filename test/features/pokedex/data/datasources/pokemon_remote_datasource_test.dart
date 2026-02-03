import 'package:flutter_draftea_challenge/core/network/dio_client.dart';
import 'package:flutter_draftea_challenge/core/network/network_exceptions.dart';
import 'package:flutter_draftea_challenge/features/pokedex/data/datasources/pokemon_remote_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/pokemon_fixtures.dart';

// Mock de DioClient
class MockDioClient extends Mock implements DioClient {}

void main() {
  late PokemonRemoteDatasourceImpl datasource;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    datasource = PokemonRemoteDatasourceImpl(mockDioClient);
  });

  group('PokemonRemoteDatasource', () {
    group('getPokemonList', () {
      const limit = 20;
      const offset = 0;
      const url = '/pokemon?limit=$limit&offset=$offset';

      test(
        'debe retornar PokemonListResponse cuando la llamada es exitosa',
        () async {
          // Arrange - Configurar el mock para retornar datos exitosos
          when(() => mockDioClient.get(url)).thenAnswer(
            (_) async => PokemonFixtures.createSuccessResponse(
              PokemonFixtures.pokemonListJson,
            ),
          );

          // Act - Ejecutar el método a probar
          final result = await datasource.getPokemonList(
            limit: limit,
            offset: offset,
          );

          // Assert - Verificar resultados
          expect(result.pokemons, isNotEmpty);
          expect(result.pokemons.length, 3);
          expect(result.pokemons.first.name, 'bulbasaur');
          expect(result.pokemons.first.id, 1);
          expect(result.hasMore, true);
          expect(result.count, 1302);

          // Verificar que se llamó al método correcto
          verify(() => mockDioClient.get(url)).called(1);
        },
      );

      test('debe lanzar NetworkException cuando falla la conexión', () async {
        // Arrange - Configurar el mock para lanzar excepción
        when(
          () => mockDioClient.get(url),
        ).thenThrow(NoInternetConnectionException());

        // Act & Assert - Verificar que se lanza la excepción
        expect(
          () => datasource.getPokemonList(limit: limit, offset: offset),
          throwsA(isA<NoInternetConnectionException>()),
        );

        verify(() => mockDioClient.get(url)).called(1);
      });

      test(
        'debe construir la URL correctamente con diferentes parámetros',
        () async {
          // Arrange
          const customLimit = 50;
          const customOffset = 100;
          const customUrl = '/pokemon?limit=$customLimit&offset=$customOffset';

          when(() => mockDioClient.get(customUrl)).thenAnswer(
            (_) async => PokemonFixtures.createSuccessResponse(
              PokemonFixtures.pokemonListJson,
            ),
          );

          // Act
          await datasource.getPokemonList(
            limit: customLimit,
            offset: customOffset,
          );

          // Assert - Verificar que se llamó con la URL correcta
          verify(() => mockDioClient.get(customUrl)).called(1);
        },
      );
    });

    group('getPokemonDetail', () {
      const pokemonId = 1;
      const url = '/pokemon/$pokemonId';

      test(
        'debe retornar PokemonDetail cuando la llamada es exitosa',
        () async {
          // Arrange
          when(() => mockDioClient.get(url)).thenAnswer(
            (_) async => PokemonFixtures.createSuccessResponse(
              PokemonFixtures.pokemonDetailJson,
            ),
          );

          // Act
          final result = await datasource.getPokemonDetail(pokemonId);

          // Assert
          expect(result.id, 1);
          expect(result.name, 'bulbasaur');
          expect(result.height, 7);
          expect(result.weight, 69);
          expect(result.types, ['grass', 'poison']);
          expect(result.abilities, ['overgrow']);
          expect(result.stats['hp'], 45);
          expect(result.sprites.frontDefault, isNotEmpty);

          verify(() => mockDioClient.get(url)).called(1);
        },
      );

      test('debe lanzar NetworkException cuando falla la conexión', () async {
        // Arrange
        when(
          () => mockDioClient.get(url),
        ).thenThrow(ConnectionTimeoutException());

        // Act & Assert
        expect(
          () => datasource.getPokemonDetail(pokemonId),
          throwsA(isA<ConnectionTimeoutException>()),
        );

        verify(() => mockDioClient.get(url)).called(1);
      });

      test(
        'debe lanzar BadResponseException cuando el servidor retorna error',
        () async {
          // Arrange
          when(() => mockDioClient.get(url)).thenThrow(
            BadResponseException(message: 'Not Found', statusCode: 404),
          );

          // Act & Assert
          expect(
            () => datasource.getPokemonDetail(pokemonId),
            throwsA(isA<BadResponseException>()),
          );

          verify(() => mockDioClient.get(url)).called(1);
        },
      );

      test('debe construir la URL correctamente con diferentes IDs', () async {
        // Arrange
        const id = 25; // Pikachu
        const url = '/pokemon/$id';

        when(() => mockDioClient.get(url)).thenAnswer(
          (_) async => PokemonFixtures.createSuccessResponse(
            PokemonFixtures.pokemonDetailJson,
          ),
        );

        // Act
        await datasource.getPokemonDetail(id);

        // Assert
        verify(() => mockDioClient.get(url)).called(1);
      });
    });
  });
}
