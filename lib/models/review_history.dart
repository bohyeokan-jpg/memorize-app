import 'study_direction.dart';

class ReviewHistory {
  final int? id;
  final int wordId;
  final ReviewOutcome result;
  final StudyDirection direction;
  final DateTime reviewedAt;
  final int previousIntervalMinutes;
  final int newIntervalMinutes;

  const ReviewHistory({
    this.id,
    required this.wordId,
    required this.result,
    required this.direction,
    required this.reviewedAt,
    required this.previousIntervalMinutes,
    required this.newIntervalMinutes,
  });
}
