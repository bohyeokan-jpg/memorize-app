import 'package:drift/drift.dart' show Value;

import '../core/database/database.dart' as db;
import '../models/learning_progress.dart';
import '../models/learning_status.dart';
import '../models/study_direction.dart';
import '../models/word.dart';
import '../models/word_book.dart';
import '../services/spaced_repetition_service.dart';
import '../services/study_queue_builder.dart';

WordBook _toWordBook(db.WordBookRow row) => WordBook(
      id: row.id,
      name: row.name,
      description: row.description,
      sourceType: WordBookSourceCode.fromCode(row.sourceType),
      sourceId: row.sourceId,
      contentVersion: row.contentVersion,
      language: row.language,
      createdAt: row.createdAt,
    );

Word _toWord(db.WordRow row) => Word(
      id: row.id,
      wordBookId: row.wordBookId,
      term: row.term,
      reading: row.reading,
      phonetic: row.phonetic,
      meaning: row.meaning,
      example: row.example,
      exampleTranslation: row.exampleTranslation,
      isFlagged: row.isFlagged,
      createdAt: row.createdAt,
    );

LearningProgress _toLearningProgress(db.LearningProgressRow row) => LearningProgress(
      id: row.id,
      wordId: row.wordId,
      status: LearningStatusCode.fromCode(row.status),
      stepIndex: row.stepIndex,
      intervalMinutes: row.intervalMinutes,
      correctCount: row.correctCount,
      wrongCount: row.wrongCount,
      streak: row.streak,
      nextReviewAt: row.nextReviewAt,
      lastReviewAt: row.lastReviewAt,
    );

/// Drift DB와 도메인 모델(lib/models) 사이를 잇는 계층.
/// 향후 서버 동기화가 추가되어도 이 계층의 인터페이스는 유지될 수 있게 한다.
class WordBookRepository {
  WordBookRepository(this._database);

  final db.AppDatabase _database;
  final _spacedRepetitionService = const SpacedRepetitionService();
  final _studyQueueBuilder = const StudyQueueBuilder();

  Future<List<WordBook>> allWordBooks() async {
    final rows = await _database.select(_database.wordBooks).get();
    return rows.map(_toWordBook).toList();
  }

  Future<WordBook?> wordBookById(int id) async {
    final row =
        await (_database.select(_database.wordBooks)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toWordBook(row);
  }

  Future<List<Word>> wordsOf(int wordBookId) async {
    final rows = await (_database.select(_database.words)..where((t) => t.wordBookId.equals(wordBookId))).get();
    return rows.map(_toWord).toList();
  }

  /// "다시 보기" 체크 표시를 켜고 끈다. 학습 스케줄에는 영향을 주지 않는 단순 표시다.
  Future<void> setWordFlag({required int wordId, required bool isFlagged}) async {
    await (_database.update(_database.words)..where((t) => t.id.equals(wordId)))
        .write(db.WordsCompanion(isFlagged: Value(isFlagged)));
  }

  Future<LearningProgress?> progressForWord(int wordId) async {
    final row = await (_database.select(_database.learningProgresses)..where((t) => t.wordId.equals(wordId)))
        .getSingleOrNull();
    return row == null ? null : _toLearningProgress(row);
  }

  Future<List<Word>> todayQueue({
    required int wordBookId,
    required DateTime now,
    int newWordLimit = 20,
  }) async {
    final words = await wordsOf(wordBookId);
    final wordIds = words.map((w) => w.id!).toList();

    final progressRows = wordIds.isEmpty
        ? <db.LearningProgressRow>[]
        : await (_database.select(_database.learningProgresses)..where((t) => t.wordId.isIn(wordIds))).get();
    final progressByWordId = {for (final row in progressRows) row.wordId: _toLearningProgress(row)};

    final candidates = words.map((w) => QueueCandidate(word: w, progress: progressByWordId[w.id])).toList();

    return _studyQueueBuilder.build(candidates: candidates, now: now, newWordLimit: newWordLimit);
  }

  /// 학습 화면에서 [알았어요]/[몰랐어요] 응답을 기록하고,
  /// SpacedRepetitionService로 계산한 다음 복습 일정을 저장한다.
  Future<LearningProgress> submitAnswer({
    required Word word,
    required StudyDirection direction,
    required bool isCorrect,
    required DateTime now,
  }) async {
    return _database.transaction(() async {
      final existingRow = await (_database.select(_database.learningProgresses)
            ..where((t) => t.wordId.equals(word.id!)))
          .getSingleOrNull();
      final current = existingRow == null ? LearningProgress.initial(wordId: word.id!, now: now) : _toLearningProgress(existingRow);

      final result = _spacedRepetitionService.calculate(current: current, isCorrect: isCorrect, now: now);
      final updated = result.updatedProgress;

      final progressCompanion = db.LearningProgressesCompanion(
        wordId: Value(updated.wordId),
        status: Value(updated.status.code),
        stepIndex: Value(updated.stepIndex),
        intervalMinutes: Value(updated.intervalMinutes),
        correctCount: Value(updated.correctCount),
        wrongCount: Value(updated.wrongCount),
        streak: Value(updated.streak),
        nextReviewAt: Value(updated.nextReviewAt),
        lastReviewAt: Value(updated.lastReviewAt),
      );

      if (existingRow == null) {
        await _database.into(_database.learningProgresses).insert(progressCompanion);
      } else {
        await (_database.update(_database.learningProgresses)..where((t) => t.id.equals(existingRow.id)))
            .write(progressCompanion);
      }

      await _database.into(_database.reviewHistories).insert(
            db.ReviewHistoriesCompanion.insert(
              wordId: word.id!,
              result: (isCorrect ? ReviewOutcome.correct : ReviewOutcome.wrong).code,
              direction: direction.code,
              reviewedAt: now,
              previousIntervalMinutes: result.previousIntervalMinutes,
              newIntervalMinutes: result.newIntervalMinutes,
            ),
          );

      return updated;
    });
  }
}
