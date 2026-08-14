import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

@DataClassName('WordBookRow')
class WordBooks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get sourceType => text()(); // 'builtin' | 'user'
  TextColumn get sourceId => text().unique()();
  IntColumn get contentVersion => integer().nullable()();
  TextColumn get language => text().nullable()(); // TTS 음성 선택용 (예: 'en', 'ja')
  DateTimeColumn get createdAt => dateTime()();
}

@DataClassName('WordRow')
class Words extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get wordBookId => integer().references(WordBooks, #id)();
  TextColumn get term => text()();
  TextColumn get reading => text().nullable()();
  TextColumn get phonetic => text().nullable()(); // IPA 발음 기호
  TextColumn get meaning => text()();
  TextColumn get example => text().nullable()();
  TextColumn get exampleTranslation => text().nullable()();
  BoolColumn get isFlagged => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
}

@DataClassName('LearningProgressRow')
class LearningProgresses extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get wordId => integer().references(Words, #id)();
  TextColumn get status => text()(); // NEW | LEARNING | REVIEW | MASTERED
  IntColumn get stepIndex => integer()();
  IntColumn get intervalMinutes => integer()();
  IntColumn get correctCount => integer().withDefault(const Constant(0))();
  IntColumn get wrongCount => integer().withDefault(const Constant(0))();
  IntColumn get streak => integer().withDefault(const Constant(0))();
  DateTimeColumn get nextReviewAt => dateTime()();
  DateTimeColumn get lastReviewAt => dateTime().nullable()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {wordId}
      ];
}

@DataClassName('ReviewHistoryRow')
class ReviewHistories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get wordId => integer().references(Words, #id)();
  TextColumn get result => text()(); // CORRECT | WRONG
  TextColumn get direction => text()(); // TERM_TO_MEANING | MEANING_TO_TERM
  DateTimeColumn get reviewedAt => dateTime()();
  IntColumn get previousIntervalMinutes => integer()();
  IntColumn get newIntervalMinutes => integer()();
}

@DriftDatabase(tables: [WordBooks, Words, LearningProgresses, ReviewHistories])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          // Drift/SQLite는 FK 제약을 기본적으로 켜지 않는다. 명시적으로 켜지 않으면
          // CASCADE·참조 무결성이 조용히 무시된다.
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'memorize_app');
  }
}
