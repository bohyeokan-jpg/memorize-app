# 암기 앱 MVP 개발 지시서 — 보강분 v2

본 문서는 기존 지시서(§1~§47)에 이어지는 보강 조항이다.
**기존 조항과 충돌하는 내용이 있으면 본 보강분을 우선한다.**

v2는 실제 제공된 `memory_app_mvp_assets_fixed.zip`의 파일 구조를 기준으로 작성되었다.
자산 파일의 필드명을 추측하지 말고 본 문서의 스키마를 그대로 따른다.

---

# PART A. 기존 조항 수정

## A-1. §27 / §31 스키마 수정 (필수)

기존 `LearningProgress.intervalDays`(int)로는 §24의 "10분" 단계를 표현할 수 없다.

```
LearningProgress

id              int, PK
wordId          int, FK -> Word.id, UNIQUE
status          text     ('NEW' | 'LEARNING' | 'REVIEW' | 'MASTERED')
stepIndex       int      (0~5, 간격 사다리 인덱스)
intervalMinutes int      (현재 적용된 간격, 분 단위)
correctCount    int
wrongCount      int
streak          int      (연속 정답 횟수)
nextReviewAt    datetime (UTC 저장)
lastReviewAt    datetime (UTC 저장, nullable)
```

```
ReviewHistory

id                      int, PK
wordId                  int, FK -> Word.id
result                  text ('CORRECT' | 'WRONG')
direction               text ('TERM_TO_MEANING' | 'MEANING_TO_TERM')
reviewedAt              datetime (UTC 저장)
previousIntervalMinutes int
newIntervalMinutes      int
```

- 모든 datetime은 **UTC로 저장**하고, 표시·집계 시에만 로컬 타임존으로 변환한다.
- `intervalDays`라는 이름은 코드 어디에도 남기지 않는다.

## A-2. §31 Word 테이블 수정 — reading 컬럼 추가

일본어 기본 단어장 100개 중 58개가 한자를 포함한다(`野菜`, `病院`, `新しい` 등).
읽기 없이 표시하면 "히라가나를 뗀 입문자"라는 대상 사용자가 읽을 수 없다.

```
Word

id          int, PK
wordBookId  int, FK -> WordBook.id
term        text
reading     text, nullable   ← 추가
meaning     text
example     text, nullable
createdAt   datetime
```

- `reading`은 일본어 단어장에만 채워진다. 영어 단어장은 전부 null이다.
- 사용자 업로드(CSV/XLSX/TXT)에서는 `reading`을 매핑하지 않는다. 항상 null이다. 열 매핑 UI에 reading 항목을 추가하지 않는다.
- 학습 화면 표시 규칙은 §62를 따른다.

## A-3. §5 / §12 / §30 — example 부재 처리

**기본 단어장 4종에는 example이 단 하나도 없다.** 전부 `term` + `meaning`뿐이다.
example은 사용자 업로드 단어장에서만 존재할 수 있다.

따라서:
- 학습 화면·단어 상세 화면에서 `example`이 null이면 **해당 영역을 렌더링하지 않는다.** 빈 박스나 "-"를 표시하지 않는다.
- 기본 단어장 상세 화면에 example 열 자체를 만들지 않는다.
- §12 미리보기의 예문 열은 사용자 업로드 흐름에만 해당한다.

## A-4. §13 중복 판정 기준 확정

중복 판정 기준은 **정규화된 term 문자열 일치**로 한다.

정규화 규칙:
- 앞뒤 공백 제거
- 연속 공백 1칸으로 축약
- 영문 소문자 변환

중복 검사 범위는 **업로드 파일 내부**로 한정한다. 기존 단어장과의 교차 검사는 하지 않는다.
중복 제거 시 **먼저 등장한 행을 남긴다.**

## A-5. §14 인코딩 처리 확정 (CSV / TXT 공통)

아래 순서로 디코딩을 시도한다.

1. BOM 검사 → UTF-8 BOM / UTF-16 LE·BE BOM이 있으면 해당 인코딩으로 확정
2. UTF-8 strict 디코딩 시도 → 성공하면 UTF-8
3. 실패 시 **CP949(EUC-KR)로 폴백**
4. 그래도 실패: "파일 인코딩을 인식할 수 없습니다. UTF-8로 저장 후 다시 시도해주세요."

