import 'dart:convert';
import 'package:equatable/equatable.dart';

/// Modelo de datos que representa un Pokemon en la base de datos
/// Este modelo puede tener datos parciales (solo lista) o completos (lista + detalles)
class PokemonEntity extends Equatable {
  // ========== Campos básicos (siempre presentes) ==========
  final int id;
  final String name;
  final String imageUrl;

  // ========== Campos de detalle (opcionales) ==========
  final int? height;
  final int? weight;
  final List<String>? types;
  final List<String>? abilities;
  final Map<String, int>? stats;
  final Map<String, String?>? sprites;

  // ========== Metadata ==========
  final DateTime lastUpdated;

  const PokemonEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.height,
    this.weight,
    this.types,
    this.abilities,
    this.stats,
    this.sprites,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    imageUrl,
    height,
    weight,
    types,
    abilities,
    stats,
    sprites,
    lastUpdated,
  ];

  /// Indica si este entity tiene datos completos de detalle
  bool get hasDetailData =>
      height != null &&
      weight != null &&
      types != null &&
      abilities != null &&
      stats != null &&
      sprites != null;

  /// Serializa una lista de strings a JSON
  static String? encodeStringList(List<String>? list) {
    if (list == null) return null;
    return jsonEncode(list);
  }

  /// Deserializa una lista de strings desde JSON
  static List<String>? decodeStringList(String? json) {
    if (json == null) return null;
    final decoded = jsonDecode(json) as List;
    return decoded.map((e) => e as String).toList();
  }

  /// Serializa un mapa de stats a JSON
  static String? encodeStats(Map<String, int>? stats) {
    if (stats == null) return null;
    return jsonEncode(stats);
  }

  /// Deserializa un mapa de stats desde JSON
  static Map<String, int>? decodeStats(String? json) {
    if (json == null) return null;
    final decoded = jsonDecode(json) as Map<String, dynamic>;
    return decoded.map((key, value) => MapEntry(key, value as int));
  }

  /// Serializa un mapa de sprites a JSON
  static String? encodeSprites(Map<String, String?>? sprites) {
    if (sprites == null) return null;
    return jsonEncode(sprites);
  }

  /// Deserializa un mapa de sprites desde JSON
  static Map<String, String?>? decodeSprites(String? json) {
    if (json == null) return null;
    final decoded = jsonDecode(json) as Map<String, dynamic>;
    return decoded.map((key, value) => MapEntry(key, value as String?));
  }

  /// Combina datos básicos existentes con nuevos detalles
  /// Útil cuando ya tenemos un Pokemon en BD con datos básicos
  /// y queremos agregar los detalles sin perder la información existente
  PokemonEntity mergeWithDetails({
    int? height,
    int? weight,
    List<String>? types,
    List<String>? abilities,
    Map<String, int>? stats,
    Map<String, String?>? sprites,
  }) {
    return PokemonEntity(
      id: id,
      name: name,
      imageUrl: imageUrl,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      types: types ?? this.types,
      abilities: abilities ?? this.abilities,
      stats: stats ?? this.stats,
      sprites: sprites ?? this.sprites,
      lastUpdated: DateTime.now(),
    );
  }

  /// Crea una copia del entity con campos actualizados
  PokemonEntity copyWith({
    int? id,
    String? name,
    String? imageUrl,
    int? height,
    int? weight,
    List<String>? types,
    List<String>? abilities,
    Map<String, int>? stats,
    Map<String, String?>? sprites,
    DateTime? lastUpdated,
  }) {
    return PokemonEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      types: types ?? this.types,
      abilities: abilities ?? this.abilities,
      stats: stats ?? this.stats,
      sprites: sprites ?? this.sprites,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
