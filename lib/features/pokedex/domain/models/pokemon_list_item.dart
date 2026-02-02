import 'package:equatable/equatable.dart';

/// Representa un item de Pokemon en la lista
class PokemonListItem extends Equatable {
  final int id;
  final String name;
  final String imageUrl;

  const PokemonListItem({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, imageUrl];

  factory PokemonListItem.fromJson(Map<String, dynamic> json) {
    final String url = json['url'] as String;

    final int id = _extractIdFromUrl(url);
    final String imageUrl = _buildImageUrl(id);

    return PokemonListItem(
      id: id,
      name: json['name'] as String,
      imageUrl: imageUrl,
    );
  }

  /// Extrae el ID de la URL del Pokemon
  /// Ejemplo: "https://pokeapi.co/api/v2/pokemon/1/" -> 1
  static int _extractIdFromUrl(String url) {
    return int.parse(url.split('/').reversed.elementAt(1));
  }

  /// Construye la URL de la imagen oficial del Pokemon
  static String _buildImageUrl(int id) {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
  }
}