> 앱이 배포하는 `sample_wordbook.csv` 자체가 **UTF-8 BOM + CRLF**이므로 1번 경로는 반드시 동작해야 한다.
> 한국 사용자가 Excel에서 "CSV(쉼표로 분리)"로 저장하면 CP949가 나오므로 3번 폴백이 없으면 CSV 업로드는 실사용에서 대부분 실패한다.

개행은 `\r\n`, `\n`, `\r` 모두 처리한다.

## A-6. §24 간격 반복 알고리즘 확정

```
stepIndex : 0 = 10분
            1 = 1일    (1440분)
            2 = 3일    (4320분)
            3 = 7일    (10080분)
            4 = 14일   (20160분)
            5 = 30일   (43200분)
```

| 현재 status | 결과 | 다음 stepIndex | 다음 status | streak |
|---|---|---|---|---|
| NEW | 정답 | 0 | LEARNING | 1 |
| NEW | 오답 | 0 | LEARNING | 0 |
| LEARNING / REVIEW | 정답 | min(step+1, 5) | step이 5에 도달하면 MASTERED, 아니면 REVIEW | streak+1 |
| LEARNING / REVIEW | 오답 | 0 | LEARNING | 0 |
| MASTERED | 정답 | 5 유지 | MASTERED | streak+1 |
| MASTERED | 오답 | 0 | LEARNING | 0 |

- `nextReviewAt = now + ladder[stepIndex]`
- **NEW 단어는 첫 학습 결과와 무관하게 stepIndex 0(10분)에서 시작한다.** (§24 "첫 학습 → 10분" 문구를 그대로 따른다)
- MASTERED도 학습 대상에서 제외하지 않는다. 30일 간격으로 계속 순환한다.

`SpacedRepetitionService`는 **순수 함수**로 작성한다.

```dart
ReviewResult calculate({
  required LearningProgress current,
  required bool isCorrect,
  required DateTime now,   // 반드시 주입받는다. 내부에서 DateTime.now()를 호출하지 않는다.
});
```

## A-7. §28 취약 단어 정의 확정

- `correctCount + wrongCount >= 3` (기존 "2회 이상"에서 상향. 2회면 0/50/100%만 나와 순위가 무의미하다)
- 정답률 = `correctCount / (correctCount + wrongCount)`
- 정답률 **70% 미만**만 취약 단어로 간주
- 정답률 오름차순, **최대 30개**. 동률이면 `wrongCount` 많은 순

취약 단어 학습은 **복습 스케줄에 영향을 주지 않는다.**
정답/오답을 `ReviewHistory`에 기록하고 `correctCount`/`wrongCount`는 갱신하되,
`stepIndex`와 `nextReviewAt`은 변경하지 않는다.

## A-8. §18 단어장 개수 표기

수정된 자산 기준 실제 개수는 다음과 같다. 파일명의 숫자는 개수를 의미하지 않는다.

| 단어장 | 파일 | 개수 |
|---|---|---|
| 영어 필수 기초 | english_basic_300.json | **321** |
| TOEIC 기본 단어 | toeic_basic_200.json | **192** |
| 여행 영어 | travel_english_100.json | **101** |
| 일본어 기초 | japanese_basic_100.json | **100** |

UI에 표시하는 개수는 `index.json`의 `itemCount`가 아니라 **DB에 실제 적재된 Word 행 수를 집계**해서 표시한다.

---

# PART B. 자산 파일 규격 (§48 대체)

**§48은 본 섹션으로 완전히 대체한다.** 아래는 실제 제공 파일의 구조이며 추측이 아니다.

## §48-1. 디렉터리

```
assets/
  wordbooks/
    index.json
    english_basic_300.json
    toeic_basic_200.json
    travel_english_100.json
    japanese_basic_100.json
  templates/
    sample_wordbook.xlsx
    sample_wordbook.csv
    sample_wordbook.txt
```

`pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/wordbooks/
    - assets/templates/
```

## §48-2. index.json

```json
{
  "version": 1,
  "wordbooks": [
    {
      "id": "english_basic_300",
      "name": "영어 필수 기초",
      "description": "일상과 학습에 자주 쓰이는 기본 영어 단어",
      "language": "en",
      "category": "영어",
      "itemCount": 321,
      "asset": "wordbooks/english_basic_300.json"
    }
  ]
}
```

