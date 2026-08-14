import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/services.dart' show AssetBundle;

import '../core/database/database.dart';

/// assets/wordbooks 아래의 기본 단어장을 로컬 DB에 등록한다.
///
/// 자산 파일의 필드명(index.json: id/name/description/language/category/itemCount/asset,
/// 단어장 JSON: id/name/description/language/category/version/items[{term,meaning,reading?,example?}])은
/// 추측하지 않고 실제 파일을 읽어 확인한 값 그대로 사용한다.
/// index.json의 asset 값(`wordbooks/xxx.json`)에는 `assets/` 접두사가 없으므로 로드 시 붙여야 한다.
class BuiltinWordbookService {
  BuiltinWordbookService({required this.database, required this.assetBundle});

  final AppDatabase database;
  final AssetBundle assetBundle;

  static const _indexAssetPath = 'assets/wordbooks/index.json';

  Future<void> seedIfNeeded() async {
    final indexJson = jsonDecode(await assetBundle.loadString(_indexAssetPath)) as Map<String, dynamic>;
    final entries = (indexJson['wordbooks'] as List).cast<Map<String, dynamic>>();

    for (final entry in entries) {
      final sourceId = entry['id'] as String;
      final alreadyRegistered = await (database.select(database.wordBooks)
            ..where((tbl) => tbl.sourceId.equals(sourceId)))
          .getSingleOrNull();
      if (alreadyRegistered != null) continue;

      await _importWordbook(entry: entry, sourceId: sourceId);
    }
  }

  Future<void> _importWordbook({
    required Map<String, dynamic> entry,
    required String sourceId,
  }) async {
    final assetPath = 'assets/${entry['asset'] as String}';
    final wordbookJson = jsonDecode(await assetBundle.loadString(assetPath)) as Map<String, dynamic>;
    final items = (wordbookJson['items'] as List).cast<Map<String, dynamic>>();
    final now = DateTime.now().toUtc();

    await database.transaction(() async {
      final wordBookId = await database.into(database.wordBooks).insert(
            WordBooksCompanion.insert(
              name: wordbookJson['name'] as String,
              description: wordbookJson['description'] as String,
              sourceType: 'builtin',
              sourceId: sourceId,
              contentVersion: Value(wordbookJson['version'] as int?),
              language: Value(wordbookJson['language'] as String?),
              createdAt: now,
            ),
          );

      await database.batch((batch) {
        batch.insertAll(
          database.words,
          items.map(
            (item) => WordsCompanion.insert(
              wordBookId: wordBookId,
              term: item['term'] as String,
              reading: Value(item['reading'] as String?),
              phonetic: Value(item['phonetic'] as String?),
              meaning: item['meaning'] as String,
              example: Value(item['example'] as String?),
              exampleTranslation: Value(item['exampleTranslation'] as String?),
              createdAt: now,
            ),
          ),
        );
      });
    });
  }
}
