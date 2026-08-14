enum LearningStatus { newWord, learning, review, mastered }

extension LearningStatusCode on LearningStatus {
  String get code {
    switch (this) {
      case LearningStatus.newWord:
        return 'NEW';
      case LearningStatus.learning:
        return 'LEARNING';
      case LearningStatus.review:
        return 'REVIEW';
      case LearningStatus.mastered:
        return 'MASTERED';
    }
  }

  static LearningStatus fromCode(String code) {
    switch (code) {
      case 'NEW':
        return LearningStatus.newWord;
      case 'LEARNING':
        return LearningStatus.learning;
      case 'REVIEW':
        return LearningStatus.review;
      case 'MASTERED':
        return LearningStatus.mastered;
      default:
        throw ArgumentError('Unknown LearningStatus code: $code');
    }
  }
}
