# 암기 앱 MVP

Flutter 기반 개인용 암기 앱. 회원가입·서버 없음. 모든 데이터 로컬 저장.

핵심 루프: **단어장 선택/가져오기 → 학습 → 복습**

---

## 문서

전체 사양은 `docs/SPEC.md`, 수정·보강 사항은 `docs/SPEC_ADDENDUM_v2.md`에 있다.
**두 문서가 충돌하면 SPEC_ADDENDUM_v2.md가 우선한다.** 구현 전 양쪽 해당 섹션을 모두 읽는다.
추측으로 구현하지 않는다. 특히 자산 파일의 필드명(`items` / `asset` / `itemCount` / `version`)은 §48에 명시된 그대로다.

진행 중 내린 결정은 `docs/DECISIONS.md`에 누적 기록한다.

---

## 절대 규칙

1. **MVP 범위를 임의로 확장하지 않는다.** SPEC §2의 제외 목록(회원가입/로그인/서버/동기화/결제/AI/광고/소셜)은 어떤 이유로도 추가하지 않는다.
2. **판단이 애매하면 임의로 결정하지 않는다.** 가장 단순한 쪽을 선택한 뒤 그 선택을 사용자에게 보고한다.
3. **패키지 버전을 추측해서 적지 않는다.** pub.dev에서 현재 SDK와 호환되는 안정 버전을 확인 후 고정한다.
4. 요청받지 않은 리팩터링, 파일 이동, 기능 추가를 하지 않는다.

---

## 확정된 설계 (변경 금지)

- `LearningProgress`는 `stepIndex`(0~5) + `intervalMinutes`를 쓴다. `intervalDays`는 존재하지 않는다.
- 간격 사다리: `10분 / 1일 / 3일 / 7일 / 14일 / 30일`
- 모든 datetime은 **UTC 저장**, 표시할 때만 로컬 변환.
- `Word.reading`은 nullable. 일본어 단어장에만 값이 있다.
- `Word.example`은 nullable. **기본 단어장 4종에는 example이 하나도 없다.** null이면 해당 UI 영역을 렌더링하지 않는다.
- 기본 단어장과 사용자 단어장은 **동일한 학습 엔진**을 쓴다.
- 콘텐츠 데이터(WordBook/Word)와 학습 데이터(LearningProgress/ReviewHistory)를 분리한다.

---

## 아키텍처

```
lib/
  core/database/      Drift
  core/notification/
  core/theme/
  core/utils/
  features/           home / wordbook / import / study / review / settings
  models/
  repositories/       Repository 패턴 (향후 서버 동기화 대비)
  services/
    spaced_repetition_service.dart
    file_import_service.dart
    builtin_wordbook_service.dart
    study_queue_builder.dart
  main.dart
```

- 상태관리: Riverpod 2.x의 `Notifier` / `AsyncNotifier`. `StateNotifier`·`ChangeNotifier` 사용 금지.
- 라우팅: go_router
- **`SpacedRepetitionService`와 `FileImportService`는 Flutter 의존성 없는 순수 Dart로 작성한다.** UI 없이 테스트 가능해야 한다.
- `SpacedRepetitionService.calculate()`는 `now`를 파라미터로 주입받는다. 내부에서 `DateTime.now()`를 호출하지 않는다.

---

## 명령어

```bash
flutter analyze          # 경고 0건이어야 함
flutter test             # 전체 통과해야 함
dart run build_runner build --delete-conflicting-outputs
flutter run              # 실기기/에뮬레이터
```

---

## Phase 게이트

각 Phase는 아래를 **모두** 통과해야 다음으로 넘어간다. 하나라도 실패하면 진행하지 않고 보고한다.

1. `flutter analyze` 경고 0건
2. `flutter test` 전체 통과
3. **앱이 빌드되고 실행된다.** 중간 Phase에서도 실행 불가 상태로 남기지 않는다.
4. 해당 Phase의 SPEC §46 체크리스트 항목이 실제로 동작한다.

Phase 종료 시 반드시 보고한다.
- 동작하는 것
- 아직 미구현인 것
- 임의로 판단해서 결정한 것 (있다면 전부)

그리고 `docs/DECISIONS.md`에 결정사항을 append 한다.

---

## 자주 틀리는 지점

- **CSV 인코딩**: UTF-8 BOM → UTF-8 → **CP949 폴백** 순. CP949 폴백이 없으면 한국 사용자의 엑셀 CSV가 전부 깨진다. (SPEC §A-5)
- **구분자 감지**: "가장 많이 등장한 문자"로 고르면 안 된다. 뜻에 쉼표가 흔히 들어있다. 행별 등장 횟수의 **분산이 최소**인 구분자를 고른다. (SPEC §54)
- **자산 JSON 키**: 배열은 `items`(`words` 아님), 버전은 `version`(`contentVersion` 아님), 경로는 `asset`에 `wordbooks/...`만 있으므로 로드 시 `assets/` 접두사를 붙인다.
- **Drift CASCADE**: `PRAGMA foreign_keys = ON`을 명시적으로 켜지 않으면 동작하지 않는다.
- **알림**: `timezone` 초기화 없이는 일일 반복 스케줄이 동작하지 않는다. Android 13+ `POST_NOTIFICATIONS` 런타임 권한 필요.

---

## 최우선 회귀 테스트

앱이 내보낸 `sample_wordbook.csv` / `.txt` / `.xlsx`를 **그대로 다시 업로드했을 때 10단어가 정상 임포트**되어야 한다.
이 하나로 BOM·CRLF·구분자 감지·따옴표 이스케이프·헤더 인식이 동시에 검증된다.
Phase 3에서 가장 먼저 통과시킬 테스트다.