주의사항:

- 최상위 버전 필드명은 `version`이다. `contentVersion`이 아니다.
- `asset` 값은 **assets 루트 기준 상대 경로**다. Flutter에서 로드할 때는 접두사를 붙인다.
  `rootBundle.loadString('assets/' + entry.asset)`
- `category` 값은 `영어` / `시험` / `여행` / `일본어` 4종이다. §18 추천 단어장 탭에서 **카테고리별 섹션 헤더로 그룹핑**한다.
- `itemCount`는 표시용으로 신뢰하지 않는다(§A-8).

## §48-3. 단어장 JSON

```json
{
  "id": "japanese_basic_100",
  "name": "일본어 기초",
  "description": "일상에서 자주 쓰는 일본어 기초 단어와 표현",
  "language": "ja",
  "category": "일본어",
  "version": 1,
  "items": [
    { "term": "こんにちは", "meaning": "안녕하세요" },
    { "term": "野菜", "meaning": "야채", "reading": "やさい" }
  ]
}
```

주의사항:

- 배열 키는 **`items`**다. `words`가 아니다.
- 항목 필드는 `term`, `meaning`(필수), `reading`(일본어만, optional), `example`(현재 전 파일에 없음).
- 파싱 시 `reading`과 `example`은 반드시 nullable로 처리한다. 키가 존재하지 않는 것이 정상이다.
- `WordBook.sourceId`에 최상위 `id` 문자열을 저장한다. 중복 적재 방지 키로 사용한다.

## §48-4. 템플릿 파일 규격

MVP에서 템플릿 파일을 코드로 생성하지 않는다. assets에 있는 파일을 그대로 내보낸다.

| 파일 | 규격 |
|---|---|
| sample_wordbook.csv | UTF-8 **BOM 포함**, **CRLF**, 헤더 `단어,뜻,예문`, 10행. 뜻에 쉼표 포함 시 큰따옴표 이스케이프 |
| sample_wordbook.txt | UTF-8, LF, 구분자 `\|`, 헤더 없음, 10행. 뜻에 쉼표 포함 (`abandon\|버리다, 포기하다`) |
| sample_wordbook.xlsx | 시트명 `단어장`, 1행 헤더 `단어 / 뜻 / 예문`, A1:C11 |

**필수 회귀 테스트(§58 참조):**
앱이 내보낸 3개 샘플 파일을 **사용자가 그대로 다시 업로드했을 때 10개 단어가 정상 임포트되어야 한다.**
이 왕복 테스트가 통과하면 BOM 처리, CRLF 처리, 구분자 감지, 쉼표 이스케이프, 헤더 인식이 한 번에 검증된다.

특히 `sample_wordbook.txt`의 각 줄은 `|`와 `,`를 **동시에** 포함한다.
구분자 감지가 단순히 "가장 많이 등장한 문자"를 고르면 `,`를 골라 전부 깨진다. §54의 감지 규칙을 반드시 따른다.

---

# PART C. 신규 조항

## §49. 일일 학습 큐 규칙

`StudyQueueBuilder`가 오늘의 학습 큐를 만든다.

**상한**
- 복습 단어 최대 **100개**
- 신규 단어 최대 **설정값(기본 20개)**

**우선순위 (앞이 높음)**
1. `nextReviewAt <= now` 이면서 `status == LEARNING` (오답 후 재복습 대기)
2. `nextReviewAt <= now` 이면서 `status IN (REVIEW, MASTERED)` — `nextReviewAt` 오름차순
3. `status == NEW` — 같은 단어장 내 등록 순서

**출제 순서**
복습 먼저 → 신규 나중. 섞지 않는다.

**복습 큐가 100개를 초과할 때**
홈에 안내: "밀린 복습이 <N>개 있어요. 오늘은 100개만 보여드릴게요."

## §50. 세션 내 오답 재출제

§24의 "오답 → 10분 후 재복습"을 그대로 적용하면 사용자가 앱을 껐다 10분 뒤 다시 켜야 한다.

- 세션 중 오답 처리된 단어는 **현재 큐의 맨 뒤에 다시 삽입**한다.
- 재삽입은 **단어당 세션 내 최대 1회**로 제한한다.
- 재출제에서 정답이면 §A-6 규칙대로 stepIndex를 1로 올린다.
- 재출제 결과도 `ReviewHistory`에 기록한다.
- §29 결과 화면의 "학습 단어 수"는 **고유 단어 수**로 집계한다. 재출제로 중복 카운트되면 안 된다.

