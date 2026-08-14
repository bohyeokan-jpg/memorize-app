import '../models/learning_progress.dart';
import '../models/learning_status.dart';
import '../models/word.dart';

class QueueCandidate {
  final Word word;
  final LearningProgress? progress;

  const QueueCandidate({required this.word, this.progress});
}

/// §25 오늘 학습 대상 우선순위를 계산하는 순수 함수.
/// 1. 복습 예정 시간이 지난 단어
/// 2. 최근 오답 단어 (아직 복습 예정 시간은 안 지났지만 방금 틀린 단어)
/// 3. 신규 단어 (기본 20개, newWordLimit로 조절)
class StudyQueueBuilder {
  const StudyQueueBuilder();

  List<Word> build({
    required List<QueueCandidate> candidates,
    required DateTime now,
    int newWordLimit = 20,
  }) {
    final due = <QueueCandidate>[];
    final recentlyWrong = <QueueCandidate>[];
    final fresh = <QueueCandidate>[];

    for (final candidate in candidates) {
      final progress = candidate.progress;
      if (progress == null) {
        fresh.add(candidate);
        continue;
      }
      if (!progress.nextReviewAt.isAfter(now)) {
        due.add(candidate);
      } else if (progress.status == LearningStatus.learning && progress.streak == 0) {
        recentlyWrong.add(candidate);
      }
    }

    due.sort((a, b) => a.progress!.nextReviewAt.compareTo(b.progress!.nextReviewAt));
    recentlyWrong.sort(
      (a, b) => (b.progress!.lastReviewAt ?? DateTime.utc(0)).compareTo(a.progress!.lastReviewAt ?? DateTime.utc(0)),
    );
    final limitedFresh = fresh.take(newWordLimit);

    return [...due, ...recentlyWrong, ...limitedFresh].map((c) => c.word).toList();
  }
}
