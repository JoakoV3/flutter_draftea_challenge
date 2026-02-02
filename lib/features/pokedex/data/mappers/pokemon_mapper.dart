import 'package:flutter_draftea_challenge/core/persistence/app_database.dart';
import 'package:flutter_draftea_challenge/features/pokedex/data/models/pokemon_entity.dart';
import 'package:flutter_draftea_challenge/features/pokedex/domain/models/pokemon_detail.dart';
import 'package:flutter_draftea_challenge/features/pokedex/domain/models/pokemon_list_item.dart';

/// Mappers para convertir entre modelos de dominio y entities de BD
// Domain -> Entity
extension PokemonListItemMapper on PokemonListItem {
  /// Convierte un PokemonListItem a PokemonEntity (solo datos básicos)
  PokemonEntity toEntity() {
    return PokemonEntity(
      id: id,
      name: name,
      imageUrl: imageUrl,
      lastUpdated: DateTime.now(),
    );
  }
}

extension PokemonDetailMapper on PokemonDetail {
  /// Convierte un PokemonDetail a PokemonEntity (datos completos)
  PokemonEntity toEntity() {
    return PokemonEntity(
      id: id,
      name: name,
      imageUrl:
          sprites.officialArtwork ??
          sprites.frontDefault, // Usar artwork oficial o sprite por defecto
      height: height,
      weight: weight,
      types: types,
      abilities: abilities,
      stats: stats,
      sprites: {
        'frontDefault': sprites.frontDefault,
        'frontShiny': sprites.frontShiny,
        'officialArtwork': sprites.officialArtwork,
        'dreamWorld': sprites.dreamWorld,
      },
      lastUpdated: DateTime.now(),
    );
  }
}

// Entity -> Domain
extension PokemonEntityMapper on PokemonEntity {
  /// Convierte un PokemonEntity a PokemonListItem (solo datos básicos)
  PokemonListItem toListItem() {
    return PokemonListItem(id: id, name: name, imageUrl: imageUrl);
  }

  /// Convierte un PokemonEntity a PokemonDetail (requiere datos completos)
  /// Lanza una excepción si el entity no tiene datos completos
  PokemonDetail toDetail() {
    if (!hasDetailData) {
      throw StateError(
        'Cannot convert PokemonEntity to PokemonDetail: missing detail data for Pokemon $id',
      );
    }

    return PokemonDetail(
      id: id,
      name: name,
      height: height!,
      weight: weight!,
      types: types!,
      abilities: abilities!,
      stats: stats!,
      sprites: PokemonSprites(
        frontDefault: sprites!['frontDefault'] ?? '',
        frontShiny: sprites!['frontShiny'],
        officialArtwork: sprites!['officialArtwork'],
        dreamWorld: sprites!['dreamWorld'],
      ),
    );
  }

  /// Intenta convertir a PokemonDetail, retorna null si no tiene datos completos
  PokemonDetail? toDetailOrNull() {
    if (!hasDetailData) return null;
    return toDetail();
  }
}

// ========== Drift Table → Entity ==========

extension PokemonTableDataMapper on PokemonTableData {
  /// Convierte una fila de la tabla Drift a PokemonEntity
  PokemonEntity toEntity() {
    return PokemonEntity(
      id: id,
      name: name,
      imageUrl: imageUrl,
      height: height,
      weight: weight,
      types: PokemonEntity.decodeStringList(types),
      abilities: PokemonEntity.decodeStringList(abilities),
      stats: PokemonEntity.decodeStats(stats),
      sprites: PokemonEntity.decodeSprites(sprites),
      lastUpdated: lastUpdated,
    );
  }
}