## §51. 세션 중단과 복구

- 단어 하나를 처리할 때마다 **즉시 DB에 커밋**한다. 세션 종료 시 일괄 저장하지 않는다.
- **세션 상태(진행 위치, 남은 큐)는 저장하지 않는다.** 재진입 시 §49로 큐를 새로 계산한다. 이미 처리된 단어는 `nextReviewAt`이 미래로 밀려 자연히 제외된다.
- MVP에서 "이어서 학습하기"는 구현하지 않는다.

## §52. 학습 방향과 기록

- `LearningProgress`는 **방향과 무관하게 단어당 1개**만 존재한다.
- `ReviewHistory.direction`에만 방향을 기록한다.
- 혼합 모드는 **단어 단위**로 방향을 랜덤 결정한다. 세션 단위가 아니다.
- 뜻→단어 방향에서도 채점은 §22와 동일하게 자기 평가([몰랐어요]/[알았어요])다. 텍스트 입력 채점은 MVP 범위 밖이다.

## §53. 날짜·시간 기준

- 하루의 경계는 **로컬 타임존 기준 00:00**. 상수 `kDayBoundaryHour = 0`으로 분리한다.
- **연속 학습일(§34)**: 해당 로컬 날짜에 `ReviewHistory` 레코드가 1건 이상이면 학습일로 인정한다.
- 연속 학습일은 오늘 또는 어제부터 역순으로 끊기지 않은 날짜 수를 센다.
- **오늘의 진행률(§17)**: `분모 = 오늘 큐에 배정된 단어 수(§49 상한 적용 후)`, `분자 = 오늘 처리 완료한 고유 단어 수`. 분모 0이면 §55 빈 상태를 표시한다.
- 별도 `DailyStudyLog` 테이블은 만들지 않는다. `ReviewHistory`에서 집계한다.

## §54. 파일 임포트 상세 규칙

**헤더 행 판정**
- 첫 행의 값이 §11 열 이름 후보 사전과 하나라도 일치하면 헤더로 간주한다.
- 일치하지 않으면 데이터 행으로 간주하고 열 이름을 "1열/2열/3열"로 표시한다.
- 열 매핑 화면에 **[첫 행을 제목으로 사용] 토글**을 반드시 제공한다. 자동 판정을 사용자가 뒤집을 수 있어야 한다.

**XLSX**
- **첫 번째 시트만 읽는다.** 시트 선택 UI는 범위 밖이다.
- 시트가 여러 개면 미리보기에 안내: "첫 번째 시트(<시트명>)를 읽었습니다."
- 셀 값은 문자열로 변환한다. 숫자 셀의 `1.0` 표기는 `1`로 정리한다.

**구분자 감지 (TXT / CSV)**
- 후보: `|`, `\t`, `,`
- 첫 20줄을 검사해 **행마다 등장 횟수가 가장 일정한(분산이 최소인) 구분자**를 선택한다.
- 총 등장 횟수 최대값으로 고르면 안 된다. 뜻에 쉼표가 흔히 포함되기 때문이다.
- 동률이면 `|` → `\t` → `,` 순으로 우선한다.
- CSV는 따옴표 이스케이프(`"버리다, 포기하다"`)를 정상 처리한다.

**상한**
- 파일 크기 **10MB**, 단어 수 **5,000개**. 초과 시: "한 번에 최대 5,000개까지 가져올 수 있습니다."
- 파싱은 `compute()`로 별도 isolate에서 실행한다.
- DB 삽입은 **단일 트랜잭션 + batch insert**로 처리한다.

**필드 길이 제한**
- `term` 200자, `meaning` 500자, `example` 1000자 초과분은 잘라 저장한다.

## §55. 빈 상태(Empty State) UI

**1. 오늘 학습할 단어가 없음**
```
오늘 학습할 단어를 모두 마쳤어요 👏

다음 복습: <가장 이른 nextReviewAt 상대 표기>

[다른 단어장 학습하기]
[취약 단어 복습하기]
```

**2. 내 단어장이 없음**
```
아직 만든 단어장이 없어요

[내 파일로 단어장 만들기]
[추천 단어장 둘러보기]
```

