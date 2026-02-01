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
}
