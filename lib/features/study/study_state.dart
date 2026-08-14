import '../../models/word.dart';

class StudyQueueState {
  final List<Word> queue;
  final int currentIndex;
  final bool revealed;

  const StudyQueueState({
    required this.queue,
    required this.currentIndex,
    required this.revealed,
  });

  bool get isFinished => currentIndex >= queue.length;

  Word? get currentWord => isFinished ? null : queue[currentIndex];

  StudyQueueState copyWith({
    List<Word>? queue,
    int? currentIndex,
    bool? revealed,
  }) {
    return StudyQueueState(
      queue: queue ?? this.queue,
      currentIndex: currentIndex ?? this.currentIndex,
      revealed: revealed ?? this.revealed,
    );
  }
}