**3. 취약 단어가 없음**
```
아직 취약 단어가 없어요

3번 이상 학습한 단어 중
정답률이 낮은 단어가 여기에 표시됩니다.
```

## §56. Android 알림 구현 요건

1. `timezone` 초기화(`tz.initializeTimeZones()` + `tz.setLocalLocation()`). 없으면 일일 반복 스케줄이 동작하지 않는다.
2. **Android 13(API 33)+ `POST_NOTIFICATIONS` 런타임 권한 요청.** 설정에서 알림 ON 시 요청하고, 거부되면 토글을 OFF로 되돌리고 안내한다.
3. `AndroidManifest.xml`에 `RECEIVE_BOOT_COMPLETED` 선언 + boot receiver 등록. 재부팅 후 스케줄 소실 방지.
4. **`inexactAllowWhileIdle`을 사용한다.** `SCHEDULE_EXACT_ALARM` 권한 요구를 피한다. 복습 알림은 몇 분 오차가 문제되지 않는다.
5. 알림 시간 변경 시 기존 스케줄을 취소하고 재등록한다.

**알림 본문**
스케줄 등록 시점에 복습 개수를 알 수 없다. 정확한 개수를 넣으려면 백그라운드 실행이 필요하므로 범위를 넘는다.
고정 문구를 사용한다: **"오늘 복습할 단어가 기다리고 있어요."**
§35의 "15개" 같은 동적 개수는 MVP에서 구현하지 않는다.

## §57. DB 제약·인덱스·마이그레이션

**제약**
- `Word.wordBookId` → `WordBook.id`, ON DELETE CASCADE
- `LearningProgress.wordId` → `Word.id`, ON DELETE CASCADE, `wordId` UNIQUE
- `ReviewHistory.wordId` → `Word.id`, ON DELETE CASCADE
- Drift에서 CASCADE가 실제 동작하려면 `PRAGMA foreign_keys = ON`을 명시적으로 켜야 한다.

**인덱스**
```
INDEX idx_word_wordbook       ON Word(wordBookId)
INDEX idx_progress_next       ON LearningProgress(nextReviewAt, status)
INDEX idx_history_reviewedAt  ON ReviewHistory(reviewedAt)
UNIQUE INDEX idx_wordbook_src ON WordBook(sourceType, sourceId)
```

**마이그레이션**
- `schemaVersion = 1`로 시작한다.
- `MigrationStrategy.onCreate`에서 테이블 생성 후 §32 기본 단어장 적재를 수행한다.
- 적재 멱등성은 `WordBook(sourceType='builtin', sourceId=<json id>)` 존재 여부로 보장한다.
- `index.json`의 `version` 값은 `AppMeta` 테이블에 `builtin_content_version` 키로 저장한다. SharedPreferences에 두지 않는다. §37 데이터 초기화 시 지워지면 안 되기 때문이다.

**§37 데이터 초기화 삭제 범위**
```
DELETE FROM ReviewHistory       -- 전체
DELETE FROM LearningProgress    -- 전체
-- WordBook, Word, AppMeta는 건드리지 않는다
```

## §58. 필수 단위 테스트

**`SpacedRepetitionService`**
- NEW + 정답 → step 0, LEARNING, now + 10분
- LEARNING(step 0) + 정답 → step 1, REVIEW, now + 1일
- REVIEW(step 3) + 오답 → step 0, LEARNING, streak 0
- step 4 + 정답 → step 5, MASTERED
- MASTERED + 오답 → step 0, LEARNING
- 사다리 전 구간 순차 진행 (10분→1일→3일→7일→14일→30일)

**`FileImportService`**
- **왕복 테스트: `sample_wordbook.csv` / `.txt` / `.xlsx`를 그대로 임포트 → 각 10단어 정상 파싱** (최우선)
- CP949로 저장된 CSV 정상 파싱 (한글 깨짐 없음)
- UTF-8 BOM 포함 CSV
- CRLF 개행
- 헤더 있는 파일 / 없는 파일
- 구분자 `|`, `,`, 탭 각각 감지
- `|`와 `,`가 동시에 있는 TXT에서 `|`를 선택하는지
- 뜻에 쉼표가 포함된 따옴표 CSV
- 빈 파일 → 오류 반환, 예외 미전파
- term 또는 meaning 공백 행 → 오류 행 분류
- 중복 term → 첫 행만 유지
- 5,000개 초과 → 상한 오류

