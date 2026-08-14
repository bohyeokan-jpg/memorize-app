import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../models/study_direction.dart';
import 'study_state.dart';

final studyControllerProvider =
    AsyncNotifierProvider.autoDispose.family<StudyController, StudyQueueState, int>(StudyController.new);

/// §22~24 학습 화면 상태. 오늘의 학습 큐를 불러오고, [뜻 보기]/[알았어요]/[몰랐어요] 응답을 처리한다.
class StudyController extends AutoDisposeFamilyAsyncNotifier<StudyQueueState, int> {
  @override
  Future<StudyQueueState> build(int wordBookId) async {
    final repository = ref.read(wordBookRepositoryProvider);
    final queue = await repository.todayQueue(
      wordBookId: wordBookId,
      now: DateTime.now().toUtc(),
    );
    return StudyQueueState(queue: queue, currentIndex: 0, revealed: false);
  }

  void reveal() {
    final current = state.valueOrNull;
    if (current == null || current.isFinished) return;
    state = AsyncData(current.copyWith(revealed: true));
  }

  Future<void> answer(bool isCorrect) async {
    final current = state.valueOrNull;
    if (current == null || current.isFinished || !current.revealed) return;
    final word = current.currentWord;
    if (word == null) return;

    final repository = ref.read(wordBookRepositoryProvider);
    await repository.submitAnswer(
      word: word,
      direction: StudyDirection.termToMeaning,
      isCorrect: isCorrect,
      now: DateTime.now().toUtc(),
    );

    state = AsyncData(
      current.copyWith(currentIndex: current.currentIndex + 1, revealed: false),
    );
  }

  /// 현재 단어의 "다시 보기" 체크 표시를 켜고 끈다. 학습 스케줄에는 영향을 주지 않는다.
  Future<void> toggleFlag() async {
    final current = state.valueOrNull;
    if (current == null || current.isFinished) return;
    final word = current.currentWord;
    if (word == null) return;

    final updatedWord = word.copyWith(isFlagged: !word.isFlagged);
    await ref.read(wordBookRepositoryProvider).setWordFlag(
          wordId: word.id!,
          isFlagged: updatedWord.isFlagged,
        );

    final updatedQueue = [...current.queue];
    updatedQueue[current.currentIndex] = updatedWord;
    state = AsyncData(current.copyWith(queue: updatedQueue));
  }
}
