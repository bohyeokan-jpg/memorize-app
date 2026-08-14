import 'package:flutter_tts/flutter_tts.dart';

/// 단어 발음을 기기 내장 TTS 엔진으로 읽어준다. 서버/네트워크를 쓰지 않는다.
class TtsService {
  TtsService() : _flutterTts = FlutterTts();

  final FlutterTts _flutterTts;

  static const _defaultLocale = 'en-US';
  static const _localeByLanguage = {
    'en': 'en-US',
    'ja': 'ja-JP',
  };

  Future<void> speak(String text, {String? language}) async {
    if (text.isEmpty) return;
    await _flutterTts.stop();
    await _flutterTts.setLanguage(_localeByLanguage[language] ?? _defaultLocale);
    await _flutterTts.speak(text);
  }
}
