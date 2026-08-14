import 'package:flutter_test/flutter_test.dart';
import 'package:memorize_app/models/learning_progress.dart';
import 'package:memorize_app/models/learning_status.dart';
import 'package:memorize_app/services/spaced_repetition_service.dart';

void main() {
  final service = const SpacedRepetitionService();
  final now = DateTime.utc(2026, 1, 1, 0, 0, 0);

  LearningProgress progressWith({
    required LearningStatus status,
    int stepIndex = 0,
    int streak = 0,
  }) {
    return LearningProgress(
      wordId: 1,
      status: status,
      stepIndex: stepIndex,
      intervalMinutes: intervalLadderMinutes[stepIndex],
      correctCount: 0,
      wrongCount: 0,
      streak: streak,
      nextReviewAt: now,
    );
  }

  test('NEW + 정답 -> LEARNING, step 0(10분), streak 1', () {
    final result = service.calculate(
      current: progressWith(status: LearningStatus.newWord),
      isCorrect: true,
      now: now,
    );
    expect(result.updatedProgress.status, LearningStatus.learning);
    expect(result.updatedProgress.stepIndex, 0);
    expect(result.updatedProgress.streak, 1);
    expect(result.newIntervalMinutes, 10);
    expect(result.updatedProgress.nextReviewAt, now.add(const Duration(minutes: 10)));
  });

  test('NEW + 오답 -> LEARNING, step 0(10분), streak 0', () {
    final result = service.calculate(
      current: progressWith(status: LearningStatus.newWord),
      isCorrect: false,
      now: now,
    );
    expect(result.updatedProgress.status, LearningStatus.learning);
    expect(result.updatedProgress.stepIndex, 0);
    expect(result.updatedProgress.streak, 0);
  });

  test('LEARNING(step0) + 정답 -> REVIEW, step1(1일)', () {
    final result = service.calculate(
      current: progressWith(status: LearningStatus.learning, stepIndex: 0, streak: 1),
      isCorrect: true,
      now: now,
    );
    expect(result.updatedProgress.status, LearningStatus.review);
    expect(result.updatedProgress.stepIndex, 1);
    expect(result.newIntervalMinutes, 1440);
    expect(result.updatedProgress.streak, 2);
  });

  test('REVIEW(step4) + 정답 -> MASTERED, step5(30일)', () {
    final result = service.calculate(
      current: progressWith(status: LearningStatus.review, stepIndex: 4, streak: 4),
      isCorrect: true,
      now: now,
    );
    expect(result.updatedProgress.status, LearningStatus.mastered);
    expect(result.updatedProgress.stepIndex, 5);
    expect(result.newIntervalMinutes, 43200);
  });

  test('REVIEW + 오답 -> LEARNING, step0(10분), streak 0', () {
    final result = service.calculate(
      current: progressWith(status: LearningStatus.review, stepIndex: 3, streak: 5),
      isCorrect: false,
      now: now,
    );
    expect(result.updatedProgress.status, LearningStatus.learning);
    expect(result.updatedProgress.stepIndex, 0);
    expect(result.newIntervalMinutes, 10);
    expect(result.updatedProgress.streak, 0);
  });

  test('MASTERED + 정답 -> MASTERED 유지, step5, streak 증가', () {
    final result = service.calculate(
      current: progressWith(status: LearningStatus.mastered, stepIndex: 5, streak: 10),
      isCorrect: true,
      now: now,
    );
    expect(result.updatedProgress.status, LearningStatus.mastered);
    expect(result.updatedProgress.stepIndex, 5);
    expect(result.updatedProgress.streak, 11);
  });

  test('MASTERED + 오답 -> LEARNING, step0, streak 0', () {
    final result = service.calculate(
      current: progressWith(status: LearningStatus.mastered, stepIndex: 5, streak: 10),
      isCorrect: false,
      now: now,
    );
    expect(result.updatedProgress.status, LearningStatus.learning);
    expect(result.updatedProgress.stepIndex, 0);
    expect(result.updatedProgress.streak, 0);
  });

  test('now는 파라미터로 주입되며 nextReviewAt 계산에 사용된다', () {
    final injectedNow = DateTime.utc(2030, 5, 5);
    final result = service.calculate(
      current: progressWith(status: LearningStatus.learning, stepIndex: 1, streak: 1),
      isCorrect: true,
      now: injectedNow,
    );
    expect(result.updatedProgress.nextReviewAt, injectedNow.add(const Duration(days: 3)));
    expect(result.updatedProgress.lastReviewAt, injectedNow);
  });
}