**`BuiltinWordbookService`**
- `index.json` 4종 파싱 성공
- `reading` / `example` 키 부재 시 null 처리
- 2회 연속 초기화 시 중복 적재되지 않음 (멱등성)
- 적재 후 단어 수: 321 / 192 / 101 / 100

**`StudyQueueBuilder`**
- 복습 100개 상한, 신규 설정값 상한
- 우선순위 정렬 순서
- 대상 0개일 때 빈 큐 반환

**통계**
- 연속 학습일 (오늘 학습 전/후, 하루 건너뜀)
- 정답률 (분모 0 처리)

## §59. 패키지 확정

§40에 다음을 추가한다.

```yaml
go_router          # 라우팅
timezone           # flutter_local_notifications 필수 의존
flutter_timezone
permission_handler # 알림 권한
intl               # 날짜 포맷
```

- 상태관리는 **Riverpod 2.x의 `Notifier` / `AsyncNotifier`**를 사용한다. `StateNotifier`, `ChangeNotifier`는 사용하지 않는다.
- `build_runner`를 dev_dependencies에 포함한다(drift 코드 생성).
- 각 패키지는 pub.dev에서 현재 Flutter SDK와 호환되는 최신 안정 버전을 확인 후 고정한다. **버전을 추측해서 적지 않는다.**

## §60. Phase 완료 게이트

§45의 각 Phase는 아래를 모두 통과해야 다음으로 넘어간다.

1. `flutter analyze` 경고 0건
2. `flutter test` 전체 통과
3. **앱이 빌드되고 실행된다.** 중간 Phase에서도 실행 불가 상태로 남기지 않는다.
4. 해당 Phase의 §46 체크리스트 항목이 실기기 또는 에뮬레이터에서 확인된다.

각 Phase 종료 시 무엇이 동작하고 무엇이 미구현인지 한 줄씩 보고한다.

## §61. 출시 준비 (참고)

- **개인정보처리방침 URL이 필수다.** 데이터를 수집하지 않아도 Play Console이 요구한다.
- Data Safety: "데이터를 수집하지 않음" / "기기 외부로 전송되지 않음". 본 앱은 실제로 그러하다.
- 알림 권한 사용 목적을 기재한다.

## §62. 일본어 reading 표시 규칙

`Word.reading`이 null이 아닐 때만 적용한다.

**단어 → 뜻 방향**
- 문제 화면: `term`만 크게 표시한다. **reading은 숨긴다.** (읽기를 보여주면 문제가 절반 풀린다)
- [뜻 보기] 이후: `term` 아래에 reading을 작은 글씨로, 그 아래에 meaning을 표시한다.

```
野菜
やさい          ← 작게, 흐린 색

야채
```

**뜻 → 단어 방향**
- 문제 화면: `meaning`만 표시한다.
- 정답 공개 시: `term` + reading을 함께 표시한다.

**단어 상세 화면(§30)**
- 항상 `term` + reading을 함께 표시한다.

`reading`이 null인 영어 단어는 해당 영역을 렌더링하지 않는다. 빈 줄을 남기지 않는다.

---

# PART D. 구현 원칙 추가

기존 §47을 유지하고 다음을 추가한다.

1. **스키마를 먼저 확정하고 코드를 쓴다.** §A-1의 `stepIndex`/`intervalMinutes`, §A-2의 `reading` 컬럼은 Phase 1 이전에 반영한다. Phase 4에서 발견하면 마이그레이션 작업이 추가된다.
2. **`SpacedRepetitionService`와 `FileImportService`는 Flutter 의존성 없는 순수 Dart로 작성한다.** UI 없이 테스트 가능해야 한다.
3. **인코딩 폴백(§A-5)은 선택 기능이 아니다.** 한국 사용자 대상 앱에서 CP949 CSV를 못 읽으면 파일 업로드 기능 자체가 실패한 것이다.
4. **자산 파일의 필드명을 추측하지 않는다.** `items` / `asset` / `itemCount` / `version`은 §48에 명시된 그대로다. 코드를 쓰기 전 실제 JSON을 한 번 읽어 확인한다.
5. 판단이 애매하면 임의로 결정하지 말고 **가장 단순한 쪽을 선택한 뒤 그 선택을 보고**한다.
