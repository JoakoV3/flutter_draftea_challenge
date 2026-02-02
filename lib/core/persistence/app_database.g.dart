// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PokemonTableTable extends PokemonTable
    with TableInfo<$PokemonTableTable, PokemonTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
    'height',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
    'weight',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typesMeta = const VerificationMeta('types');
  @override
  late final GeneratedColumn<String> types = GeneratedColumn<String>(
    'types',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _abilitiesMeta = const VerificationMeta(
    'abilities',
  );
  @override
  late final GeneratedColumn<String> abilities = GeneratedColumn<String>(
    'abilities',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statsMeta = const VerificationMeta('stats');
  @override
  late final GeneratedColumn<String> stats = GeneratedColumn<String>(
    'stats',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _spritesMeta = const VerificationMeta(
    'sprites',
  );
  @override
  late final GeneratedColumn<String> sprites = GeneratedColumn<String>(
    'sprites',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastUpdatedMeta = const VerificationMeta(
    'lastUpdated',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
    'last_updated',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('types')) {
      context.handle(
        _typesMeta,
        types.isAcceptableOrUnknown(data['types']!, _typesMeta),
      );
    }
    if (data.containsKey('abilities')) {
      context.handle(
        _abilitiesMeta,
        abilities.isAcceptableOrUnknown(data['abilities']!, _abilitiesMeta),
      );
    }
    if (data.containsKey('stats')) {
      context.handle(
        _statsMeta,
        stats.isAcceptableOrUnknown(data['stats']!, _statsMeta),
      );
    }
    if (data.containsKey('sprites')) {
      context.handle(
        _spritesMeta,
        sprites.isAcceptableOrUnknown(data['sprites']!, _spritesMeta),
      );
    }
    if (data.containsKey('last_updated')) {
      context.handle(
        _lastUpdatedMeta,
        lastUpdated.isAcceptableOrUnknown(
          data['last_updated']!,
          _lastUpdatedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PokemonTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height'],
      ),
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weight'],
      ),
      types: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}types'],
      ),
      abilities: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}abilities'],
      ),
      stats: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stats'],
      ),
      sprites: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sprites'],
      ),
      lastUpdated: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated'],
      )!,
    );
  }

  @override
  $PokemonTableTable createAlias(String alias) {
    return $PokemonTableTable(attachedDatabase, alias);
  }
}

