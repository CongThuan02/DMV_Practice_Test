# Graph Report - DMV_Practice_Test  (2026-11-27)

## Corpus Check
- 41 files · ~7,069 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 352 nodes · 466 edges · 28 communities (21 shown, 7 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `fb41f961`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- Riverpod Providers & Routing
- Route & Theme Constants
- API Error Handling
- API Result Types
- Dio Interceptors
- Root App Widget
- Home Screen
- App Entry Point
- Router Provider Ref
- CLAUDE.md
- question_view.dart
- quiz_repository.dart
- quiz_state.dart
- question.dart
- quiz_view_model.dart
- quiz_page.dart
- package:easy_localization/easy_localization.dart
- history_page.dart
- category_tile.dart
- ConsumerWidget
- ../../../../core/localization/locale_keys.g.dart
- full_test_card.dart
- package:flutter/material.dart
- categoriesProvider
- historyRepositoryProvider
- historyViewModelProvider
- settingsRepositoryProvider
- themeModeViewModelProvider

## God Nodes (most connected - your core abstractions)
1. `QuizState` - 6 edges
2. `HistoryViewModel` - 4 edges
3. `build` - 4 edges
4. `QuizViewModel` - 4 edges
5. `ThemeModeViewModel` - 4 edges
6. `LocalizedText` - 3 edges
7. `ApiException` - 3 edges
8. `ApiResult` - 3 edges
9. `ApiSuccess` - 3 edges
10. `ApiFailure` - 3 edges

## Surprising Connections (you probably didn't know these)
- `_FakeSource` --implements--> `QuestionBankLocalSource`  [EXTRACTED]
  test/features/quiz/quiz_view_model_test.dart → lib/features/quiz/data/services/question_bank_local_source.dart
- `QuizPage` --references--> `provider`  [EXTRACTED]
  lib/features/quiz/presentation/views/quiz_page.dart → test/features/quiz/quiz_view_model_test.dart
- `build` --references--> `provider`  [EXTRACTED]
  lib/features/quiz/presentation/views/quiz_page.dart → test/features/quiz/quiz_view_model_test.dart

## Import Cycles
- None detected.

## Communities (28 total, 7 thin omitted)

### Community 0 - "Riverpod Providers & Routing"
Cohesion: 0.20
Nodes (9): app_routes.dart, ../../features/history/presentation/views/history_page.dart, ../../features/home/presentation/views/home_page.dart, ../../features/quiz/presentation/views/quiz_page.dart, ../../features/settings/presentation/views/settings_page.dart, appRouter, appRouterProvider, package:go_router/go_router.dart (+1 more)

### Community 1 - "Route & Theme Constants"
Cohesion: 0.11
Nodes (15): AppRoutes, history, home, quiz, settings, AppTheme, dark, light (+7 more)

### Community 2 - "API Error Handling"
Cohesion: 0.10
Nodes (21): api_exception.dart, Exception, int?, Interceptor, ApiException, fromDio, message, statusCode (+13 more)

### Community 3 - "API Result Types"
Cohesion: 0.06
Nodes (33): AssetBundle, dart:convert, dart:io, assetPath, _bundle, load, QuestionBankLocalSource, ../models/question_bank_dto.dart (+25 more)

### Community 4 - "Dio Interceptors"
Cohesion: 0.07
Nodes (28): @JsonSerializable, DateTime, categoryId, correctCount, fromDomain, fromJson, QuizAttemptDto, takenAt (+20 more)

### Community 5 - "Root App Widget"
Cohesion: 0.33
Nodes (5): ../core/router/app_router.dart, ../core/theme/app_theme.dart, ../features/settings/presentation/view_models/theme_mode_view_model.dart, build, package:flutter_riverpod/flutter_riverpod.dart

### Community 6 - "Home Screen"
Cohesion: 0.20
Nodes (9): ../../../../core/router/app_routes.dart, ../../../../core/widgets/error_retry_view.dart, build, ../../../quiz/data/repositories/quiz_repository.dart, AppRoutes.history, AppRoutes.quiz, AppRoutes.settings, ../widgets/category_tile.dart (+1 more)

### Community 7 - "App Entry Point"
Cohesion: 0.09
Nodes (23): app/app.dart, core/storage/shared_preferences_provider.dart, ../../data/repositories/history_repository.dart, ../../domain/quiz_attempt.dart, addAttempt, clear, getAttempts, maxEntries (+15 more)

### Community 10 - "question_view.dart"
Cohesion: 0.08
Nodes (26): answer_colors.dart, ../../domain/quiz_rules.dart, _AttemptTile, _QuizInProgress, build, label, onSelect, onTap (+18 more)

### Community 11 - "quiz_repository.dart"
Cohesion: 0.09
Nodes (24): @Riverpod, dart:math, dioClientProvider, ../../domain/category.dart, ../../domain/question.dart, dioClient, sharedPreferences, historyRepositoryProvider (+16 more)

### Community 12 - "quiz_state.dart"
Cohesion: 0.09
Nodes (21): bool get, int? get, categoryId, correctCount, passed, QuizAttempt, scorePercent, takenAt (+13 more)

### Community 13 - "question.dart"
Cohesion: 0.09
Nodes (20): ../../../core/localization/localized_text.dart, dart:ui, LocalizedText, resolve, _values, Category, description, icon (+12 more)

### Community 14 - "quiz_view_model.dart"
Cohesion: 0.10
Nodes (19): _, ../../data/repositories/quiz_repository.dart, ../../data/repositories/settings_repository.dart, ../../../history/data/repositories/history_repository.dart, ../../../history/domain/quiz_attempt.dart, ../../../history/presentation/view_models/history_view_model.dart, historyViewModelProvider, HistoryViewModel (+11 more)

### Community 15 - "quiz_page.dart"
Cohesion: 0.16
Nodes (13): @freezed, QuizState, build, categoryId, _confirmExit, onNext, onSelect, QuizPage (+5 more)

### Community 16 - "package:easy_localization/easy_localization.dart"
Cohesion: 0.18
Nodes (10): confirmed, false, showConfirmDialog, build, ErrorRetryView, onRetry, ../localization/locale_keys.g.dart, package:easy_localization/easy_localization.dart (+2 more)

### Community 17 - "history_page.dart"
Cohesion: 0.25
Nodes (7): ../../../../core/widgets/confirm_dialog.dart, attempt, build, _confirmClear, title, ../../../quiz/presentation/widgets/answer_colors.dart, ../view_models/history_view_model.dart

### Community 18 - "category_tile.dart"
Cohesion: 0.29
Nodes (6): build, category, categoryIcon, CategoryTile, onTap, ../../../quiz/domain/category.dart

### Community 19 - "ConsumerWidget"
Cohesion: 0.40
Nodes (5): ConsumerWidget, MyApp, HistoryPage, HomePage, SettingsPage

### Community 20 - "../../../../core/localization/locale_keys.g.dart"
Cohesion: 0.40
Nodes (4): ../../../../core/localization/locale_keys.g.dart, build, ThemeMode, ../view_models/theme_mode_view_model.dart

### Community 21 - "full_test_card.dart"
Cohesion: 0.40
Nodes (4): build, FullTestCard, onTap, ../../../quiz/domain/quiz_rules.dart

### Community 22 - "package:flutter/material.dart"
Cohesion: 0.40
Nodes (4): AnswerColors, correct, incorrect, package:flutter/material.dart

## Knowledge Gaps
- **163 isolated node(s):** `build`, `_values`, `resolve`, `message`, `statusCode` (+158 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **7 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Question` connect `question.dart` to `question_view.dart`?**
  _High betweenness centrality (0.036) - this node is a cross-community bridge._
- **Why does `QuizState` connect `quiz_page.dart` to `question_view.dart`, `quiz_state.dart`?**
  _High betweenness centrality (0.026) - this node is a cross-community bridge._
- **Why does `Category` connect `question.dart` to `category_tile.dart`?**
  _High betweenness centrality (0.024) - this node is a cross-community bridge._
- **What connects `build`, `_values`, `resolve` to the rest of the system?**
  _163 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Route & Theme Constants` be split into smaller, more focused modules?**
  _Cohesion score 0.1111111111111111 - nodes in this community are weakly interconnected._
- **Should `API Error Handling` be split into smaller, more focused modules?**
  _Cohesion score 0.10144927536231885 - nodes in this community are weakly interconnected._
- **Should `API Result Types` be split into smaller, more focused modules?**
  _Cohesion score 0.06006006006006006 - nodes in this community are weakly interconnected._