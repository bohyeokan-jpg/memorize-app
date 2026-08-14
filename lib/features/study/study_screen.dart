import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../models/word.dart';
import 'study_controller.dart';
import 'study_state.dart';

/// 좌우로 스와이프했다고 판단하는 최소 속도(픽셀/초).
const double _swipeVelocityThreshold = 200;

class StudyScreen extends ConsumerWidget {
  const StudyScreen({super.key, required this.wordBookId});

  final int wordBookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(studyControllerProvider(wordBookId));
    final controller = ref.read(studyControllerProvider(wordBookId).notifier);
    final currentWord = asyncState.valueOrNull?.currentWord;

    return Scaffold(
      appBar: AppBar(
        title: const Text('학습'),
        actions: [
          if (currentWord != null)
            IconButton(
              tooltip: '다시 보기 표시',
              onPressed: controller.toggleFlag,
              icon: Icon(currentWord.isFlagged ? Icons.bookmark : Icons.bookmark_border),
            ),
        ],
      ),
      body: asyncState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('문제를 불러오지 못했습니다.\n$error')),
        data: (state) => _StudyBody(wordBookId: wordBookId, state: state),
      ),
    );
  }
}

class _StudyBody extends ConsumerWidget {
  const _StudyBody({required this.wordBookId, required this.state});

  final int wordBookId;
  final StudyQueueState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (state.queue.isEmpty) {
      return const Center(child: Text('오늘 학습할 단어가 없습니다.'));
    }

    if (state.isFinished) {
      return const Center(child: Text('오늘의 학습을 모두 완료했습니다.'));
    }

    final word = state.currentWord!;
    final controller = ref.read(studyControllerProvider(wordBookId).notifier);
    final wordBook = ref.watch(wordBookByIdProvider(wordBookId)).valueOrNull;

    void speak() {
      ref.read(ttsServiceProvider).speak(word.term, language: wordBook?.language);
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '오늘의 학습 ${state.currentIndex + 1} / ${state.queue.length}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 48),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: state.revealed ? null : controller.reveal,
              onHorizontalDragEnd: !state.revealed
                  ? null
                  : (details) {
                      final velocity = details.primaryVelocity ?? 0;
                      if (velocity > _swipeVelocityThreshold) {
                        controller.answer(true); // 오른쪽으로 스와이프 = 알았어요
                      } else if (velocity < -_swipeVelocityThreshold) {
                        controller.answer(false); // 왼쪽으로 스와이프 = 몰랐어요
                      }
                    },
              child: Center(
                child: state.revealed
                    ? _RevealedContent(word: word, onSpeak: speak)
                    : _QuestionContent(word: word, onSpeak: speak),
              ),
            ),
          ),
          if (!state.revealed)
            Text(
              '카드를 탭하면 뜻이 보여요',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.outline),
              textAlign: TextAlign.center,
            )
          else ...[
            Text(
              '왼쪽으로 스와이프: 몰랐어요 · 오른쪽으로 스와이프: 알았어요',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.outline),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => controller.answer(false),
                    child: const Text('몰랐어요'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: () => controller.answer(true),
                    child: const Text('알았어요'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// 단어(term) + 발음 기호 + 발음 듣기 버튼을 함께 보여주는 헤더.
/// 문제 화면과 정답 공개 화면에서 공통으로 쓴다.
class _TermHeader extends StatelessWidget {
  const _TermHeader({required this.word, required this.onSpeak, required this.style});

  final Word word;
  final VoidCallback onSpeak;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: Text(word.term, style: style, textAlign: TextAlign.center)),
            IconButton(
              tooltip: '발음 듣기',
              onPressed: onSpeak,
              icon: const Icon(Icons.volume_up),
            ),
          ],
        ),
        if (word.phonetic != null)
          Text(
            '[${word.phonetic}]',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(context).colorScheme.outline),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}

class _QuestionContent extends StatelessWidget {
  const _QuestionContent({required this.word, required this.onSpeak});

  final Word word;
  final VoidCallback onSpeak;

  @override
  Widget build(BuildContext context) {
    // §62: 문제 화면에서는 reading을 숨긴다. 발음 기호/듣기는 뜻을 알려주지 않으므로 미리 보여준다.
    return _TermHeader(word: word, onSpeak: onSpeak, style: Theme.of(context).textTheme.displaySmall);
  }
}

class _RevealedContent extends StatelessWidget {
  const _RevealedContent({required this.word, required this.onSpeak});

  final Word word;
  final VoidCallback onSpeak;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _TermHeader(word: word, onSpeak: onSpeak, style: textTheme.displaySmall),
        if (word.reading != null) ...[
          const SizedBox(height: 4),
          Text(
            word.reading!,
            style: textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.outline),
            textAlign: TextAlign.center,
          ),
        ],
        const SizedBox(height: 24),
        Text(word.meaning, style: textTheme.headlineSmall, textAlign: TextAlign.center),
        if (word.example != null) ...[
          const SizedBox(height: 16),
          Text(
            word.example!,
            style: textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          if (word.exampleTranslation != null) ...[
            const SizedBox(height: 4),
            Text(
              word.exampleTranslation!,
              style: textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.outline),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ],
    );
  }
}
