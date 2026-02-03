/// Excepciones específicas del dominio de Pokemon
/// Estas excepciones representan errores de negocio, no errores técnicos
library;

/// Excepción base para errores relacionados con Pokemon
abstract class PokemonException implements Exception {
  final String message;

  const PokemonException(this.message);

  @override
  String toString() => message;
}

/// Se lanza cuando no se puede encontrar un Pokemon específico
class PokemonNotFoundException extends PokemonException {
  final int pokemonId;

  const PokemonNotFoundException(this.pokemonId)
    : super('No se encontró el Pokemon con ID $pokemonId');
}

/// Se lanza cuando falla la obtención de la lista de Pokemon
class PokemonListFetchException extends PokemonException {
  const PokemonListFetchException([String? details])
    : super(
        'Error al obtener la lista de Pokemon${details != null ? ': $details' : ''}',
      );
}

/// Se lanza cuando falla la obtención del detalle de un Pokemon
class PokemonDetailFetchException extends PokemonException {
  final int pokemonId;

  const PokemonDetailFetchException(this.pokemonId, [String? details])
    : super(
        'Error al obtener los detalles del Pokemon $pokemonId${details != null ? ': $details' : ''}',
      );
}
