import 'package:dio/dio.dart';
import 'package:flutter_draftea_challenge/features/pokedex/domain/models/pokemon_detail.dart';
import 'package:flutter_draftea_challenge/features/pokedex/domain/models/pokemon_list_item.dart';
import 'package:flutter_draftea_challenge/features/pokedex/domain/models/pokemon_list_response.dart';

/// Fixtures de datos de prueba para tests de Pokemon
class PokemonFixtures {
  // Modelos de datos para test Remote
  static Map<String, dynamic> pokemonListJson = {
    'count': 1302,
    'next': 'https://pokeapi.co/api/v2/pokemon?offset=20&limit=20',
    'previous': null,
    'results': [
      {'name': 'bulbasaur', 'url': 'https://pokeapi.co/api/v2/pokemon/1/'},
      {'name': 'ivysaur', 'url': 'https://pokeapi.co/api/v2/pokemon/2/'},
      {'name': 'venusaur', 'url': 'https://pokeapi.co/api/v2/pokemon/3/'},
    ],
  };

  static Map<String, dynamic> pokemonDetailJson = {
    'id': 1,
    'name': 'bulbasaur',
    'height': 7,
    'weight': 69,
    'types': [
      {
        'slot': 1,
        'type': {'name': 'grass', 'url': 'https://pokeapi.co/api/v2/type/12/'},
      },
      {
        'slot': 2,
        'type': {'name': 'poison', 'url': 'https://pokeapi.co/api/v2/type/4/'},
      },
    ],
    'abilities': [
      {
        'is_hidden': false,
        'slot': 1,
        'ability': {
          'name': 'overgrow',
          'url': 'https://pokeapi.co/api/v2/ability/65/',
        },
      },
      {
        'is_hidden': true,
        'slot': 3,
        'ability': {
          'name': 'chlorophyll',
          'url': 'https://pokeapi.co/api/v2/ability/34/',
        },
      },
    ],
    'stats': [
      {
        'base_stat': 45,
        'effort': 0,
        'stat': {'name': 'hp', 'url': 'https://pokeapi.co/api/v2/stat/1/'},
      },
      {
        'base_stat': 49,
        'effort': 0,
        'stat': {'name': 'attack', 'url': 'https://pokeapi.co/api/v2/stat/2/'},
      },
      {
        'base_stat': 49,
        'effort': 0,
        'stat': {'name': 'defense', 'url': 'https://pokeapi.co/api/v2/stat/3/'},
      },
      {
        'base_stat': 65,
        'effort': 1,
        'stat': {
          'name': 'special-attack',
          'url': 'https://pokeapi.co/api/v2/stat/4/',
        },
      },
      {
        'base_stat': 65,
        'effort': 0,
        'stat': {
          'name': 'special-defense',
          'url': 'https://pokeapi.co/api/v2/stat/5/',
        },
      },
      {
        'base_stat': 45,
        'effort': 0,
        'stat': {'name': 'speed', 'url': 'https://pokeapi.co/api/v2/stat/6/'},
      },
    ],
    'sprites': {
      'front_default':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      'front_shiny':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png',
      'other': {
        'official-artwork': {
          'front_default':
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
        },
        'dream_world': {
          'front_default':
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/1.svg',
        },
      },
    },
  };

  // Modelos de dominio para test Local
  static List<PokemonListItem> pokemonListItems = [
    const PokemonListItem(
      id: 1,
      name: 'bulbasaur',
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
    ),
    const PokemonListItem(
      id: 2,
      name: 'ivysaur',
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/2.png',
    ),
    const PokemonListItem(
      id: 3,
      name: 'venusaur',
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/3.png',
    ),
  ];

  static PokemonListResponse pokemonListResponse = PokemonListResponse(
    pokemons: pokemonListItems,
    hasMore: true,
    count: 1302,
  );

  static PokemonDetail pokemonDetail = PokemonDetail(
    id: 1,
    name: 'bulbasaur',
    height: 7,
    weight: 69,
    types: const ['grass', 'poison'],
    abilities: const ['overgrow'],
    stats: const {
      'hp': 45,
      'attack': 49,
      'defense': 49,
      'special-attack': 65,
      'special-defense': 65,
      'speed': 45,
    },
    sprites: const PokemonSprites(
      frontDefault:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      frontShiny:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png',
      officialArtwork:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
      dreamWorld:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/1.svg',
    ),
  );

  // Helper para dio
  static Response<T> createSuccessResponse<T>(T data) {
    return Response<T>(
      data: data,
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    );
  }
}
