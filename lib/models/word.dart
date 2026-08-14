class Word {
  final int? id;
  final int wordBookId;
  final String term;
  final String? reading;
  final String? phonetic;
  final String meaning;
  final String? example;
  final String? exampleTranslation;
  final bool isFlagged;
  final DateTime createdAt;

  const Word({
    this.id,
    required this.wordBookId,
    required this.term,
    this.reading,
    this.phonetic,
    required this.meaning,
    this.example,
    this.exampleTranslation,
    this.isFlagged = false,
    required this.createdAt,
  });

  Word copyWith({bool? isFlagged}) {
    return Word(
      id: id,
      wordBookId: wordBookId,
      term: term,
      reading: reading,
      phonetic: phonetic,
      meaning: meaning,
      example: example,
      exampleTranslation: exampleTranslation,
      isFlagged: isFlagged ?? this.isFlagged,
      createdAt: createdAt,
    );
  }
}
