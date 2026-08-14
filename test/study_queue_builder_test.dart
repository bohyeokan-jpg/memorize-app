import 'package:flutter_test/flutter_test.dart';
import 'package:memorize_app/models/learning_progress.dart';
import 'package:memorize_app/models/learning_status.dart';
import 'package:memorize_app/models/word.dart';
import 'package:memorize_app/services/study_queue_builder.dart';

void main() {
  final builder = const StudyQueueBuilder();
  final now = DateTime.utc(2026, 1, 1, 12, 0, 0);

  Word word(int id) => Word(
        id: id,
        wordBookId: 1,
        term: 'term$id',
        meaning: 'meaning$id',
        createdAt: now,
      );

  test('복습 예정 지난 단어가 신규 단어보다 먼저 온다', () {
    final dueWord = word(1);
    final freshWord = word(2);

    final result = builder.build(
      candidates: [
        QueueCandidate(word: freshWord),
        QueueCandidate(
          word: dueWord,
          progress: LearningProgress(
            wordId: 1,
            status: LearningStatus.review,
            stepIndex: 1,
            intervalMinutes: 1440,
            correctCount: 1,
            wrongCount: 0,
            streak: 1,
            nextReviewAt: now.subtract(const Duration(minutes: 1)),
          ),
        ),
      ],
      now: now,
    );

    expect(result.map((w) => w.id), [1, 2]);
  });

  test('최근 오답 단어는 아직 복습 시간이 안 지났어도 신규 단어보다 먼저 온다', () {
    final freshWord = word(1);
    final wrongWord = word(2);

    final result = builder.build(
      candidates: [
        QueueCandidate(word: freshWord),
        QueueCandidate(
          word: wrongWord,
          progress: LearningProgress(
            wordId: 2,
            status: LearningStatus.learning,
            stepIndex: 0,
            intervalMinutes: 10,
            correctCount: 0,
            wrongCount: 1,
            streak: 0,
            nextReviewAt: now.add(const Duration(minutes: 9)),
            lastReviewAt: now,
          ),
        ),
      ],
      now: now,
    );

    expect(result.map((w) => w.id), [2, 1]);
  });

  test('신규 단어는 newWordLimit 만큼만 포함된다', () {
    final candidates = List.generate(30, (i) => QueueCandidate(word: word(i)));

    final result = builder.build(candidates: candidates, now: now, newWordLimit: 20);

    expect(result.length, 20);
  });

  test('아직 복습 시간이 안 된 REVIEW/MASTERED 단어는 큐에서 제외된다', () {
    final notDueWord = word(1);

    final result = builder.build(
      candidates: [
        QueueCandidate(
          word: notDueWord,
          progress: LearningProgress(
            wordId: 1,
            status: LearningStatus.review,
            stepIndex: 2,
            intervalMinutes: 4320,
            correctCount: 2,
            wrongCount: 0,
            streak: 2,
            nextReviewAt: now.add(const Duration(days: 1)),
          ),
        ),
      ],
      now: now,
    );

    expect(result, isEmpty);
  });
}
