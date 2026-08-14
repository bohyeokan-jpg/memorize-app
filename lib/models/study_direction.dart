enum StudyDirection { termToMeaning, meaningToTerm }

extension StudyDirectionCode on StudyDirection {
  String get code {
    switch (this) {
      case StudyDirection.termToMeaning:
        return 'TERM_TO_MEANING';
      case StudyDirection.meaningToTerm:
        return 'MEANING_TO_TERM';
    }
  }

  static StudyDirection fromCode(String code) {
    switch (code) {
      case 'TERM_TO_MEANING':
        return StudyDirection.termToMeaning;
      case 'MEANING_TO_TERM':
        return StudyDirection.meaningToTerm;
      default:
        throw ArgumentError('Unknown StudyDirection code: $code');
    }
  }
}

enum ReviewOutcome { correct, wrong }

extension ReviewOutcomeCode on ReviewOutcome {
  String get code {
    switch (this) {
      case ReviewOutcome.correct:
        return 'CORRECT';
      case ReviewOutcome.wrong:
        return 'WRONG';
    }
  }

  static ReviewOutcome fromCode(String code) {
    switch (code) {
      case 'CORRECT':
        return ReviewOutcome.correct;
      case 'WRONG':
        return ReviewOutcome.wrong;
      default:
        throw ArgumentError('Unknown ReviewOutcome code: $code');
    }
  }
}
