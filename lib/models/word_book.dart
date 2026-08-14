enum WordBookSource { builtin, user }

extension WordBookSourceCode on WordBookSource {
  String get code {
    switch (this) {
      case WordBookSource.builtin:
        return 'builtin';
      case WordBookSource.user:
        return 'user';
    }
  }

  static WordBookSource fromCode(String code) {
    switch (code) {
      case 'builtin':
        return WordBookSource.builtin;
      case 'user':
        return WordBookSource.user;
      default:
        throw ArgumentError('Unknown WordBookSource code: $code');
    }
  }
}

class WordBook {
  final int? id;
  final String name;
  final String description;
  final WordBookSource sourceType;
  final String sourceId;
  final int? contentVersion;
  final String? language;
  final DateTime createdAt;

  const WordBook({
    this.id,
    required this.name,
    required this.description,
    required this.sourceType,
    required this.sourceId,
    this.contentVersion,
    this.language,
    required this.createdAt,
  });
}
