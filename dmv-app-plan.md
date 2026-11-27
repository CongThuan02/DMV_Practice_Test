# Kế hoạch code: ứng dụng ôn thi lý thuyết lái xe Mỹ (DMV Practice Test)

> Giao diện mẫu: `dmv-app-mockup.html` (16 màn hình). Dữ liệu mẫu: `ca-sample-questions.json`.

## 1. Mục tiêu và ràng buộc

- **Mục tiêu:** app Android bằng Flutter cho người dùng Mỹ ôn thi lý thuyết lấy bằng lái (theo từng bang), kiếm tiền bằng AdMob và gói PRO gỡ quảng cáo.
- **Chi phí:** 0 đồng cho code, dữ liệu, hosting và công cụ. Khoản duy nhất không tránh được là phí tài khoản Google Play (khoảng 25 USD một lần). Chỉ làm Android thì không cần tài khoản Apple.
- **Không dùng backend.** Toàn bộ câu hỏi nằm trong app (file JSON), tiến độ lưu trên máy.
- **Phạm vi bản đầu (MVP):** 2 bang, mỗi bang 150-300 câu, tiếng Anh.

## 2. Giấy phép nội dung (làm trước khi viết câu hỏi)

- Sổ tay lái xe California dùng giấy phép **CC BY-NC 4.0**: không được dùng thương mại nếu chưa có văn bản cho phép. App có quảng cáo là thương mại.
- Vì vậy **không sao chép hay chuyển thể câu chữ từ sổ tay hoặc bài thi mẫu của DMV** khi chưa được phép.
- Hướng làm an toàn hơn:
  1. Gửi email xin phép DMV của bang (miễn phí, có thể bị từ chối).
  2. Soạn câu hỏi bằng lời của mình từ **luật giao thông của bang** (văn bản pháp luật công khai), ghi điều luật làm nguồn trong trường `source`.
  3. Với mỗi bang, đọc trang bản quyền của sổ tay trước khi làm. Ghi kết quả vào bảng dưới.
- Đây là ghi chú để bạn cân nhắc, không phải tư vấn pháp lý.

