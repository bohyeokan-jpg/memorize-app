import 'learning_status.dart';

class LearningProgress {
  final int? id;
  final int wordId;
  final LearningStatus status;
  final int stepIndex;
  final int intervalMinutes;
  final int correctCount;
  final int wrongCount;
  final int streak;
  final DateTime nextReviewAt;
  final DateTime? lastReviewAt;

  const LearningProgress({
    this.id,
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

  factory LearningProgress.initial({required int wordId, required DateTime now}) {
    return LearningProgress(
      wordId: wordId,
      status: LearningStatus.newWord,
      stepIndex: 0,
      intervalMinutes: 0,
      correctCount: 0,
      wrongCount: 0,
      streak: 0,
      nextReviewAt: now,
      lastReviewAt: null,
    );
  }

  LearningProgress copyWith({
    int? id,
    LearningStatus? status,
    int? stepIndex,
    int? intervalMinutes,
    int? correctCount,
    int? wrongCount,
    int? streak,
    DateTime? nextReviewAt,
    DateTime? lastReviewAt,
  }) {
    return LearningProgress(
      id: id ?? this.id,
      wordId: wordId,
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
}
