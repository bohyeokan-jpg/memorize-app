// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $WordBooksTable extends WordBooks
    with TableInfo<$WordBooksTable, WordBookRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordBooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
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
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceTypeMeta = const VerificationMeta(
    'sourceType',
  );
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
    'source_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _contentVersionMeta = const VerificationMeta(
    'contentVersion',
  );
  @override
  late final GeneratedColumn<int> contentVersion = GeneratedColumn<int>(
    'content_version',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    sourceType,
    sourceId,
    contentVersion,
    language,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_books';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordBookRow> instance, {
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
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('source_type')) {
      context.handle(
        _sourceTypeMeta,
        sourceType.isAcceptableOrUnknown(data['source_type']!, _sourceTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceTypeMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('content_version')) {
      context.handle(
        _contentVersionMeta,
        contentVersion.isAcceptableOrUnknown(
          data['content_version']!,
          _contentVersionMeta,
        ),
      );
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordBookRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordBookRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      sourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_type'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      )!,
      contentVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}content_version'],
      ),
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $WordBooksTable createAlias(String alias) {
    return $WordBooksTable(attachedDatabase, alias);
  }
}

class WordBookRow extends DataClass implements Insertable<WordBookRow> {
  final int id;
  final String name;
  final String description;
  final String sourceType;
  final String sourceId;
  final int? contentVersion;
  final String? language;
  final DateTime createdAt;
  const WordBookRow({
    required this.id,
    required this.name,
    required this.description,
    required this.sourceType,
    required this.sourceId,
    this.contentVersion,
    this.language,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['source_type'] = Variable<String>(sourceType);
    map['source_id'] = Variable<String>(sourceId);
    if (!nullToAbsent || contentVersion != null) {
      map['content_version'] = Variable<int>(contentVersion);
    }
    if (!nullToAbsent || language != null) {
      map['language'] = Variable<String>(language);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WordBooksCompanion toCompanion(bool nullToAbsent) {
    return WordBooksCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      sourceType: Value(sourceType),
      sourceId: Value(sourceId),
      contentVersion: contentVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(contentVersion),
      language: language == null && nullToAbsent
          ? const Value.absent()
          : Value(language),
      createdAt: Value(createdAt),
    );
  }

  factory WordBookRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordBookRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      contentVersion: serializer.fromJson<int?>(json['contentVersion']),
      language: serializer.fromJson<String?>(json['language']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'sourceType': serializer.toJson<String>(sourceType),
      'sourceId': serializer.toJson<String>(sourceId),
      'contentVersion': serializer.toJson<int?>(contentVersion),
      'language': serializer.toJson<String?>(language),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WordBookRow copyWith({
    int? id,
    String? name,
    String? description,
    String? sourceType,
    String? sourceId,
    Value<int?> contentVersion = const Value.absent(),
    Value<String?> language = const Value.absent(),
    DateTime? createdAt,
  }) => WordBookRow(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    sourceType: sourceType ?? this.sourceType,
    sourceId: sourceId ?? this.sourceId,
    contentVersion: contentVersion.present
        ? contentVersion.value
        : this.contentVersion,
    language: language.present ? language.value : this.language,
    createdAt: createdAt ?? this.createdAt,
  );
  WordBookRow copyWithCompanion(WordBooksCompanion data) {
    return WordBookRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      contentVersion: data.contentVersion.present
          ? data.contentVersion.value
          : this.contentVersion,
      language: data.language.present ? data.language.value : this.language,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordBookRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('contentVersion: $contentVersion, ')
          ..write('language: $language, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    sourceType,
    sourceId,
    contentVersion,
    language,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordBookRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.sourceType == this.sourceType &&
          other.sourceId == this.sourceId &&
          other.contentVersion == this.contentVersion &&
          other.language == this.language &&
          other.createdAt == this.createdAt);
}

class WordBooksCompanion extends UpdateCompanion<WordBookRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> sourceType;
  final Value<String> sourceId;
  final Value<int?> contentVersion;
  final Value<String?> language;
  final Value<DateTime> createdAt;
  const WordBooksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.contentVersion = const Value.absent(),
    this.language = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  WordBooksCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    required String sourceType,
    required String sourceId,
    this.contentVersion = const Value.absent(),
    this.language = const Value.absent(),
    required DateTime createdAt,
  }) : name = Value(name),
       description = Value(description),
       sourceType = Value(sourceType),
       sourceId = Value(sourceId),
       createdAt = Value(createdAt);
  static Insertable<WordBookRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? sourceType,
    Expression<String>? sourceId,
    Expression<int>? contentVersion,
    Expression<String>? language,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (sourceType != null) 'source_type': sourceType,
      if (sourceId != null) 'source_id': sourceId,
      if (contentVersion != null) 'content_version': contentVersion,
      if (language != null) 'language': language,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  WordBooksCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? description,
    Value<String>? sourceType,
    Value<String>? sourceId,
    Value<int?>? contentVersion,
    Value<String?>? language,
    Value<DateTime>? createdAt,
  }) {
    return WordBooksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      sourceType: sourceType ?? this.sourceType,
      sourceId: sourceId ?? this.sourceId,
      contentVersion: contentVersion ?? this.contentVersion,
      language: language ?? this.language,
      createdAt: createdAt ?? this.createdAt,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (contentVersion.present) {
      map['content_version'] = Variable<int>(contentVersion.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordBooksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('contentVersion: $contentVersion, ')
          ..write('language: $language, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WordsTable extends Words with TableInfo<$WordsTable, WordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _wordBookIdMeta = const VerificationMeta(
    'wordBookId',
  );
  @override
  late final GeneratedColumn<int> wordBookId = GeneratedColumn<int>(
    'word_book_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES word_books (id)',
    ),
  );
  static const VerificationMeta _termMeta = const VerificationMeta('term');
  @override
  late final GeneratedColumn<String> term = GeneratedColumn<String>(
    'term',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _readingMeta = const VerificationMeta(
    'reading',
  );
  @override
  late final GeneratedColumn<String> reading = GeneratedColumn<String>(
    'reading',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneticMeta = const VerificationMeta(
    'phonetic',
  );
  @override
  late final GeneratedColumn<String> phonetic = GeneratedColumn<String>(
    'phonetic',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _meaningMeta = const VerificationMeta(
    'meaning',
  );
  @override
  late final GeneratedColumn<String> meaning = GeneratedColumn<String>(
    'meaning',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exampleMeta = const VerificationMeta(
    'example',
  );
  @override
  late final GeneratedColumn<String> example = GeneratedColumn<String>(
    'example',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exampleTranslationMeta =
      const VerificationMeta('exampleTranslation');
  @override
  late final GeneratedColumn<String> exampleTranslation =
      GeneratedColumn<String>(
        'example_translation',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isFlaggedMeta = const VerificationMeta(
    'isFlagged',
  );
  @override
  late final GeneratedColumn<bool> isFlagged = GeneratedColumn<bool>(
    'is_flagged',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_flagged" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    wordBookId,
    term,
    reading,
    phonetic,
    meaning,
    example,
    exampleTranslation,
    isFlagged,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'words';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word_book_id')) {
      context.handle(
        _wordBookIdMeta,
        wordBookId.isAcceptableOrUnknown(
          data['word_book_id']!,
          _wordBookIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wordBookIdMeta);
    }
    if (data.containsKey('term')) {
      context.handle(
        _termMeta,
        term.isAcceptableOrUnknown(data['term']!, _termMeta),
      );
    } else if (isInserting) {
      context.missing(_termMeta);
    }
    if (data.containsKey('reading')) {
      context.handle(
        _readingMeta,
        reading.isAcceptableOrUnknown(data['reading']!, _readingMeta),
      );
    }
    if (data.containsKey('phonetic')) {
      context.handle(
        _phoneticMeta,
        phonetic.isAcceptableOrUnknown(data['phonetic']!, _phoneticMeta),
      );
    }
    if (data.containsKey('meaning')) {
      context.handle(
        _meaningMeta,
        meaning.isAcceptableOrUnknown(data['meaning']!, _meaningMeta),
      );
    } else if (isInserting) {
      context.missing(_meaningMeta);
    }
    if (data.containsKey('example')) {
      context.handle(
        _exampleMeta,
        example.isAcceptableOrUnknown(data['example']!, _exampleMeta),
      );
    }
    if (data.containsKey('example_translation')) {
      context.handle(
        _exampleTranslationMeta,
        exampleTranslation.isAcceptableOrUnknown(
          data['example_translation']!,
          _exampleTranslationMeta,
        ),
      );
    }
    if (data.containsKey('is_flagged')) {
      context.handle(
        _isFlaggedMeta,
        isFlagged.isAcceptableOrUnknown(data['is_flagged']!, _isFlaggedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      wordBookId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}word_book_id'],
      )!,
      term: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}term'],
      )!,
      reading: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reading'],
      ),
      phonetic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phonetic'],
      ),
      meaning: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meaning'],
      )!,
      example: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}example'],
      ),
      exampleTranslation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}example_translation'],
      ),
      isFlagged: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_flagged'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $WordsTable createAlias(String alias) {
    return $WordsTable(attachedDatabase, alias);
  }
}