class PokemonTableData extends DataClass
    implements Insertable<PokemonTableData> {
  /// ID único del Pokemon (primary key)
  final int id;

  /// Nombre del Pokemon
  final String name;

  /// URL de la imagen oficial del Pokemon
  final String imageUrl;

  /// Altura del Pokemon en decímetros (nullable hasta que se cargue el detalle)
  final int? height;

  /// Peso del Pokemon en hectogramos (nullable hasta que se cargue el detalle)
  final int? weight;

  /// Tipos del Pokemon en formato JSON (ej: ["grass", "poison"])
  final String? types;

  /// Habilidades del Pokemon en formato JSON (ej: ["overgrow", "chlorophyll"])
  final String? abilities;

  /// Estadísticas del Pokemon en formato JSON
  /// Formato: {"hp": 45, "attack": 49, "defense": 49, ...}
  final String? stats;

  /// Sprites del Pokemon en formato JSON
  /// Formato: {"frontDefault": "url", "frontShiny": "url", ...}
  final String? sprites;

  /// Timestamp de la última actualización (para invalidación de caché futura)
  final DateTime lastUpdated;
  const PokemonTableData({
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
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['image_url'] = Variable<String>(imageUrl);
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<int>(height);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<int>(weight);
    }
    if (!nullToAbsent || types != null) {
      map['types'] = Variable<String>(types);
    }
    if (!nullToAbsent || abilities != null) {
      map['abilities'] = Variable<String>(abilities);
    }
    if (!nullToAbsent || stats != null) {
      map['stats'] = Variable<String>(stats);
    }
    if (!nullToAbsent || sprites != null) {
      map['sprites'] = Variable<String>(sprites);
    }
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  PokemonTableCompanion toCompanion(bool nullToAbsent) {
    return PokemonTableCompanion(
      id: Value(id),
      name: Value(name),
      imageUrl: Value(imageUrl),
      height: height == null && nullToAbsent
          ? const Value.absent()
          : Value(height),
      weight: weight == null && nullToAbsent
          ? const Value.absent()
          : Value(weight),
      types: types == null && nullToAbsent
          ? const Value.absent()
          : Value(types),
      abilities: abilities == null && nullToAbsent
          ? const Value.absent()
          : Value(abilities),
      stats: stats == null && nullToAbsent
          ? const Value.absent()
          : Value(stats),
      sprites: sprites == null && nullToAbsent
          ? const Value.absent()
          : Value(sprites),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory PokemonTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      height: serializer.fromJson<int?>(json['height']),
      weight: serializer.fromJson<int?>(json['weight']),
      types: serializer.fromJson<String?>(json['types']),
      abilities: serializer.fromJson<String?>(json['abilities']),
      stats: serializer.fromJson<String?>(json['stats']),
      sprites: serializer.fromJson<String?>(json['sprites']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'height': serializer.toJson<int?>(height),
      'weight': serializer.toJson<int?>(weight),
      'types': serializer.toJson<String?>(types),
      'abilities': serializer.toJson<String?>(abilities),
      'stats': serializer.toJson<String?>(stats),
      'sprites': serializer.toJson<String?>(sprites),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  PokemonTableData copyWith({
    int? id,
    String? name,
    String? imageUrl,
    Value<int?> height = const Value.absent(),
    Value<int?> weight = const Value.absent(),
    Value<String?> types = const Value.absent(),
    Value<String?> abilities = const Value.absent(),
    Value<String?> stats = const Value.absent(),
    Value<String?> sprites = const Value.absent(),
    DateTime? lastUpdated,
  }) => PokemonTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    imageUrl: imageUrl ?? this.imageUrl,
    height: height.present ? height.value : this.height,
    weight: weight.present ? weight.value : this.weight,
    types: types.present ? types.value : this.types,
    abilities: abilities.present ? abilities.value : this.abilities,
    stats: stats.present ? stats.value : this.stats,
    sprites: sprites.present ? sprites.value : this.sprites,
    lastUpdated: lastUpdated ?? this.lastUpdated,
  );
  PokemonTableData copyWithCompanion(PokemonTableCompanion data) {
    return PokemonTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      height: data.height.present ? data.height.value : this.height,
      weight: data.weight.present ? data.weight.value : this.weight,
      types: data.types.present ? data.types.value : this.types,
      abilities: data.abilities.present ? data.abilities.value : this.abilities,
      stats: data.stats.present ? data.stats.value : this.stats,
      sprites: data.sprites.present ? data.sprites.value : this.sprites,
      lastUpdated: data.lastUpdated.present
          ? data.lastUpdated.value
          : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('types: $types, ')
          ..write('abilities: $abilities, ')
          ..write('stats: $stats, ')
          ..write('sprites: $sprites, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.imageUrl == this.imageUrl &&
          other.height == this.height &&
          other.weight == this.weight &&
          other.types == this.types &&
          other.abilities == this.abilities &&
          other.stats == this.stats &&
          other.sprites == this.sprites &&
          other.lastUpdated == this.lastUpdated);
}

class PokemonTableCompanion extends UpdateCompanion<PokemonTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> imageUrl;
  final Value<int?> height;
  final Value<int?> weight;
  final Value<String?> types;
  final Value<String?> abilities;
  final Value<String?> stats;
  final Value<String?> sprites;
  final Value<DateTime> lastUpdated;
  const PokemonTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    this.types = const Value.absent(),
    this.abilities = const Value.absent(),
    this.stats = const Value.absent(),
    this.sprites = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  PokemonTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String imageUrl,
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    this.types = const Value.absent(),
    this.abilities = const Value.absent(),
    this.stats = const Value.absent(),
    this.sprites = const Value.absent(),
    required DateTime lastUpdated,
  }) : name = Value(name),
       imageUrl = Value(imageUrl),
       lastUpdated = Value(lastUpdated);
  static Insertable<PokemonTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? imageUrl,
    Expression<int>? height,
    Expression<int>? weight,
    Expression<String>? types,
    Expression<String>? abilities,
    Expression<String>? stats,
    Expression<String>? sprites,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (imageUrl != null) 'image_url': imageUrl,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (types != null) 'types': types,
      if (abilities != null) 'abilities': abilities,
      if (stats != null) 'stats': stats,
      if (sprites != null) 'sprites': sprites,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  PokemonTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? imageUrl,
    Value<int?>? height,
    Value<int?>? weight,
    Value<String?>? types,
    Value<String?>? abilities,
    Value<String?>? stats,
    Value<String?>? sprites,
    Value<DateTime>? lastUpdated,
  }) {
    return PokemonTableCompanion(
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

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (types.present) {
      map['types'] = Variable<String>(types.value);
    }
    if (abilities.present) {
      map['abilities'] = Variable<String>(abilities.value);
    }
    if (stats.present) {
      map['stats'] = Variable<String>(stats.value);
    }
    if (sprites.present) {
      map['sprites'] = Variable<String>(sprites.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('types: $types, ')
          ..write('abilities: $abilities, ')
          ..write('stats: $stats, ')
          ..write('sprites: $sprites, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PokemonTableTable pokemonTable = $PokemonTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [pokemonTable];
}

typedef $$PokemonTableTableCreateCompanionBuilder =
    PokemonTableCompanion Function({
      Value<int> id,
      required String name,
      required String imageUrl,
      Value<int?> height,
      Value<int?> weight,
      Value<String?> types,
      Value<String?> abilities,
      Value<String?> stats,
      Value<String?> sprites,
      required DateTime lastUpdated,
    });
typedef $$PokemonTableTableUpdateCompanionBuilder =
    PokemonTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> imageUrl,
      Value<int?> height,
      Value<int?> weight,
      Value<String?> types,
      Value<String?> abilities,
      Value<String?> stats,
      Value<String?> sprites,
      Value<DateTime> lastUpdated,
    });

class $$PokemonTableTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonTableTable> {
  $$PokemonTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get types => $composableBuilder(
    column: $table.types,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get abilities => $composableBuilder(
    column: $table.abilities,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stats => $composableBuilder(
    column: $table.stats,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sprites => $composableBuilder(
    column: $table.sprites,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PokemonTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonTableTable> {
  $$PokemonTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get types => $composableBuilder(
    column: $table.types,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get abilities => $composableBuilder(
    column: $table.abilities,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stats => $composableBuilder(
    column: $table.stats,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sprites => $composableBuilder(
    column: $table.sprites,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PokemonTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonTableTable> {
  $$PokemonTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<int> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get types =>
      $composableBuilder(column: $table.types, builder: (column) => column);

  GeneratedColumn<String> get abilities =>
      $composableBuilder(column: $table.abilities, builder: (column) => column);

  GeneratedColumn<String> get stats =>
      $composableBuilder(column: $table.stats, builder: (column) => column);

  GeneratedColumn<String> get sprites =>
      $composableBuilder(column: $table.sprites, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );
}

class $$PokemonTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonTableTable,
          PokemonTableData,
          $$PokemonTableTableFilterComposer,
          $$PokemonTableTableOrderingComposer,
          $$PokemonTableTableAnnotationComposer,
          $$PokemonTableTableCreateCompanionBuilder,
          $$PokemonTableTableUpdateCompanionBuilder,
          (
            PokemonTableData,
            BaseReferences<_$AppDatabase, $PokemonTableTable, PokemonTableData>,
          ),
          PokemonTableData,
          PrefetchHooks Function()
        > {
  $$PokemonTableTableTableManager(_$AppDatabase db, $PokemonTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<int?> weight = const Value.absent(),
                Value<String?> types = const Value.absent(),
                Value<String?> abilities = const Value.absent(),
                Value<String?> stats = const Value.absent(),
                Value<String?> sprites = const Value.absent(),
                Value<DateTime> lastUpdated = const Value.absent(),
              }) => PokemonTableCompanion(
                id: id,
                name: name,
                imageUrl: imageUrl,
                height: height,
                weight: weight,
                types: types,
                abilities: abilities,
                stats: stats,
                sprites: sprites,
                lastUpdated: lastUpdated,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String imageUrl,
                Value<int?> height = const Value.absent(),
                Value<int?> weight = const Value.absent(),
                Value<String?> types = const Value.absent(),
                Value<String?> abilities = const Value.absent(),
                Value<String?> stats = const Value.absent(),
                Value<String?> sprites = const Value.absent(),
                required DateTime lastUpdated,
              }) => PokemonTableCompanion.insert(
                id: id,
                name: name,
                imageUrl: imageUrl,
                height: height,
                weight: weight,
                types: types,
                abilities: abilities,
                stats: stats,
                sprites: sprites,
                lastUpdated: lastUpdated,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PokemonTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonTableTable,
      PokemonTableData,
      $$PokemonTableTableFilterComposer,
      $$PokemonTableTableOrderingComposer,
      $$PokemonTableTableAnnotationComposer,
      $$PokemonTableTableCreateCompanionBuilder,
      $$PokemonTableTableUpdateCompanionBuilder,
      (
        PokemonTableData,
        BaseReferences<_$AppDatabase, $PokemonTableTable, PokemonTableData>,
      ),
      PokemonTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PokemonTableTableTableManager get pokemonTable =>
      $$PokemonTableTableTableManager(_db, _db.pokemonTable);
}