| Bang | Giấy phép sổ tay | Đã xin phép? | Nguồn luật dùng | Trạng thái |
|---|---|---|---|---|
| CA | CC BY-NC 4.0, cấm thương mại khi chưa có văn bản cho phép ([trang bản quyền](https://www.dmv.ca.gov/portal/handbook/california-driver-handbook/copyright/)) | chưa | Vehicle Code (leginfo), MUTCD 11th ed.; 3 câu đỗ xe dốc dựa trên hướng dẫn sổ tay (diễn đạt lại) | 298 câu nháp `verify: true`, chờ kiểm tra |
| TX | Không có giấy phép mở; DPS ghi © 2026, coi như giữ mọi quyền | chưa | Transportation Code, Penal Code ch. 49, Alcoholic Beverage Code, MUTCD 11th ed. | 295 câu nháp `verify: true`, chờ kiểm tra |

## 3. Kiến trúc

```
Asset JSON ──► QuestionRepository ──► QuizController ──► UI
                                          │
                                          ▼
                                   ProgressStore (shared_preferences)
                                          │
                       AdService ◄────────┤────────► PurchaseService
                       ConsentService (UMP)
```

- **Quản lý trạng thái:** `provider` (đơn giản, đủ dùng). Có thể đổi sang `riverpod` sau.
- **Điều hướng:** `go_router`.
- **Lưu trữ:** `shared_preferences` cho bản đầu. Nếu cần truy vấn nhiều thì chuyển sang `sqflite` hoặc `drift`.
- **Hình ảnh biển báo, vạch kẻ:** SVG tự vẽ, hiển thị bằng `flutter_svg`.

### Gói cần dùng (`pubspec.yaml`)

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
  go_router: ^14.0.0
  shared_preferences: ^2.2.0
  flutter_svg: ^2.0.0
  google_mobile_ads: ^5.0.0   # AdMob + UMP (đồng ý quảng cáo)
  in_app_purchase: ^3.2.0     # gói PRO
flutter:
  assets:
    - assets/questions/
    - assets/images/
```

(Số phiên bản chỉ là gợi ý. Chạy `flutter pub add <tên gói>` để lấy bản mới nhất.)

### Cấu trúc thư mục

```
lib/
  main.dart
  app_router.dart
  data/
    question.dart              # model
    question_repository.dart   # đọc JSON theo bang
    progress_store.dart        # tiến độ, câu sai, bang đã chọn
    state_catalog.dart         # danh sách bang + cấu hình thi
  features/
    onboarding/   consent_screen.dart, state_picker_screen.dart
    home/         home_screen.dart
    topics/       topics_screen.dart
    quiz/         quiz_screen.dart, quiz_controller.dart, widgets/
    signs/        sign_cards_screen.dart
    mock_exam/    mock_intro_screen.dart
    result/       result_screen.dart
    mistakes/     mistakes_screen.dart
    pro/          pro_screen.dart
  services/
    ad_service.dart
    consent_service.dart
    purchase_service.dart
assets/
  questions/  ca.json, tx.json
  images/     signs/*.svg, markings/*.svg
```

## 4. Mô hình dữ liệu

### JSON câu hỏi (mỗi bang một file)

```json
{
  "state": "CA",
  "stateName": "California",
  "version": 1,
  "exam": { "questions": 36, "passMark": 30 },
  "topics": ["signs", "right_of_way", "speed", "parking", "alcohol", "safe_driving", "licenses"],
  "questions": [
    {
      "id": "ca-0001",
      "type": "text",
      "topic": "safe_driving",
      "difficulty": 1,
      "q": "…",
      "image": null,
      "options": ["…", "…", "…"],
      "answer": 1,
      "explain": "…",
      "source": "Điều luật hoặc tài liệu đã cấp phép",
      "verify": false
    }
  ]
}
```

- `type`: `text`, `number_fill`, `scenario`, `sign`, `marking`, `image_options`.
- `options`: 2 đến 4 lựa chọn (bài mẫu dùng 3).
- `image`: đường dẫn SVG, chỉ cần với `scenario`, `sign`, `marking`. Với `image_options`, mỗi lựa chọn có thể là `{ "label": "Red", "color": "#c62828" }` hoặc `{ "label": "...", "image": "..." }`.
- `exam.questions` và `exam.passMark`: **chỉ nhập sau khi kiểm chứng với DMV của bang.**
- `verify: true` nghĩa là chưa kiểm tra. Bản phát hành chỉ chứa câu `verify: false`.

### Model Dart (rút gọn)

```dart
enum QuestionType { text, numberFill, scenario, sign, marking, imageOptions }

class Question {
  final String id, topic, q, explain;
  final QuestionType type;
  final List<String> options;
  final int answer;
  final String? image;
  const Question({required this.id, required this.topic, required this.q,
    required this.explain, required this.type, required this.options,
    required this.answer, this.image});

  factory Question.fromJson(Map<String, dynamic> j) => Question(
    id: j['id'], topic: j['topic'], q: j['q'], explain: j['explain'] ?? '',
    type: _type(j['type']),
    options: List<String>.from(j['options']),
    answer: j['answer'], image: j['image'],
  );

  static QuestionType _type(String s) => switch (s) {
    'number_fill' => QuestionType.numberFill,
    'scenario' => QuestionType.scenario,
    'sign' => QuestionType.sign,
    'marking' => QuestionType.marking,
    'image_options' => QuestionType.imageOptions,
    _ => QuestionType.text,
  };
}
```

> Với `image_options`, mở rộng `options` thành danh sách object khi code thật.

### Dữ liệu lưu trên máy (`shared_preferences`)

| Khóa | Nội dung |
|---|---|
| `selectedState` | mã bang, ví dụ `CA` |
| `seen:{state}` | danh sách id câu đã làm |
| `wrong:{state}` | map id → số lần sai (trả lời đúng 2 lần liên tiếp thì bỏ khỏi danh sách) |
| `history:{state}` | điểm các bài thi thử gần nhất |
| `proUnlocked` | true nếu đã mua PRO (đồng bộ lại từ Google Play khi mở app) |
| `lastInterstitialAt` | thời điểm hiện quảng cáo xen kẽ gần nhất |

## 5. Danh sách màn hình (khớp giao diện mẫu)

| # | Màn hình | Ghi chú code |
|---|---|---|
| 1 | Chọn bang | tìm kiếm, nhóm "Popular" |
| 2 | Trang chủ bang | tiến độ, 4 lối vào, banner |
| 3 | Làm bài | `QuizScreen` chọn widget theo `type` |
| 4 | Kết quả | điểm, đạt/chưa đạt, gợi ý PRO |
| 5 | Khởi động + đồng ý quảng cáo (UMP) | chỉ hiện khi cần |
| 6 | Luyện theo chủ đề | đọc `topics` |
| 7 | Thẻ biển báo | lật thẻ, "Got it"/"Still learning" |
| 8 | Giới thiệu bài thi thử | số câu, điểm đạt đọc từ cấu hình bang |
| 9 | Ôn câu sai | đọc `wrong:{state}` |
| 10 | Gói PRO | mua, khôi phục mua, xem quảng cáo để mở giải thích |
| 11-16 | 6 dạng câu hỏi | `text`, `number_fill`, `scenario`, `sign`, `marking`, `image_options` |

### Chọn widget theo dạng câu hỏi

```dart
Widget buildQuestion(Question q, ValueChanged<int> onPick) {
  switch (q.type) {
    case QuestionType.numberFill:  return NumberFillQuestion(q, onPick);
    case QuestionType.imageOptions:return ImageOptionsQuestion(q, onPick);
    case QuestionType.scenario:
    case QuestionType.sign:
    case QuestionType.marking:     return ImageQuestion(q, onPick); // ảnh + 3 lựa chọn
    case QuestionType.text:        return TextQuestion(q, onPick);
  }
}
```

## 6. Logic chính

### QuizController

- Khởi tạo bằng danh sách câu (theo chủ đề, bài thi thử hoặc câu sai).
- Bài thi thử: lấy ngẫu nhiên đúng `exam.questions` câu, trộn thứ tự lựa chọn mỗi lần.
- `answer(index)`: ghi đúng/sai, cập nhật `ProgressStore`.
- Chế độ luyện: hiện giải thích ngay. Chế độ thi thử: chỉ hiện ở cuối bài.
- Đạt khi số câu đúng >= `exam.passMark`.

### Quảng cáo (`AdService`)

- **Banner:** màn Trang chủ, Chủ đề, Làm bài. Ẩn khi `proUnlocked`.
- **Interstitial:** chỉ hiện khi thoát màn Kết quả, tối đa 1 lần mỗi vài bài và có thời gian chờ giữa các lần. **Không bao giờ hiện giữa lúc làm bài.**
- **Rewarded:** xem quảng cáo để mở giải thích hoặc một bài thi thử.
- **Giai đoạn phát triển, dùng ID thử của Google:**

```
App ID (Android):  ca-app-pub-3940256099942544~3347511713
Banner:            ca-app-pub-3940256099942544/6300978111
Interstitial:      ca-app-pub-3940256099942544/1033173712
Rewarded:          ca-app-pub-3940256099942544/5224354917
```

  Chỉ đổi sang ID thật khi phát hành. Không bấm vào quảng cáo thật của chính mình.

### Đồng ý quảng cáo (`ConsentService`)

- Dùng UMP có sẵn trong `google_mobile_ads`.
- Luồng: mở app → xin trạng thái đồng ý → hiện biểu mẫu nếu cần → **sau đó** mới khởi tạo quảng cáo.
- Bắt buộc với người dùng EU/UK, nên cài ngay từ đầu.

### Gói PRO (`PurchaseService`)

- Sản phẩm không tiêu thụ (non-consumable), ví dụ mã `remove_ads`.
- Khi mở app: lắng nghe luồng mua hàng và gọi khôi phục mua để cập nhật `proUnlocked`.
- Bắt buộc có nút **Restore purchase**.
- Giá do bạn đặt trong Play Console. Đừng ghi giá cứng trong code.

## 7. Quy trình tạo nội dung (cho mỗi bang)

1. Kiểm tra giấy phép sổ tay của bang, ghi vào bảng ở mục 2.
2. Liệt kê chủ đề theo mục lục sổ tay.
3. Đọc điều luật tương ứng của bang.
4. Nhờ AI soạn nháp câu hỏi dựa trên điều luật bạn cung cấp, yêu cầu: 3 lựa chọn, 1 đáp án đúng, giải thích ngắn, ghi điều luật làm nguồn.
5. **Tự kiểm tra từng câu với luật gốc** (AI có thể sai số liệu như khoảng cách, tốc độ, mức phạt). Nên kiểm tra lại vào hôm sau.
6. Gắn `verify: false` chỉ sau khi kiểm tra xong.
7. Chạy script kiểm tra JSON (id duy nhất, `answer` nằm trong `options`, mọi câu có `source`).
8. Đóng gói vào `assets/questions/`.

**Số lượng:** 150-300 câu mỗi bang cho bản đầu, phân bổ đều theo chủ đề. Thêm 20-40 câu biển báo và vạch kẻ nếu bang có dạng câu hỏi này.

## 8. Lộ trình

### Giai đoạn 0: chuẩn bị
- [ ] Cài Flutter, Android Studio, tạo project
- [ ] Chọn 2 bang đầu và kiểm tra giấy phép
- [ ] Tạo tài khoản Google Play và AdMob

### Giai đoạn 1: nội dung (chạy song song giai đoạn 2)
- [ ] Soạn và kiểm chứng câu hỏi bang 1
- [ ] Vẽ SVG biển báo và vạch kẻ cần dùng
- [ ] Soạn câu hỏi bang 2

### Giai đoạn 2: MVP chưa có quảng cáo
- [ ] Model, repository, đọc JSON
- [ ] Chọn bang, Trang chủ, Chủ đề
- [ ] Màn làm bài với đủ 6 dạng câu hỏi
- [ ] Kết quả, ôn câu sai, bài thi thử
- [ ] Lưu tiến độ

### Giai đoạn 3: kiếm tiền
- [ ] UMP, banner, interstitial, rewarded (ID thử)
- [ ] Gói PRO và khôi phục mua
- [ ] Màn PRO

### Giai đoạn 4: phát hành
- [ ] Chính sách bảo mật (đăng trên GitHub Pages)
- [ ] Biểu mẫu Data safety và xếp hạng nội dung trên Play Console
- [ ] Dòng "không liên kết với cơ quan chính phủ" trong app và mô tả
- [ ] Đặt tên, mô tả có từ khóa bang và năm; ảnh chụp màn hình
- [ ] Kiểm thử kín (đủ số người và số ngày theo yêu cầu hiện tại của Play Console)
- [ ] Đổi sang ID quảng cáo thật, phát hành

### Giai đoạn 5: đo đạc (4-6 tuần)
- [ ] Theo dõi lượt cài, người dùng quay lại, tỷ lệ hoàn thành bài thi thử
- [ ] Đọc đánh giá để sửa câu sai
- [ ] Quyết định mở thêm bang nào

## 9. Kiểm thử

- Unit test: `Question.fromJson`, chấm điểm, trộn đáp án, quy tắc xóa câu sai.
- Script kiểm tra JSON chạy mỗi lần thêm câu hỏi.
- Thử trên máy thật hoặc emulator: màn hình nhỏ, chữ lớn, chế độ tối.
- Kiểm tra quảng cáo bằng ID thử và khi mất mạng (app phải dùng được offline).

## 10. Rủi ro

| Rủi ro | Cách giảm |
|---|---|
| Vi phạm giấy phép nội dung | Mục 2: xin phép hoặc soạn từ luật gốc, ghi nguồn |
| Câu hỏi sai làm người dùng học nhầm | Kiểm chứng từng câu, thêm dòng "chỉ mang tính tham khảo, hãy đối chiếu với tài liệu chính thức của bang" |
| Google Play coi là giả danh cơ quan nhà nước | Không dùng logo DMV, ghi rõ không liên kết, đặt tên không gây hiểu nhầm |
| Tài khoản AdMob bị hạn chế | Dùng ID thử khi phát triển, không tự bấm quảng cáo, không đặt quảng cáo gần nút bấm |
| Người dùng chỉ dùng vài tuần rồi nghỉ | Cần liên tục có lượt cài mới (ASO); thêm bang mới; gói PRO mua một lần |
| Đối thủ rất đông | Tập trung vài bang, chất lượng câu hỏi và ASO |

## 11. Việc làm ngay

1. Chọn 2 bang và điền bảng giấy phép (mục 2).
2. Tạo project Flutter với cấu trúc thư mục mục 3.
3. Dựng `Question`, `QuestionRepository` và màn Làm bài với `ca-sample-questions.json` để chạy thử luồng.