class WordRow extends DataClass implements Insertable<WordRow> {
  final int id;
  final int wordBookId;
  final String term;
  final String? reading;
  final String? phonetic;
  final String meaning;
  final String? example;
  final String? exampleTranslation;
  final bool isFlagged;
  final DateTime createdAt;
  const WordRow({
    required this.id,
    required this.wordBookId,
    required this.term,
    this.reading,
    this.phonetic,
    required this.meaning,
    this.example,
    this.exampleTranslation,
    required this.isFlagged,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word_book_id'] = Variable<int>(wordBookId);
    map['term'] = Variable<String>(term);
    if (!nullToAbsent || reading != null) {
      map['reading'] = Variable<String>(reading);
    }
    if (!nullToAbsent || phonetic != null) {
      map['phonetic'] = Variable<String>(phonetic);
    }
    map['meaning'] = Variable<String>(meaning);
    if (!nullToAbsent || example != null) {
      map['example'] = Variable<String>(example);
    }
    if (!nullToAbsent || exampleTranslation != null) {
      map['example_translation'] = Variable<String>(exampleTranslation);
    }
    map['is_flagged'] = Variable<bool>(isFlagged);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WordsCompanion toCompanion(bool nullToAbsent) {
    return WordsCompanion(
      id: Value(id),
      wordBookId: Value(wordBookId),
      term: Value(term),
      reading: reading == null && nullToAbsent
          ? const Value.absent()
          : Value(reading),
      phonetic: phonetic == null && nullToAbsent
          ? const Value.absent()
          : Value(phonetic),
      meaning: Value(meaning),
      example: example == null && nullToAbsent
          ? const Value.absent()
          : Value(example),
      exampleTranslation: exampleTranslation == null && nullToAbsent
          ? const Value.absent()
          : Value(exampleTranslation),
      isFlagged: Value(isFlagged),
      createdAt: Value(createdAt),
    );
  }

  factory WordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordRow(
      id: serializer.fromJson<int>(json['id']),
      wordBookId: serializer.fromJson<int>(json['wordBookId']),
      term: serializer.fromJson<String>(json['term']),
      reading: serializer.fromJson<String?>(json['reading']),
      phonetic: serializer.fromJson<String?>(json['phonetic']),
      meaning: serializer.fromJson<String>(json['meaning']),
      example: serializer.fromJson<String?>(json['example']),
      exampleTranslation: serializer.fromJson<String?>(
        json['exampleTranslation'],
      ),
      isFlagged: serializer.fromJson<bool>(json['isFlagged']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wordBookId': serializer.toJson<int>(wordBookId),
      'term': serializer.toJson<String>(term),
      'reading': serializer.toJson<String?>(reading),
      'phonetic': serializer.toJson<String?>(phonetic),
      'meaning': serializer.toJson<String>(meaning),
      'example': serializer.toJson<String?>(example),
      'exampleTranslation': serializer.toJson<String?>(exampleTranslation),
      'isFlagged': serializer.toJson<bool>(isFlagged),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WordRow copyWith({
    int? id,
    int? wordBookId,
    String? term,
    Value<String?> reading = const Value.absent(),
    Value<String?> phonetic = const Value.absent(),
    String? meaning,
    Value<String?> example = const Value.absent(),
    Value<String?> exampleTranslation = const Value.absent(),
    bool? isFlagged,
    DateTime? createdAt,
  }) => WordRow(
    id: id ?? this.id,
    wordBookId: wordBookId ?? this.wordBookId,
    term: term ?? this.term,
    reading: reading.present ? reading.value : this.reading,
    phonetic: phonetic.present ? phonetic.value : this.phonetic,
    meaning: meaning ?? this.meaning,
    example: example.present ? example.value : this.example,
    exampleTranslation: exampleTranslation.present
        ? exampleTranslation.value
        : this.exampleTranslation,
    isFlagged: isFlagged ?? this.isFlagged,
    createdAt: createdAt ?? this.createdAt,
  );
  WordRow copyWithCompanion(WordsCompanion data) {
    return WordRow(
      id: data.id.present ? data.id.value : this.id,
      wordBookId: data.wordBookId.present
          ? data.wordBookId.value
          : this.wordBookId,
      term: data.term.present ? data.term.value : this.term,
      reading: data.reading.present ? data.reading.value : this.reading,
      phonetic: data.phonetic.present ? data.phonetic.value : this.phonetic,
      meaning: data.meaning.present ? data.meaning.value : this.meaning,
      example: data.example.present ? data.example.value : this.example,
      exampleTranslation: data.exampleTranslation.present
          ? data.exampleTranslation.value
          : this.exampleTranslation,
      isFlagged: data.isFlagged.present ? data.isFlagged.value : this.isFlagged,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordRow(')
          ..write('id: $id, ')
          ..write('wordBookId: $wordBookId, ')
          ..write('term: $term, ')
          ..write('reading: $reading, ')
          ..write('phonetic: $phonetic, ')
          ..write('meaning: $meaning, ')
          ..write('example: $example, ')
          ..write('exampleTranslation: $exampleTranslation, ')
          ..write('isFlagged: $isFlagged, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    wordBookId,
    term,
    reading,
    phonetic,
    meaning,
    example,
    exampleTranslation,
    isFlagged,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordRow &&
          other.id == this.id &&
          other.wordBookId == this.wordBookId &&
          other.term == this.term &&
          other.reading == this.reading &&
          other.phonetic == this.phonetic &&
          other.meaning == this.meaning &&
          other.example == this.example &&
          other.exampleTranslation == this.exampleTranslation &&
          other.isFlagged == this.isFlagged &&
          other.createdAt == this.createdAt);
}

class WordsCompanion extends UpdateCompanion<WordRow> {
  final Value<int> id;
  final Value<int> wordBookId;
  final Value<String> term;
  final Value<String?> reading;
  final Value<String?> phonetic;
  final Value<String> meaning;
  final Value<String?> example;
  final Value<String?> exampleTranslation;
  final Value<bool> isFlagged;
  final Value<DateTime> createdAt;
  const WordsCompanion({
    this.id = const Value.absent(),
    this.wordBookId = const Value.absent(),
    this.term = const Value.absent(),
    this.reading = const Value.absent(),
    this.phonetic = const Value.absent(),
    this.meaning = const Value.absent(),
    this.example = const Value.absent(),
    this.exampleTranslation = const Value.absent(),
    this.isFlagged = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  WordsCompanion.insert({
    this.id = const Value.absent(),
    required int wordBookId,
    required String term,
    this.reading = const Value.absent(),
    this.phonetic = const Value.absent(),
    required String meaning,
    this.example = const Value.absent(),
    this.exampleTranslation = const Value.absent(),
    this.isFlagged = const Value.absent(),
    required DateTime createdAt,
  }) : wordBookId = Value(wordBookId),
       term = Value(term),
       meaning = Value(meaning),
       createdAt = Value(createdAt);
  static Insertable<WordRow> custom({
    Expression<int>? id,
    Expression<int>? wordBookId,
    Expression<String>? term,
    Expression<String>? reading,
    Expression<String>? phonetic,
    Expression<String>? meaning,
    Expression<String>? example,
    Expression<String>? exampleTranslation,
    Expression<bool>? isFlagged,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wordBookId != null) 'word_book_id': wordBookId,
      if (term != null) 'term': term,
      if (reading != null) 'reading': reading,
      if (phonetic != null) 'phonetic': phonetic,
      if (meaning != null) 'meaning': meaning,
      if (example != null) 'example': example,
      if (exampleTranslation != null) 'example_translation': exampleTranslation,
      if (isFlagged != null) 'is_flagged': isFlagged,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  WordsCompanion copyWith({
    Value<int>? id,
    Value<int>? wordBookId,
    Value<String>? term,
    Value<String?>? reading,
    Value<String?>? phonetic,
    Value<String>? meaning,
    Value<String?>? example,
    Value<String?>? exampleTranslation,
    Value<bool>? isFlagged,
    Value<DateTime>? createdAt,
  }) {
    return WordsCompanion(
      id: id ?? this.id,
      wordBookId: wordBookId ?? this.wordBookId,
      term: term ?? this.term,
      reading: reading ?? this.reading,
      phonetic: phonetic ?? this.phonetic,
      meaning: meaning ?? this.meaning,
      example: example ?? this.example,
      exampleTranslation: exampleTranslation ?? this.exampleTranslation,
      isFlagged: isFlagged ?? this.isFlagged,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wordBookId.present) {
      map['word_book_id'] = Variable<int>(wordBookId.value);
    }
    if (term.present) {
      map['term'] = Variable<String>(term.value);
    }
    if (reading.present) {
      map['reading'] = Variable<String>(reading.value);
    }
    if (phonetic.present) {
      map['phonetic'] = Variable<String>(phonetic.value);
    }
    if (meaning.present) {
      map['meaning'] = Variable<String>(meaning.value);
    }
    if (example.present) {
      map['example'] = Variable<String>(example.value);
    }
    if (exampleTranslation.present) {
      map['example_translation'] = Variable<String>(exampleTranslation.value);
    }
    if (isFlagged.present) {
      map['is_flagged'] = Variable<bool>(isFlagged.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordsCompanion(')
          ..write('id: $id, ')
          ..write('wordBookId: $wordBookId, ')
          ..write('term: $term, ')
          ..write('reading: $reading, ')
          ..write('phonetic: $phonetic, ')
          ..write('meaning: $meaning, ')
          ..write('example: $example, ')
          ..write('exampleTranslation: $exampleTranslation, ')
          ..write('isFlagged: $isFlagged, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $LearningProgressesTable extends LearningProgresses
    with TableInfo<$LearningProgressesTable, LearningProgressRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LearningProgressesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  @override
  late final GeneratedColumn<int> wordId = GeneratedColumn<int>(
    'word_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES words (id)',
    ),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stepIndexMeta = const VerificationMeta(
    'stepIndex',
  );
  @override
  late final GeneratedColumn<int> stepIndex = GeneratedColumn<int>(
    'step_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intervalMinutesMeta = const VerificationMeta(
    'intervalMinutes',
  );
  @override
  late final GeneratedColumn<int> intervalMinutes = GeneratedColumn<int>(
    'interval_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctCountMeta = const VerificationMeta(
    'correctCount',
  );
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
    'correct_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _wrongCountMeta = const VerificationMeta(
    'wrongCount',
  );
  @override
  late final GeneratedColumn<int> wrongCount = GeneratedColumn<int>(
    'wrong_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _streakMeta = const VerificationMeta('streak');
  @override
  late final GeneratedColumn<int> streak = GeneratedColumn<int>(
    'streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nextReviewAtMeta = const VerificationMeta(
    'nextReviewAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextReviewAt = GeneratedColumn<DateTime>(
    'next_review_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastReviewAtMeta = const VerificationMeta(
    'lastReviewAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastReviewAt = GeneratedColumn<DateTime>(
    'last_review_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    wordId,
    status,
    stepIndex,
    intervalMinutes,
    correctCount,
    wrongCount,
    streak,
    nextReviewAt,
    lastReviewAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'learning_progresses';
  @override
  VerificationContext validateIntegrity(
    Insertable<LearningProgressRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word_id')) {
      context.handle(
        _wordIdMeta,
        wordId.isAcceptableOrUnknown(data['word_id']!, _wordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_wordIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('step_index')) {
      context.handle(
        _stepIndexMeta,
        stepIndex.isAcceptableOrUnknown(data['step_index']!, _stepIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_stepIndexMeta);
    }
    if (data.containsKey('interval_minutes')) {
      context.handle(
        _intervalMinutesMeta,
        intervalMinutes.isAcceptableOrUnknown(
          data['interval_minutes']!,
          _intervalMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_intervalMinutesMeta);
    }
    if (data.containsKey('correct_count')) {
      context.handle(
        _correctCountMeta,
        correctCount.isAcceptableOrUnknown(
          data['correct_count']!,
          _correctCountMeta,
        ),
      );
    }
    if (data.containsKey('wrong_count')) {
      context.handle(
        _wrongCountMeta,
        wrongCount.isAcceptableOrUnknown(data['wrong_count']!, _wrongCountMeta),
      );
    }
    if (data.containsKey('streak')) {
      context.handle(
        _streakMeta,
        streak.isAcceptableOrUnknown(data['streak']!, _streakMeta),
      );
    }
    if (data.containsKey('next_review_at')) {
      context.handle(
        _nextReviewAtMeta,
        nextReviewAt.isAcceptableOrUnknown(
          data['next_review_at']!,
          _nextReviewAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextReviewAtMeta);
    }
    if (data.containsKey('last_review_at')) {
      context.handle(
        _lastReviewAtMeta,
        lastReviewAt.isAcceptableOrUnknown(
          data['last_review_at']!,
          _lastReviewAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {wordId},
  ];
  @override
  LearningProgressRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LearningProgressRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      wordId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}word_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      stepIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}step_index'],
      )!,
      intervalMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_minutes'],
      )!,
      correctCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_count'],
      )!,
      wrongCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wrong_count'],
      )!,
      streak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}streak'],
      )!,
      nextReviewAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_review_at'],
      )!,
      lastReviewAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_review_at'],
      ),
    );
  }

  @override
  $LearningProgressesTable createAlias(String alias) {
    return $LearningProgressesTable(attachedDatabase, alias);
  }
}

class LearningProgressRow extends DataClass
    implements Insertable<LearningProgressRow> {
  final int id;
  final int wordId;
  final String status;
  final int stepIndex;
  final int intervalMinutes;
  final int correctCount;
  final int wrongCount;
  final int streak;
  final DateTime nextReviewAt;
  final DateTime? lastReviewAt;
  const LearningProgressRow({
    required this.id,
    required this.wordId,
    required this.status,
    required this.stepIndex,
    required this.intervalMinutes,
    required this.correctCount,
    required this.wrongCount,
    required this.streak,
    required this.nextReviewAt,
    this.lastReviewAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word_id'] = Variable<int>(wordId);
    map['status'] = Variable<String>(status);
    map['step_index'] = Variable<int>(stepIndex);
    map['interval_minutes'] = Variable<int>(intervalMinutes);
    map['correct_count'] = Variable<int>(correctCount);
    map['wrong_count'] = Variable<int>(wrongCount);
    map['streak'] = Variable<int>(streak);
    map['next_review_at'] = Variable<DateTime>(nextReviewAt);
    if (!nullToAbsent || lastReviewAt != null) {
      map['last_review_at'] = Variable<DateTime>(lastReviewAt);
    }
    return map;
  }

  LearningProgressesCompanion toCompanion(bool nullToAbsent) {
    return LearningProgressesCompanion(
      id: Value(id),
      wordId: Value(wordId),
      status: Value(status),
      stepIndex: Value(stepIndex),
      intervalMinutes: Value(intervalMinutes),
      correctCount: Value(correctCount),
      wrongCount: Value(wrongCount),
      streak: Value(streak),
      nextReviewAt: Value(nextReviewAt),
      lastReviewAt: lastReviewAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewAt),
    );
  }

  factory LearningProgressRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LearningProgressRow(
      id: serializer.fromJson<int>(json['id']),
      wordId: serializer.fromJson<int>(json['wordId']),
      status: serializer.fromJson<String>(json['status']),
      stepIndex: serializer.fromJson<int>(json['stepIndex']),
      intervalMinutes: serializer.fromJson<int>(json['intervalMinutes']),
      correctCount: serializer.fromJson<int>(json['correctCount']),
      wrongCount: serializer.fromJson<int>(json['wrongCount']),
      streak: serializer.fromJson<int>(json['streak']),
      nextReviewAt: serializer.fromJson<DateTime>(json['nextReviewAt']),
      lastReviewAt: serializer.fromJson<DateTime?>(json['lastReviewAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wordId': serializer.toJson<int>(wordId),
      'status': serializer.toJson<String>(status),
      'stepIndex': serializer.toJson<int>(stepIndex),
      'intervalMinutes': serializer.toJson<int>(intervalMinutes),
      'correctCount': serializer.toJson<int>(correctCount),
      'wrongCount': serializer.toJson<int>(wrongCount),
      'streak': serializer.toJson<int>(streak),
      'nextReviewAt': serializer.toJson<DateTime>(nextReviewAt),
      'lastReviewAt': serializer.toJson<DateTime?>(lastReviewAt),
    };
  }

  LearningProgressRow copyWith({
    int? id,
    int? wordId,
    String? status,
    int? stepIndex,
    int? intervalMinutes,
    int? correctCount,
    int? wrongCount,
    int? streak,
    DateTime? nextReviewAt,
    Value<DateTime?> lastReviewAt = const Value.absent(),
  }) => LearningProgressRow(
    id: id ?? this.id,
    wordId: wordId ?? this.wordId,
    status: status ?? this.status,
    stepIndex: stepIndex ?? this.stepIndex,
    intervalMinutes: intervalMinutes ?? this.intervalMinutes,
    correctCount: correctCount ?? this.correctCount,
    wrongCount: wrongCount ?? this.wrongCount,
    streak: streak ?? this.streak,
    nextReviewAt: nextReviewAt ?? this.nextReviewAt,
    lastReviewAt: lastReviewAt.present ? lastReviewAt.value : this.lastReviewAt,
  );
  LearningProgressRow copyWithCompanion(LearningProgressesCompanion data) {
    return LearningProgressRow(
      id: data.id.present ? data.id.value : this.id,
      wordId: data.wordId.present ? data.wordId.value : this.wordId,
      status: data.status.present ? data.status.value : this.status,
      stepIndex: data.stepIndex.present ? data.stepIndex.value : this.stepIndex,
      intervalMinutes: data.intervalMinutes.present
          ? data.intervalMinutes.value
          : this.intervalMinutes,
      correctCount: data.correctCount.present
          ? data.correctCount.value
          : this.correctCount,
      wrongCount: data.wrongCount.present
          ? data.wrongCount.value
          : this.wrongCount,
      streak: data.streak.present ? data.streak.value : this.streak,
      nextReviewAt: data.nextReviewAt.present
          ? data.nextReviewAt.value
          : this.nextReviewAt,
      lastReviewAt: data.lastReviewAt.present
          ? data.lastReviewAt.value
          : this.lastReviewAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LearningProgressRow(')
          ..write('id: $id, ')
          ..write('wordId: $wordId, ')
          ..write('status: $status, ')
          ..write('stepIndex: $stepIndex, ')
          ..write('intervalMinutes: $intervalMinutes, ')
          ..write('correctCount: $correctCount, ')
          ..write('wrongCount: $wrongCount, ')
          ..write('streak: $streak, ')
          ..write('nextReviewAt: $nextReviewAt, ')
          ..write('lastReviewAt: $lastReviewAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    wordId,
    status,
    stepIndex,
    intervalMinutes,
    correctCount,
    wrongCount,
    streak,
    nextReviewAt,
    lastReviewAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LearningProgressRow &&
          other.id == this.id &&
          other.wordId == this.wordId &&
          other.status == this.status &&
          other.stepIndex == this.stepIndex &&
          other.intervalMinutes == this.intervalMinutes &&
          other.correctCount == this.correctCount &&
          other.wrongCount == this.wrongCount &&
          other.streak == this.streak &&
          other.nextReviewAt == this.nextReviewAt &&
          other.lastReviewAt == this.lastReviewAt);
}

class LearningProgressesCompanion extends UpdateCompanion<LearningProgressRow> {
  final Value<int> id;
  final Value<int> wordId;
  final Value<String> status;
  final Value<int> stepIndex;
  final Value<int> intervalMinutes;
  final Value<int> correctCount;
  final Value<int> wrongCount;
  final Value<int> streak;
  final Value<DateTime> nextReviewAt;
  final Value<DateTime?> lastReviewAt;
  const LearningProgressesCompanion({
    this.id = const Value.absent(),
    this.wordId = const Value.absent(),
    this.status = const Value.absent(),
    this.stepIndex = const Value.absent(),
    this.intervalMinutes = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.wrongCount = const Value.absent(),
    this.streak = const Value.absent(),
    this.nextReviewAt = const Value.absent(),
    this.lastReviewAt = const Value.absent(),
  });
  LearningProgressesCompanion.insert({
    this.id = const Value.absent(),
    required int wordId,
    required String status,
    required int stepIndex,
    required int intervalMinutes,
    this.correctCount = const Value.absent(),
    this.wrongCount = const Value.absent(),
    this.streak = const Value.absent(),
    required DateTime nextReviewAt,
    this.lastReviewAt = const Value.absent(),
  }) : wordId = Value(wordId),
       status = Value(status),
       stepIndex = Value(stepIndex),
       intervalMinutes = Value(intervalMinutes),
       nextReviewAt = Value(nextReviewAt);
  static Insertable<LearningProgressRow> custom({
    Expression<int>? id,
    Expression<int>? wordId,
    Expression<String>? status,
    Expression<int>? stepIndex,
    Expression<int>? intervalMinutes,
    Expression<int>? correctCount,
    Expression<int>? wrongCount,
    Expression<int>? streak,
    Expression<DateTime>? nextReviewAt,
    Expression<DateTime>? lastReviewAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wordId != null) 'word_id': wordId,
      if (status != null) 'status': status,
      if (stepIndex != null) 'step_index': stepIndex,
      if (intervalMinutes != null) 'interval_minutes': intervalMinutes,
      if (correctCount != null) 'correct_count': correctCount,
      if (wrongCount != null) 'wrong_count': wrongCount,
      if (streak != null) 'streak': streak,
      if (nextReviewAt != null) 'next_review_at': nextReviewAt,
      if (lastReviewAt != null) 'last_review_at': lastReviewAt,
    });
  }

  LearningProgressesCompanion copyWith({
    Value<int>? id,
    Value<int>? wordId,
    Value<String>? status,
    Value<int>? stepIndex,
    Value<int>? intervalMinutes,
    Value<int>? correctCount,
    Value<int>? wrongCount,
    Value<int>? streak,
    Value<DateTime>? nextReviewAt,
    Value<DateTime?>? lastReviewAt,
  }) {
    return LearningProgressesCompanion(
      id: id ?? this.id,
      wordId: wordId ?? this.wordId,
      status: status ?? this.status,
      stepIndex: stepIndex ?? this.stepIndex,
      intervalMinutes: intervalMinutes ?? this.intervalMinutes,
      correctCount: correctCount ?? this.correctCount,
      wrongCount: wrongCount ?? this.wrongCount,
      streak: streak ?? this.streak,
      nextReviewAt: nextReviewAt ?? this.nextReviewAt,
      lastReviewAt: lastReviewAt ?? this.lastReviewAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wordId.present) {
      map['word_id'] = Variable<int>(wordId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (stepIndex.present) {
      map['step_index'] = Variable<int>(stepIndex.value);
    }
    if (intervalMinutes.present) {
      map['interval_minutes'] = Variable<int>(intervalMinutes.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (wrongCount.present) {
      map['wrong_count'] = Variable<int>(wrongCount.value);
    }
    if (streak.present) {
      map['streak'] = Variable<int>(streak.value);
    }
    if (nextReviewAt.present) {
      map['next_review_at'] = Variable<DateTime>(nextReviewAt.value);
    }
    if (lastReviewAt.present) {
      map['last_review_at'] = Variable<DateTime>(lastReviewAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LearningProgressesCompanion(')
          ..write('id: $id, ')
          ..write('wordId: $wordId, ')
          ..write('status: $status, ')
          ..write('stepIndex: $stepIndex, ')
          ..write('intervalMinutes: $intervalMinutes, ')
          ..write('correctCount: $correctCount, ')
          ..write('wrongCount: $wrongCount, ')
          ..write('streak: $streak, ')
          ..write('nextReviewAt: $nextReviewAt, ')
          ..write('lastReviewAt: $lastReviewAt')
          ..write(')'))
        .toString();
  }
}

class $ReviewHistoriesTable extends ReviewHistories
    with TableInfo<$ReviewHistoriesTable, ReviewHistoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewHistoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  @override
  late final GeneratedColumn<int> wordId = GeneratedColumn<int>(
    'word_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES words (id)',
    ),
  );
  static const VerificationMeta _resultMeta = const VerificationMeta('result');
  @override
  late final GeneratedColumn<String> result = GeneratedColumn<String>(
    'result',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _directionMeta = const VerificationMeta(
    'direction',
  );
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
    'direction',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reviewedAtMeta = const VerificationMeta(
    'reviewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> reviewedAt = GeneratedColumn<DateTime>(
    'reviewed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _previousIntervalMinutesMeta =
      const VerificationMeta('previousIntervalMinutes');
  @override
  late final GeneratedColumn<int> previousIntervalMinutes =
      GeneratedColumn<int>(
        'previous_interval_minutes',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _newIntervalMinutesMeta =
      const VerificationMeta('newIntervalMinutes');
  @override
  late final GeneratedColumn<int> newIntervalMinutes = GeneratedColumn<int>(
    'new_interval_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    wordId,
    result,
    direction,
    reviewedAt,
    previousIntervalMinutes,
    newIntervalMinutes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_histories';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReviewHistoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word_id')) {
      context.handle(
        _wordIdMeta,
        wordId.isAcceptableOrUnknown(data['word_id']!, _wordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_wordIdMeta);
    }
    if (data.containsKey('result')) {
      context.handle(
        _resultMeta,
        result.isAcceptableOrUnknown(data['result']!, _resultMeta),
      );
    } else if (isInserting) {
      context.missing(_resultMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(
        _directionMeta,
        direction.isAcceptableOrUnknown(data['direction']!, _directionMeta),
      );
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('reviewed_at')) {
      context.handle(
        _reviewedAtMeta,
        reviewedAt.isAcceptableOrUnknown(data['reviewed_at']!, _reviewedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_reviewedAtMeta);
    }
    if (data.containsKey('previous_interval_minutes')) {
      context.handle(
        _previousIntervalMinutesMeta,
        previousIntervalMinutes.isAcceptableOrUnknown(
          data['previous_interval_minutes']!,
          _previousIntervalMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_previousIntervalMinutesMeta);
    }
    if (data.containsKey('new_interval_minutes')) {
      context.handle(
        _newIntervalMinutesMeta,
        newIntervalMinutes.isAcceptableOrUnknown(
          data['new_interval_minutes']!,
          _newIntervalMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_newIntervalMinutesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewHistoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewHistoryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      wordId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}word_id'],
      )!,
      result: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result'],
      )!,
      direction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direction'],
      )!,
      reviewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reviewed_at'],
      )!,
      previousIntervalMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}previous_interval_minutes'],
      )!,
      newIntervalMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}new_interval_minutes'],
      )!,
    );
  }

  @override
  $ReviewHistoriesTable createAlias(String alias) {
    return $ReviewHistoriesTable(attachedDatabase, alias);
  }
}

class ReviewHistoryRow extends DataClass
    implements Insertable<ReviewHistoryRow> {
  final int id;
  final int wordId;
  final String result;
  final String direction;
  final DateTime reviewedAt;
  final int previousIntervalMinutes;
  final int newIntervalMinutes;
  const ReviewHistoryRow({
    required this.id,
    required this.wordId,
    required this.result,
    required this.direction,
    required this.reviewedAt,
    required this.previousIntervalMinutes,
    required this.newIntervalMinutes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word_id'] = Variable<int>(wordId);
    map['result'] = Variable<String>(result);
    map['direction'] = Variable<String>(direction);
    map['reviewed_at'] = Variable<DateTime>(reviewedAt);
    map['previous_interval_minutes'] = Variable<int>(previousIntervalMinutes);
    map['new_interval_minutes'] = Variable<int>(newIntervalMinutes);
    return map;
  }

  ReviewHistoriesCompanion toCompanion(bool nullToAbsent) {
    return ReviewHistoriesCompanion(
      id: Value(id),
      wordId: Value(wordId),
      result: Value(result),
      direction: Value(direction),
      reviewedAt: Value(reviewedAt),
      previousIntervalMinutes: Value(previousIntervalMinutes),
      newIntervalMinutes: Value(newIntervalMinutes),
    );
  }

  factory ReviewHistoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewHistoryRow(
      id: serializer.fromJson<int>(json['id']),
      wordId: serializer.fromJson<int>(json['wordId']),
      result: serializer.fromJson<String>(json['result']),
      direction: serializer.fromJson<String>(json['direction']),
      reviewedAt: serializer.fromJson<DateTime>(json['reviewedAt']),
      previousIntervalMinutes: serializer.fromJson<int>(
        json['previousIntervalMinutes'],
      ),
      newIntervalMinutes: serializer.fromJson<int>(json['newIntervalMinutes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wordId': serializer.toJson<int>(wordId),
      'result': serializer.toJson<String>(result),
      'direction': serializer.toJson<String>(direction),
      'reviewedAt': serializer.toJson<DateTime>(reviewedAt),
      'previousIntervalMinutes': serializer.toJson<int>(
        previousIntervalMinutes,
      ),
      'newIntervalMinutes': serializer.toJson<int>(newIntervalMinutes),
    };
  }

  ReviewHistoryRow copyWith({
    int? id,
    int? wordId,
    String? result,
    String? direction,
    DateTime? reviewedAt,
    int? previousIntervalMinutes,
    int? newIntervalMinutes,
  }) => ReviewHistoryRow(
    id: id ?? this.id,
    wordId: wordId ?? this.wordId,
    result: result ?? this.result,
    direction: direction ?? this.direction,
    reviewedAt: reviewedAt ?? this.reviewedAt,
    previousIntervalMinutes:
        previousIntervalMinutes ?? this.previousIntervalMinutes,
    newIntervalMinutes: newIntervalMinutes ?? this.newIntervalMinutes,
  );
  ReviewHistoryRow copyWithCompanion(ReviewHistoriesCompanion data) {
    return ReviewHistoryRow(
      id: data.id.present ? data.id.value : this.id,
      wordId: data.wordId.present ? data.wordId.value : this.wordId,
      result: data.result.present ? data.result.value : this.result,
      direction: data.direction.present ? data.direction.value : this.direction,
      reviewedAt: data.reviewedAt.present
          ? data.reviewedAt.value
          : this.reviewedAt,
      previousIntervalMinutes: data.previousIntervalMinutes.present
          ? data.previousIntervalMinutes.value
          : this.previousIntervalMinutes,
      newIntervalMinutes: data.newIntervalMinutes.present
          ? data.newIntervalMinutes.value
          : this.newIntervalMinutes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewHistoryRow(')
          ..write('id: $id, ')
          ..write('wordId: $wordId, ')
          ..write('result: $result, ')
          ..write('direction: $direction, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('previousIntervalMinutes: $previousIntervalMinutes, ')
          ..write('newIntervalMinutes: $newIntervalMinutes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    wordId,
    result,
    direction,
    reviewedAt,
    previousIntervalMinutes,
    newIntervalMinutes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewHistoryRow &&
          other.id == this.id &&
          other.wordId == this.wordId &&
          other.result == this.result &&
          other.direction == this.direction &&
          other.reviewedAt == this.reviewedAt &&
          other.previousIntervalMinutes == this.previousIntervalMinutes &&
          other.newIntervalMinutes == this.newIntervalMinutes);
}

class ReviewHistoriesCompanion extends UpdateCompanion<ReviewHistoryRow> {
  final Value<int> id;
  final Value<int> wordId;
  final Value<String> result;
  final Value<String> direction;
  final Value<DateTime> reviewedAt;
  final Value<int> previousIntervalMinutes;
  final Value<int> newIntervalMinutes;
  const ReviewHistoriesCompanion({
    this.id = const Value.absent(),
    this.wordId = const Value.absent(),
    this.result = const Value.absent(),
    this.direction = const Value.absent(),
    this.reviewedAt = const Value.absent(),
    this.previousIntervalMinutes = const Value.absent(),
    this.newIntervalMinutes = const Value.absent(),
  });
  ReviewHistoriesCompanion.insert({
    this.id = const Value.absent(),
    required int wordId,
    required String result,
    required String direction,
    required DateTime reviewedAt,
    required int previousIntervalMinutes,
    required int newIntervalMinutes,
  }) : wordId = Value(wordId),
       result = Value(result),
       direction = Value(direction),
       reviewedAt = Value(reviewedAt),
       previousIntervalMinutes = Value(previousIntervalMinutes),
       newIntervalMinutes = Value(newIntervalMinutes);
  static Insertable<ReviewHistoryRow> custom({
    Expression<int>? id,
    Expression<int>? wordId,
    Expression<String>? result,
    Expression<String>? direction,
    Expression<DateTime>? reviewedAt,
    Expression<int>? previousIntervalMinutes,
    Expression<int>? newIntervalMinutes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wordId != null) 'word_id': wordId,
      if (result != null) 'result': result,
      if (direction != null) 'direction': direction,
      if (reviewedAt != null) 'reviewed_at': reviewedAt,
      if (previousIntervalMinutes != null)
        'previous_interval_minutes': previousIntervalMinutes,
      if (newIntervalMinutes != null)
        'new_interval_minutes': newIntervalMinutes,
    });
  }

  ReviewHistoriesCompanion copyWith({
    Value<int>? id,
    Value<int>? wordId,
    Value<String>? result,
    Value<String>? direction,
    Value<DateTime>? reviewedAt,
    Value<int>? previousIntervalMinutes,
    Value<int>? newIntervalMinutes,
  }) {
    return ReviewHistoriesCompanion(
      id: id ?? this.id,
      wordId: wordId ?? this.wordId,
      result: result ?? this.result,
      direction: direction ?? this.direction,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      previousIntervalMinutes:
          previousIntervalMinutes ?? this.previousIntervalMinutes,
      newIntervalMinutes: newIntervalMinutes ?? this.newIntervalMinutes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wordId.present) {
      map['word_id'] = Variable<int>(wordId.value);
    }
    if (result.present) {
      map['result'] = Variable<String>(result.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (reviewedAt.present) {
      map['reviewed_at'] = Variable<DateTime>(reviewedAt.value);
    }
    if (previousIntervalMinutes.present) {
      map['previous_interval_minutes'] = Variable<int>(
        previousIntervalMinutes.value,
      );
    }
    if (newIntervalMinutes.present) {
      map['new_interval_minutes'] = Variable<int>(newIntervalMinutes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewHistoriesCompanion(')
          ..write('id: $id, ')
          ..write('wordId: $wordId, ')
          ..write('result: $result, ')
          ..write('direction: $direction, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('previousIntervalMinutes: $previousIntervalMinutes, ')
          ..write('newIntervalMinutes: $newIntervalMinutes')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WordBooksTable wordBooks = $WordBooksTable(this);
  late final $WordsTable words = $WordsTable(this);
  late final $LearningProgressesTable learningProgresses =
      $LearningProgressesTable(this);
  late final $ReviewHistoriesTable reviewHistories = $ReviewHistoriesTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    wordBooks,
    words,
    learningProgresses,
    reviewHistories,
  ];
}

typedef $$WordBooksTableCreateCompanionBuilder =
    WordBooksCompanion Function({
      Value<int> id,
      required String name,
      required String description,
      required String sourceType,
      required String sourceId,
      Value<int?> contentVersion,
      Value<String?> language,
      required DateTime createdAt,
    });
typedef $$WordBooksTableUpdateCompanionBuilder =
    WordBooksCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> description,
      Value<String> sourceType,
      Value<String> sourceId,
      Value<int?> contentVersion,
      Value<String?> language,
      Value<DateTime> createdAt,
    });

final class $$WordBooksTableReferences
    extends BaseReferences<_$AppDatabase, $WordBooksTable, WordBookRow> {
  $$WordBooksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WordsTable, List<WordRow>> _wordsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.words,
    aliasName: $_aliasNameGenerator(db.wordBooks.id, db.words.wordBookId),
  );

  $$WordsTableProcessedTableManager get wordsRefs {
    final manager = $$WordsTableTableManager(
      $_db,
      $_db.words,
    ).filter((f) => f.wordBookId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_wordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WordBooksTableFilterComposer
    extends Composer<_$AppDatabase, $WordBooksTable> {
  $$WordBooksTableFilterComposer({
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

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> wordsRefs(
    Expression<bool> Function($$WordsTableFilterComposer f) f,
  ) {
    final $$WordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.wordBookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableFilterComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WordBooksTableOrderingComposer
    extends Composer<_$AppDatabase, $WordBooksTable> {
  $$WordBooksTableOrderingComposer({
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

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WordBooksTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordBooksTable> {
  $$WordBooksTableAnnotationComposer({
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

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<int> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> wordsRefs<T extends Object>(
    Expression<T> Function($$WordsTableAnnotationComposer a) f,
  ) {
    final $$WordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.wordBookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableAnnotationComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WordBooksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordBooksTable,
          WordBookRow,
          $$WordBooksTableFilterComposer,
          $$WordBooksTableOrderingComposer,
          $$WordBooksTableAnnotationComposer,
          $$WordBooksTableCreateCompanionBuilder,
          $$WordBooksTableUpdateCompanionBuilder,
          (WordBookRow, $$WordBooksTableReferences),
          WordBookRow,
          PrefetchHooks Function({bool wordsRefs})
        > {
  $$WordBooksTableTableManager(_$AppDatabase db, $WordBooksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordBooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordBooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordBooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<String> sourceId = const Value.absent(),
                Value<int?> contentVersion = const Value.absent(),
                Value<String?> language = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => WordBooksCompanion(
                id: id,
                name: name,
                description: description,
                sourceType: sourceType,
                sourceId: sourceId,
                contentVersion: contentVersion,
                language: language,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String description,
                required String sourceType,
                required String sourceId,
                Value<int?> contentVersion = const Value.absent(),
                Value<String?> language = const Value.absent(),
                required DateTime createdAt,
              }) => WordBooksCompanion.insert(
                id: id,
                name: name,
                description: description,
                sourceType: sourceType,
                sourceId: sourceId,
                contentVersion: contentVersion,
                language: language,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WordBooksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({wordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (wordsRefs) db.words],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (wordsRefs)
                    await $_getPrefetchedData<
                      WordBookRow,
                      $WordBooksTable,
                      WordRow
                    >(
                      currentTable: table,
                      referencedTable: $$WordBooksTableReferences
                          ._wordsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$WordBooksTableReferences(db, table, p0).wordsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.wordBookId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$WordBooksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordBooksTable,
      WordBookRow,
      $$WordBooksTableFilterComposer,
      $$WordBooksTableOrderingComposer,
      $$WordBooksTableAnnotationComposer,
      $$WordBooksTableCreateCompanionBuilder,
      $$WordBooksTableUpdateCompanionBuilder,
      (WordBookRow, $$WordBooksTableReferences),
      WordBookRow,
      PrefetchHooks Function({bool wordsRefs})
    >;
typedef $$WordsTableCreateCompanionBuilder =
    WordsCompanion Function({
      Value<int> id,
      required int wordBookId,
      required String term,
      Value<String?> reading,
      Value<String?> phonetic,
      required String meaning,
      Value<String?> example,
      Value<String?> exampleTranslation,
      Value<bool> isFlagged,
      required DateTime createdAt,
    });
typedef $$WordsTableUpdateCompanionBuilder =
    WordsCompanion Function({
      Value<int> id,
      Value<int> wordBookId,
      Value<String> term,
      Value<String?> reading,
      Value<String?> phonetic,
      Value<String> meaning,
      Value<String?> example,
      Value<String?> exampleTranslation,
      Value<bool> isFlagged,
      Value<DateTime> createdAt,
    });

final class $$WordsTableReferences
    extends BaseReferences<_$AppDatabase, $WordsTable, WordRow> {
  $$WordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WordBooksTable _wordBookIdTable(_$AppDatabase db) => db.wordBooks
      .createAlias($_aliasNameGenerator(db.words.wordBookId, db.wordBooks.id));

  $$WordBooksTableProcessedTableManager get wordBookId {
    final $_column = $_itemColumn<int>('word_book_id')!;

    final manager = $$WordBooksTableTableManager(
      $_db,
      $_db.wordBooks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wordBookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $LearningProgressesTable,
    List<LearningProgressRow>
  >
  _learningProgressesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.learningProgresses,
        aliasName: $_aliasNameGenerator(
          db.words.id,
          db.learningProgresses.wordId,
        ),
      );

  $$LearningProgressesTableProcessedTableManager get learningProgressesRefs {
    final manager = $$LearningProgressesTableTableManager(
      $_db,
      $_db.learningProgresses,
    ).filter((f) => f.wordId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _learningProgressesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReviewHistoriesTable, List<ReviewHistoryRow>>
  _reviewHistoriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reviewHistories,
    aliasName: $_aliasNameGenerator(db.words.id, db.reviewHistories.wordId),
  );

  $$ReviewHistoriesTableProcessedTableManager get reviewHistoriesRefs {
    final manager = $$ReviewHistoriesTableTableManager(
      $_db,
      $_db.reviewHistories,
    ).filter((f) => f.wordId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _reviewHistoriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WordsTableFilterComposer extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableFilterComposer({
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

  ColumnFilters<String> get term => $composableBuilder(
    column: $table.term,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reading => $composableBuilder(
    column: $table.reading,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phonetic => $composableBuilder(
    column: $table.phonetic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meaning => $composableBuilder(
    column: $table.meaning,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get example => $composableBuilder(
    column: $table.example,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exampleTranslation => $composableBuilder(
    column: $table.exampleTranslation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFlagged => $composableBuilder(
    column: $table.isFlagged,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WordBooksTableFilterComposer get wordBookId {
    final $$WordBooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordBookId,
      referencedTable: $db.wordBooks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordBooksTableFilterComposer(
            $db: $db,
            $table: $db.wordBooks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> learningProgressesRefs(
    Expression<bool> Function($$LearningProgressesTableFilterComposer f) f,
  ) {
    final $$LearningProgressesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.learningProgresses,
      getReferencedColumn: (t) => t.wordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningProgressesTableFilterComposer(
            $db: $db,
            $table: $db.learningProgresses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> reviewHistoriesRefs(
    Expression<bool> Function($$ReviewHistoriesTableFilterComposer f) f,
  ) {
    final $$ReviewHistoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewHistories,
      getReferencedColumn: (t) => t.wordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewHistoriesTableFilterComposer(
            $db: $db,
            $table: $db.reviewHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WordsTableOrderingComposer
    extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableOrderingComposer({
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

  ColumnOrderings<String> get term => $composableBuilder(
    column: $table.term,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reading => $composableBuilder(
    column: $table.reading,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phonetic => $composableBuilder(
    column: $table.phonetic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meaning => $composableBuilder(
    column: $table.meaning,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get example => $composableBuilder(
    column: $table.example,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exampleTranslation => $composableBuilder(
    column: $table.exampleTranslation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFlagged => $composableBuilder(
    column: $table.isFlagged,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WordBooksTableOrderingComposer get wordBookId {
    final $$WordBooksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordBookId,
      referencedTable: $db.wordBooks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordBooksTableOrderingComposer(
            $db: $db,
            $table: $db.wordBooks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get term =>
      $composableBuilder(column: $table.term, builder: (column) => column);

  GeneratedColumn<String> get reading =>
      $composableBuilder(column: $table.reading, builder: (column) => column);

  GeneratedColumn<String> get phonetic =>
      $composableBuilder(column: $table.phonetic, builder: (column) => column);

  GeneratedColumn<String> get meaning =>
      $composableBuilder(column: $table.meaning, builder: (column) => column);

  GeneratedColumn<String> get example =>
      $composableBuilder(column: $table.example, builder: (column) => column);

  GeneratedColumn<String> get exampleTranslation => $composableBuilder(
    column: $table.exampleTranslation,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFlagged =>
      $composableBuilder(column: $table.isFlagged, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$WordBooksTableAnnotationComposer get wordBookId {
    final $$WordBooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordBookId,
      referencedTable: $db.wordBooks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordBooksTableAnnotationComposer(
            $db: $db,
            $table: $db.wordBooks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> learningProgressesRefs<T extends Object>(
    Expression<T> Function($$LearningProgressesTableAnnotationComposer a) f,
  ) {
    final $$LearningProgressesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.learningProgresses,
          getReferencedColumn: (t) => t.wordId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LearningProgressesTableAnnotationComposer(
                $db: $db,
                $table: $db.learningProgresses,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> reviewHistoriesRefs<T extends Object>(
    Expression<T> Function($$ReviewHistoriesTableAnnotationComposer a) f,
  ) {
    final $$ReviewHistoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewHistories,
      getReferencedColumn: (t) => t.wordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewHistoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.reviewHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordsTable,
          WordRow,
          $$WordsTableFilterComposer,
          $$WordsTableOrderingComposer,
          $$WordsTableAnnotationComposer,
          $$WordsTableCreateCompanionBuilder,
          $$WordsTableUpdateCompanionBuilder,
          (WordRow, $$WordsTableReferences),
          WordRow,
          PrefetchHooks Function({
            bool wordBookId,
            bool learningProgressesRefs,
            bool reviewHistoriesRefs,
          })
        > {
  $$WordsTableTableManager(_$AppDatabase db, $WordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> wordBookId = const Value.absent(),
                Value<String> term = const Value.absent(),
                Value<String?> reading = const Value.absent(),
                Value<String?> phonetic = const Value.absent(),
                Value<String> meaning = const Value.absent(),
                Value<String?> example = const Value.absent(),
                Value<String?> exampleTranslation = const Value.absent(),
                Value<bool> isFlagged = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => WordsCompanion(
                id: id,
                wordBookId: wordBookId,
                term: term,
                reading: reading,
                phonetic: phonetic,
                meaning: meaning,
                example: example,
                exampleTranslation: exampleTranslation,
                isFlagged: isFlagged,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int wordBookId,
                required String term,
                Value<String?> reading = const Value.absent(),
                Value<String?> phonetic = const Value.absent(),
                required String meaning,
                Value<String?> example = const Value.absent(),
                Value<String?> exampleTranslation = const Value.absent(),
                Value<bool> isFlagged = const Value.absent(),
                required DateTime createdAt,
              }) => WordsCompanion.insert(
                id: id,
                wordBookId: wordBookId,
                term: term,
                reading: reading,
                phonetic: phonetic,
                meaning: meaning,
                example: example,
                exampleTranslation: exampleTranslation,
                isFlagged: isFlagged,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$WordsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                wordBookId = false,
                learningProgressesRefs = false,
                reviewHistoriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (learningProgressesRefs) db.learningProgresses,
                    if (reviewHistoriesRefs) db.reviewHistories,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (wordBookId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.wordBookId,
                                    referencedTable: $$WordsTableReferences
                                        ._wordBookIdTable(db),
                                    referencedColumn: $$WordsTableReferences
                                        ._wordBookIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (learningProgressesRefs)
                        await $_getPrefetchedData<
                          WordRow,
                          $WordsTable,
                          LearningProgressRow
                        >(
                          currentTable: table,
                          referencedTable: $$WordsTableReferences
                              ._learningProgressesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WordsTableReferences(
                                db,
                                table,
                                p0,
                              ).learningProgressesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.wordId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (reviewHistoriesRefs)
                        await $_getPrefetchedData<
                          WordRow,
                          $WordsTable,
                          ReviewHistoryRow
                        >(
                          currentTable: table,
                          referencedTable: $$WordsTableReferences
                              ._reviewHistoriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WordsTableReferences(
                                db,
                                table,
                                p0,
                              ).reviewHistoriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.wordId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordsTable,
      WordRow,
      $$WordsTableFilterComposer,
      $$WordsTableOrderingComposer,
      $$WordsTableAnnotationComposer,
      $$WordsTableCreateCompanionBuilder,
      $$WordsTableUpdateCompanionBuilder,
      (WordRow, $$WordsTableReferences),
      WordRow,
      PrefetchHooks Function({
        bool wordBookId,
        bool learningProgressesRefs,
        bool reviewHistoriesRefs,
      })
    >;
typedef $$LearningProgressesTableCreateCompanionBuilder =
    LearningProgressesCompanion Function({
      Value<int> id,
      required int wordId,
      required String status,
      required int stepIndex,
      required int intervalMinutes,
      Value<int> correctCount,
      Value<int> wrongCount,
      Value<int> streak,
      required DateTime nextReviewAt,
      Value<DateTime?> lastReviewAt,
    });
typedef $$LearningProgressesTableUpdateCompanionBuilder =
    LearningProgressesCompanion Function({
      Value<int> id,
      Value<int> wordId,
      Value<String> status,
      Value<int> stepIndex,
      Value<int> intervalMinutes,
      Value<int> correctCount,
      Value<int> wrongCount,
      Value<int> streak,
      Value<DateTime> nextReviewAt,
      Value<DateTime?> lastReviewAt,
    });

final class $$LearningProgressesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LearningProgressesTable,
          LearningProgressRow
        > {
  $$LearningProgressesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WordsTable _wordIdTable(_$AppDatabase db) => db.words.createAlias(
    $_aliasNameGenerator(db.learningProgresses.wordId, db.words.id),
  );

  $$WordsTableProcessedTableManager get wordId {
    final $_column = $_itemColumn<int>('word_id')!;

    final manager = $$WordsTableTableManager(
      $_db,
      $_db.words,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LearningProgressesTableFilterComposer
    extends Composer<_$AppDatabase, $LearningProgressesTable> {
  $$LearningProgressesTableFilterComposer({
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

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stepIndex => $composableBuilder(
    column: $table.stepIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalMinutes => $composableBuilder(
    column: $table.intervalMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get streak => $composableBuilder(
    column: $table.streak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastReviewAt => $composableBuilder(
    column: $table.lastReviewAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WordsTableFilterComposer get wordId {
    final $$WordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableFilterComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LearningProgressesTableOrderingComposer
    extends Composer<_$AppDatabase, $LearningProgressesTable> {
  $$LearningProgressesTableOrderingComposer({
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

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stepIndex => $composableBuilder(
    column: $table.stepIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalMinutes => $composableBuilder(
    column: $table.intervalMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get streak => $composableBuilder(
    column: $table.streak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastReviewAt => $composableBuilder(
    column: $table.lastReviewAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WordsTableOrderingComposer get wordId {
    final $$WordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableOrderingComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LearningProgressesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LearningProgressesTable> {
  $$LearningProgressesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get stepIndex =>
      $composableBuilder(column: $table.stepIndex, builder: (column) => column);

  GeneratedColumn<int> get intervalMinutes => $composableBuilder(
    column: $table.intervalMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get streak =>
      $composableBuilder(column: $table.streak, builder: (column) => column);

  GeneratedColumn<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastReviewAt => $composableBuilder(
    column: $table.lastReviewAt,
    builder: (column) => column,
  );

  $$WordsTableAnnotationComposer get wordId {
    final $$WordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableAnnotationComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LearningProgressesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LearningProgressesTable,
          LearningProgressRow,
          $$LearningProgressesTableFilterComposer,
          $$LearningProgressesTableOrderingComposer,
          $$LearningProgressesTableAnnotationComposer,
          $$LearningProgressesTableCreateCompanionBuilder,
          $$LearningProgressesTableUpdateCompanionBuilder,
          (LearningProgressRow, $$LearningProgressesTableReferences),
          LearningProgressRow,
          PrefetchHooks Function({bool wordId})
        > {
  $$LearningProgressesTableTableManager(
    _$AppDatabase db,
    $LearningProgressesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LearningProgressesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LearningProgressesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LearningProgressesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> wordId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> stepIndex = const Value.absent(),
                Value<int> intervalMinutes = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<int> wrongCount = const Value.absent(),
                Value<int> streak = const Value.absent(),
                Value<DateTime> nextReviewAt = const Value.absent(),
                Value<DateTime?> lastReviewAt = const Value.absent(),
              }) => LearningProgressesCompanion(
                id: id,
                wordId: wordId,
                status: status,
                stepIndex: stepIndex,
                intervalMinutes: intervalMinutes,
                correctCount: correctCount,
                wrongCount: wrongCount,
                streak: streak,
                nextReviewAt: nextReviewAt,
                lastReviewAt: lastReviewAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int wordId,
                required String status,
                required int stepIndex,
                required int intervalMinutes,
                Value<int> correctCount = const Value.absent(),
                Value<int> wrongCount = const Value.absent(),
                Value<int> streak = const Value.absent(),
                required DateTime nextReviewAt,
                Value<DateTime?> lastReviewAt = const Value.absent(),
              }) => LearningProgressesCompanion.insert(
                id: id,
                wordId: wordId,
                status: status,
                stepIndex: stepIndex,
                intervalMinutes: intervalMinutes,
                correctCount: correctCount,
                wrongCount: wrongCount,
                streak: streak,
                nextReviewAt: nextReviewAt,
                lastReviewAt: lastReviewAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LearningProgressesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({wordId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (wordId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.wordId,
                                referencedTable:
                                    $$LearningProgressesTableReferences
                                        ._wordIdTable(db),
                                referencedColumn:
                                    $$LearningProgressesTableReferences
                                        ._wordIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LearningProgressesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LearningProgressesTable,
      LearningProgressRow,
      $$LearningProgressesTableFilterComposer,
      $$LearningProgressesTableOrderingComposer,
      $$LearningProgressesTableAnnotationComposer,
      $$LearningProgressesTableCreateCompanionBuilder,
      $$LearningProgressesTableUpdateCompanionBuilder,
      (LearningProgressRow, $$LearningProgressesTableReferences),
      LearningProgressRow,
      PrefetchHooks Function({bool wordId})
    >;
typedef $$ReviewHistoriesTableCreateCompanionBuilder =
    ReviewHistoriesCompanion Function({
      Value<int> id,
      required int wordId,
      required String result,
      required String direction,
      required DateTime reviewedAt,
      required int previousIntervalMinutes,
      required int newIntervalMinutes,
    });
typedef $$ReviewHistoriesTableUpdateCompanionBuilder =
    ReviewHistoriesCompanion Function({
      Value<int> id,
      Value<int> wordId,
      Value<String> result,
      Value<String> direction,
      Value<DateTime> reviewedAt,
      Value<int> previousIntervalMinutes,
      Value<int> newIntervalMinutes,
    });

final class $$ReviewHistoriesTableReferences
    extends
        BaseReferences<_$AppDatabase, $ReviewHistoriesTable, ReviewHistoryRow> {
  $$ReviewHistoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WordsTable _wordIdTable(_$AppDatabase db) => db.words.createAlias(
    $_aliasNameGenerator(db.reviewHistories.wordId, db.words.id),
  );

  $$WordsTableProcessedTableManager get wordId {
    final $_column = $_itemColumn<int>('word_id')!;

    final manager = $$WordsTableTableManager(
      $_db,
      $_db.words,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReviewHistoriesTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewHistoriesTable> {
  $$ReviewHistoriesTableFilterComposer({
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

  ColumnFilters<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get previousIntervalMinutes => $composableBuilder(
    column: $table.previousIntervalMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get newIntervalMinutes => $composableBuilder(
    column: $table.newIntervalMinutes,
    builder: (column) => ColumnFilters(column),
  );

  $$WordsTableFilterComposer get wordId {
    final $$WordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableFilterComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewHistoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewHistoriesTable> {
  $$ReviewHistoriesTableOrderingComposer({
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

  ColumnOrderings<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get previousIntervalMinutes => $composableBuilder(
    column: $table.previousIntervalMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get newIntervalMinutes => $composableBuilder(
    column: $table.newIntervalMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  $$WordsTableOrderingComposer get wordId {
    final $$WordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableOrderingComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewHistoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewHistoriesTable> {
  $$ReviewHistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get result =>
      $composableBuilder(column: $table.result, builder: (column) => column);

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get previousIntervalMinutes => $composableBuilder(
    column: $table.previousIntervalMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get newIntervalMinutes => $composableBuilder(
    column: $table.newIntervalMinutes,
    builder: (column) => column,
  );

  $$WordsTableAnnotationComposer get wordId {
    final $$WordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableAnnotationComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewHistoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReviewHistoriesTable,
          ReviewHistoryRow,
          $$ReviewHistoriesTableFilterComposer,
          $$ReviewHistoriesTableOrderingComposer,
          $$ReviewHistoriesTableAnnotationComposer,
          $$ReviewHistoriesTableCreateCompanionBuilder,
          $$ReviewHistoriesTableUpdateCompanionBuilder,
          (ReviewHistoryRow, $$ReviewHistoriesTableReferences),
          ReviewHistoryRow,
          PrefetchHooks Function({bool wordId})
        > {
  $$ReviewHistoriesTableTableManager(
    _$AppDatabase db,
    $ReviewHistoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewHistoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewHistoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewHistoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> wordId = const Value.absent(),
                Value<String> result = const Value.absent(),
                Value<String> direction = const Value.absent(),
                Value<DateTime> reviewedAt = const Value.absent(),
                Value<int> previousIntervalMinutes = const Value.absent(),
                Value<int> newIntervalMinutes = const Value.absent(),
              }) => ReviewHistoriesCompanion(
                id: id,
                wordId: wordId,
                result: result,
                direction: direction,
                reviewedAt: reviewedAt,
                previousIntervalMinutes: previousIntervalMinutes,
                newIntervalMinutes: newIntervalMinutes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int wordId,
                required String result,
                required String direction,
                required DateTime reviewedAt,
                required int previousIntervalMinutes,
                required int newIntervalMinutes,
              }) => ReviewHistoriesCompanion.insert(
                id: id,
                wordId: wordId,
                result: result,
                direction: direction,
                reviewedAt: reviewedAt,
                previousIntervalMinutes: previousIntervalMinutes,
                newIntervalMinutes: newIntervalMinutes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReviewHistoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({wordId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (wordId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.wordId,
                                referencedTable:
                                    $$ReviewHistoriesTableReferences
                                        ._wordIdTable(db),
                                referencedColumn:
                                    $$ReviewHistoriesTableReferences
                                        ._wordIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReviewHistoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReviewHistoriesTable,
      ReviewHistoryRow,
      $$ReviewHistoriesTableFilterComposer,
      $$ReviewHistoriesTableOrderingComposer,
      $$ReviewHistoriesTableAnnotationComposer,
      $$ReviewHistoriesTableCreateCompanionBuilder,
      $$ReviewHistoriesTableUpdateCompanionBuilder,
      (ReviewHistoryRow, $$ReviewHistoriesTableReferences),
      ReviewHistoryRow,
      PrefetchHooks Function({bool wordId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WordBooksTableTableManager get wordBooks =>
      $$WordBooksTableTableManager(_db, _db.wordBooks);
  $$WordsTableTableManager get words =>
      $$WordsTableTableManager(_db, _db.words);
  $$LearningProgressesTableTableManager get learningProgresses =>
      $$LearningProgressesTableTableManager(_db, _db.learningProgresses);
  $$ReviewHistoriesTableTableManager get reviewHistories =>
      $$ReviewHistoriesTableTableManager(_db, _db.reviewHistories);
}
