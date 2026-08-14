import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database/database.dart';
import '../models/word_book.dart';
import '../repositories/wordbook_repository.dart';
import '../services/builtin_wordbook_service.dart';
import '../services/tts_service.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});

final wordBookRepositoryProvider = Provider<WordBookRepository>((ref) {
  return WordBookRepository(ref.watch(appDatabaseProvider));
});

/// 앱 최초 실행 시(그리고 이후 실행에서 이미 등록되어 있으면 스킵) 기본 단어장을 DB에 적재한다.
final builtinWordbookSeedProvider = FutureProvider<void>((ref) async {
  final database = ref.watch(appDatabaseProvider);
  final service = BuiltinWordbookService(database: database, assetBundle: rootBundle);
  await service.seedIfNeeded();
});

final wordBooksProvider = FutureProvider<List<WordBook>>((ref) async {
  await ref.watch(builtinWordbookSeedProvider.future);
  return ref.watch(wordBookRepositoryProvider).allWordBooks();
});

final wordBookByIdProvider = FutureProvider.autoDispose.family<WordBook?, int>((ref, wordBookId) async {
  return ref.watch(wordBookRepositoryProvider).wordBookById(wordBookId);
});

final ttsServiceProvider = Provider<TtsService>((ref) => TtsService());
