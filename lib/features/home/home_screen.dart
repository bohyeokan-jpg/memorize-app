import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wordBooksAsync = ref.watch(wordBooksProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('암기 앱')),
      body: wordBooksAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('단어장을 불러오지 못했습니다.\n$error')),
        data: (wordBooks) {
          if (wordBooks.isEmpty) {
            return const Center(child: Text('등록된 단어장이 없습니다.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: wordBooks.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final wordBook = wordBooks[index];
              return Card(
                child: ListTile(
                  title: Text(wordBook.name),
                  subtitle: Text(wordBook.description),
                  trailing: FilledButton(
                    onPressed: () => context.push('/study/${wordBook.id}'),
                    child: const Text('학습 시작'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
