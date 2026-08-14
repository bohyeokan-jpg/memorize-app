# 개발 결정 기록

## 2026-08-14 — Phase 1~4 일부: 프로젝트 세팅, DB, 학습(문제) 화면

- **패키지 버전**: 설치된 Flutter 3.32.1 / Dart 3.8.1 SDK와 호환되는 버전으로 고정.
  - flutter_riverpod ^2.6.1 (CLAUDE.md가 Riverpod 2.x를 명시적으로 지정하므로 3.x는 사용하지 않음)
  - go_router ^17.0.0, intl ^0.20.2 (최신 버전은 Dart 3.9+ 요구, 3.8.1에서 resolve 실패)
  - drift ^2.31.0 / drift_dev ^2.31.0 / drift_flutter ^0.2.5 (drift 2.32+ 는 sqlite3 3.x를 요구, drift_flutter 0.2.x는 아직 sqlite3 2.x대이므로 호환되는 마지막 조합으로 고정)
  - build_runner ^2.15.1 (2.15.2+는 Dart 3.11 요구)
- **DB 연결 방식**: `sqlite3_flutter_libs`를 직접 쓰지 않고 `drift_flutter`의 `driftDatabase()` 헬퍼 사용(공식 문서가 권장하는 최신 방식, 코드가 더 단순함).
- **플랫폼 범위**: `flutter create --platforms=android`로 Android만 생성(SPEC이 Play Console/Android 알림 권한을 언급하므로). 로컬 확인용으로 web/windows 플랫폼도 추가했으나 실제 앱 배포 대상은 Android.
- **WordBook 스키마**: SPEC §31 표에 있는 컬럼만 사용(id/name/description/sourceType/sourceId/createdAt) + §32에서 요구한 `contentVersion`만 추가. index.json/단어장 JSON의 `language`/`category`/`itemCount` 필드는 스펙 표에 없으므로 DB 컬럼으로 추가하지 않음.
- **Drift 생성 클래스 이름 충돌**: Drift가 테이블명에서 자동 생성하는 데이터 클래스명(`Word`, `WordBook` 등)이 `lib/models/`의 도메인 모델명과 겹쳐서, `@DataClassName('WordRow')` 등으로 Drift 쪽 이름을 변경함. 도메인 모델(`lib/models/*.dart`)이 앱 전체에서 쓰이는 이름을 유지.
- **오늘 학습 대상(§25) 큐 로직**: "최근 오답 단어"를 별도 조회 없이 `LearningProgress.status == LEARNING && streak == 0`(오답 시 항상 이렇게 세팅됨)으로 판별. `ReviewHistory`를 추가로 조회하지 않아 단순함.
- **학습 방향(§23)**: 이번 작업 범위에서는 기본값인 "단어 → 뜻" 방향만 구현. "뜻 → 단어"/"혼합" 및 설정 화면은 아직 없음(Phase 5 범위).
- **build_runner 실행 이슈**: `.dart_tool/build/entrypoint/build.dart.aot` 파일을 쓰지 못해 코드 생성이 실패함. 원인은 프로젝트 경로에 포함된 한글 폴더명("바탕 화면")으로 추정되며, `dart run build_runner build --force-jit`(AOT 대신 JIT 컴파일 사용)로 우회하여 해결.
- **[해결됨] Android Gradle 빌드 실패 → 프로젝트 경로 이전**: `flutter run`으로 실제 기기/에뮬레이터 실행 시 Gradle이 "Your project path contains non-ASCII characters... Please move your project to a different directory" 오류로 빌드를 거부함(공식 Android 버그 http://b.android.com/95744, 경로의 한글 "바탕 화면"이 원인). 사용자 확인 후 프로젝트 전체를 `C:\Users\bhan\OneDrive\바탕 화면\memorize_app` → **`C:\projects\memorize_app`**로 이동(사용자의 다른 Flutter 프로젝트와 동일한 위치 규칙). 이후 build_runner는 `--force-jit` 없이도 정상 동작했고, Android 빌드/설치/실행이 모두 정상화됨. **앞으로 이 프로젝트의 작업 경로는 `C:\projects\memorize_app`이다.** OneDrive 쪽 원본 폴더는 삭제하지 않고 남겨둠(사용자가 필요 시 직접 정리).
- **학습 화면 인터랙션 추가(사용자 요청, 2026-08-14)**: SPEC에 없던 3가지 기능을 사용자가 직접 요청하여 추가함.
  1. 카드를 **탭**하면 뜻(+예문)이 보인다 — 기존 [뜻 보기] 버튼 대신/추가로 카드 전체를 탭 가능 영역으로 만듦.
  2. 뜻이 보인 상태에서 **좌우로 스와이프**하면 다음 단어로 넘어간다 — 오른쪽 스와이프=알았어요, 왼쪽 스와이프=몰랐어요로 매핑(정답/오답 기록에 영향을 주므로, 공짜로 그냥 넘기는 제스처가 아니라 기존 버튼과 동일한 의미로 처리). 버튼도 그대로 남겨 스와이프를 모르는 사용자도 쓸 수 있게 함.
  3. **다시 보기 체크(북마크)**: `Words.isFlagged`(bool, 기본 false) 컬럼을 추가하고, 학습 화면 AppBar에 북마크 아이콘을 둬서 단어별로 켜고 끌 수 있게 함. 학습 스케줄(간격 반복)에는 영향을 주지 않는 단순 표시. 플래그된 단어를 모아보는 별도 화면은 아직 없음(요청 시 추가 필요).
- 위 3가지 인터랙션은 실제 Android 에뮬레이터(Pixel_9)에서 탭/스와이프/북마크 토글까지 전부 스크린샷으로 동작 확인함.

## 2026-08-14 (2차) — 발음 기호 + 발음 듣기(TTS) 추가 (사용자 요청)

- **발음 기호(IPA) 데이터 소스**: 621개 영어 단어(english_basic_300/toeic_basic_200/travel_english_100)에 대해 IPA를 손으로 입력하지 않고, 공개 도메인인 **CMU Pronouncing Dictionary**(Carnegie Mellon University)를 다운로드해 ARPABET→IPA 표준 변환표로 오프라인 변환함. 621개 중 619개 매칭 성공, 2개(문장형 표현 "Do you have Wi-Fi?", "What's the Wi-Fi password?")는 사전에 없어 phonetic 없이 둠(추측해서 채우지 않음).
  - 변환 스크립트: 이 세션의 scratchpad에만 존재(`generate_phonetics.dart`/`merge_phonetics.dart`), 프로젝트에는 결과물(JSON의 `phonetic` 필드)만 반영됨.
  - **알려진 한계**: CMU dict는 강세 없는 모음을 항상 축약형(schwa)으로 주지 않는다(AH0/ER0만 ə/ɚ로 보정, 나머지는 사전 표기 그대로). 그래서 일부 단어(예: accept → æksˈɛpt)가 실제 축약 발음(/əkˈsɛpt/)과 모음 하나가 다를 수 있음 — 오류라기보다 사전 표기 관례 차이.
  - 일본어 단어장은 이미 있는 `reading`(히라가나)이 같은 역할을 하므로 IPA를 추가하지 않음.
- **DB 스키마 확장**: `Words.phonetic`(nullable text), `WordBooks.language`(nullable text, TTS 음성 선택용)를 추가함. SPEC 표에는 없던 컬럼이지만, 사용자가 직접 요청한 기능(발음 기호 표시, 언어별 TTS 음성)을 구현하는 데 필요해서 추가한 것으로 임의 확장이 아님.
- **발음 듣기**: `flutter_tts`(^4.2.5) 사용, 서버/네트워크 없이 기기 내장 TTS 엔진으로 재생. 단어장의 `language`(en/ja)로 로케일(en-US/ja-JP)을 고름.
  - **Android 빌드 설정 변경**: flutter_tts가 `minSdk 24`, `compileSdk 36`, `NDK 27.0.12077973`을 요구해서 `android/app/build.gradle.kts`를 그에 맞게 올림(기존 minSdk는 Flutter 기본값). Android 7.0(2016) 미만 기기는 이제 설치 불가하지만, 실사용 영향은 미미하다고 판단.
- **발음 기호 노출 위치**: 문제 화면(뜻 공개 전)에도 발음 기호/듣기 버튼을 보여줌 — reading(§62)과 달리 발음은 "뜻을 알려주는 정보"가 아니라서 미리 보여줘도 문제가 되지 않는다고 판단.
- Android 에뮬레이터에서 영어(abandon, airport)/일본어(こんにちは) 모두 발음 기호 표시 + TTS 재생(logcat에 "Utterance ID has completed" 확인)까지 검증함. 기존 DB에 새 컬럼이 없어 스키마 불일치가 나서, 마이그레이션 코드 대신 에뮬레이터 앱 데이터를 초기화하고 재설치함(아직 출시 전이라 실사용자 데이터가 없으므로 이 방법을 씀 — **출시 후에는 실제 스키마 마이그레이션이 필요**).

## 2026-08-14 (3차) — 예문 + 해석 추가 (사용자 요청)

- **범위**: `Words.exampleTranslation`(nullable text) 컬럼 추가. 뜻 공개 화면에서 기존 `example`(예문) 아래에 이탤릭체로 예문을, 그 아래 회색 작은 글씨로 한국어 해석을 표시(둘 다 null이 아닐 때만).
- **콘텐츠 작성 방식**: IPA와 달리 예문은 "사전에서 찾아야 하는 사실"이 아니라 새로 짓는 문장이므로, 외부 데이터를 가져오지 않고 직접 작성함(자연스럽고 짧은 문장 + 정확한 한국어 번역).
  - english_basic_300: 321개 전부
  - toeic_basic_200: 192개 전부
  - travel_english_100: 101개 중 49개만 작성. 나머지 52개("Thank you.", "Turn left." 등)는 **항목 자체가 이미 완성된 문장/표현**이라 별도 예문을 붙이는 게 의미가 없다고 판단해 비워둠(예문 없이 뜻만 표시됨 — 오류 아님).
  - japanese_basic_100: 100개 중 75개 작성. 나머지 25개(こんにちは, ありがとう, ください 등 인사말·완성된 표현)도 위와 같은 이유로 비워둠.
- Android 에뮬레이터에서 예문 있는 단어(abandon)와 예문 없는 단어(こんにちは) 모두 화면이 깨지지 않고 올바르게 표시되는 것을 확인함.
