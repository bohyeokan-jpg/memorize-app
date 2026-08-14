import '../models/learning_progress.dart';
import '../models/learning_status.dart';

/// stepIndex(0~5)에 대응하는 간격(분). §A-6.
const List<int> intervalLadderMinutes = [10, 1440, 4320, 10080, 20160, 43200];

class ReviewResult {
  final LearningProgress updatedProgress;
  final int previousIntervalMinutes;
  final int newIntervalMinutes;

  const ReviewResult({
    required this.updatedProgress,
    required this.previousIntervalMinutes,
    required this.newIntervalMinutes,
  });
}

/// Flutter 의존성이 없는 순수 Dart 서비스. UI 없이 테스트 가능해야 한다.
class SpacedRepetitionService {
  const SpacedRepetitionService();

  ReviewResult calculate({
    required LearningProgress current,
    required bool isCorrect,
    required DateTime now,
  }) {
    final previousIntervalMinutes = current.intervalMinutes;

    int nextStepIndex;
    LearningStatus nextStatus;
    int nextStreak;

    if (current.status == LearningStatus.newWord) {
      // NEW 단어는 결과와 무관하게 stepIndex 0(10분)에서 시작한다.
      nextStepIndex = 0;
      nextStatus = LearningStatus.learning;
      nextStreak = isCorrect ? 1 : 0;
    } else if (!isCorrect) {
      nextStepIndex = 0;
      nextStatus = LearningStatus.learning;
      nextStreak = 0;
    } else if (current.status == LearningStatus.mastered) {
      nextStepIndex = 5;
      nextStatus = LearningStatus.mastered;
      nextStreak = current.streak + 1;
    } else {
      nextStepIndex = current.stepIndex + 1 > 5 ? 5 : current.stepIndex + 1;
      nextStatus = nextStepIndex >= 5 ? LearningStatus.mastered : LearningStatus.review;
      nextStreak = current.streak + 1;
    }

    final newIntervalMinutes = intervalLadderMinutes[nextStepIndex];
    final nextReviewAt = now.add(Duration(minutes: newIntervalMinutes));

    final updated = current.copyWith(
      status: nextStatus,
      stepIndex: nextStepIndex,
      intervalMinutes: newIntervalMinutes,
      correctCount: current.correctCount + (isCorrect ? 1 : 0),
      wrongCount: current.wrongCount + (isCorrect ? 0 : 1),
      streak: nextStreak,
      nextReviewAt: nextReviewAt,
      lastReviewAt: now,
    );

    return ReviewResult(
      updatedProgress: updated,
      previousIntervalMinutes: previousIntervalMinutes,
      newIntervalMinutes: newIntervalMinutes,
    );
  }
}
