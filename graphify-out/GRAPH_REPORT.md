# Graph Report - DMV_Practice_Test  (2026-11-27)

## Corpus Check
- 52 files · ~10,466 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 686 nodes · 944 edges · 61 communities (41 shown, 20 thin omitted)
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
- state_bank.dart
- purchase_service.dart
- sign_cards_page.dart
- helpers.dart
- menu_card.dart
- option_tile.dart
- pro_page.dart
- StatelessWidget
- question_test.dart
- consent_service.dart
- asset_svg.dart
- startup_view_model.dart
- @JsonSerializable
- pro_view_model.dart
- package:shared_preferences/shared_preferences.dart
- FunctionProvider
- adServiceProvider
- adsReadyProvider
- availableStatesProvider
- consentServiceProvider
- privacyOptionsRequiredProvider
- progressProvider
- progressStoreProvider
- proStatusProvider
- proViewModelProvider
- purchaseServiceProvider
- questionRepositoryProvider
- randomProvider
- selectedStateProvider
- showAdsProvider
- signDeckViewModelProvider
- stateBankProvider
- themeModeSettingProvider

## God Nodes (most connected - your core abstractions)
1. `build` - 9 edges
2. `QuizState` - 7 edges
3. `QuizViewModel` - 6 edges
4. `AppPalette` - 5 edges
5. `StateBank` - 4 edges
6. `SelectedState` - 4 edges
7. `Progress` - 4 edges
8. `ProStatus` - 4 edges
9. `ThemeModeSetting` - 4 edges
10. `stateBank` - 4 edges

## Surprising Connections (you probably didn't know these)
- `_MistakesView` --inherits--> `ConsumerWidget`  [EXTRACTED]
  lib/features/mistakes/presentation/views/mistakes_page.dart → None  _Bridges community 19 → community 6_
- `QuizPage` --inherits--> `ConsumerWidget`  [EXTRACTED]
  lib/features/quiz/presentation/views/quiz_page.dart → None  _Bridges community 19 → community 15_
- `SettingsPage` --inherits--> `ConsumerWidget`  [EXTRACTED]
  lib/features/settings/presentation/views/settings_page.dart → None  _Bridges community 19 → community 20_
- `sharedPreferences` --configures--> `@Riverpod`  [EXTRACTED]
  lib/core/storage/shared_preferences_provider.dart → None  _Bridges community 17 → community 11_
- `ProgressStore` --configures--> `@Riverpod`  [EXTRACTED]
  lib/data/progress_store.dart → None  _Bridges community 17 → community 24_

## Import Cycles
- None detected.

## Communities (61 total, 20 thin omitted)

### Community 0 - "Riverpod Providers & Routing"
Cohesion: 0.08
Nodes (24): app_routes.dart, ../../features/home/presentation/views/home_page.dart, ../../features/mistakes/presentation/views/mistakes_page.dart, ../../features/mock_exam/presentation/views/mock_intro_page.dart, ../../features/pro/presentation/views/pro_page.dart, ../../features/quiz/presentation/view_models/quiz_state.dart, ../../features/quiz/presentation/views/quiz_page.dart, ../../features/settings/presentation/views/settings_page.dart (+16 more)

### Community 1 - "Route & Theme Constants"
Cohesion: 0.11
Nodes (18): @immutable, Color?, adBackground, adForeground, AppPalette, AppTheme, bad, badBackground (+10 more)

### Community 2 - "API Error Handling"
Cohesion: 0.13
Nodes (15): BannerAd?, int?, _ad, build, createState, didChangeDependencies, dispose, _load (+7 more)

### Community 3 - "API Result Types"
Cohesion: 0.18
Nodes (10): package:dmv_practice_test/features/quiz/presentation/view_models/quiz_state.dart, package:dmv_practice_test/features/quiz/presentation/view_models/quiz_view_model.dart, ProviderContainer, bank, container, main, now, start (+2 more)

### Community 4 - "Dio Interceptors"
Cohesion: 0.10
Nodes (20): DateTime, copyWith, correct, correctStreak, durationSeconds, exams, fromJson, missed (+12 more)

### Community 5 - "Root App Widget"
Cohesion: 0.14
Nodes (13): ../core/router/app_router.dart, ../../../../core/theme/app_theme.dart, ../../../../data/models/question.dart, build, Question, createState, _loadingAd, onUnlocked (+5 more)

### Community 6 - "Home Screen"
Cohesion: 0.19
Nodes (15): ../../../../core/router/app_routes.dart, ../../../../core/widgets/ad_banner.dart, ../../../../core/widgets/error_retry_view.dart, ../../../../data/models/state_bank.dart, ../data/session_providers.dart, ../../../../data/topic_catalog.dart, StateBank, bank (+7 more)

### Community 7 - "App Entry Point"
Cohesion: 0.17
Nodes (11): app/app.dart, core/storage/shared_preferences_provider.dart, confirmed, false, showConfirmDialog, ensureInitialized, main, prefs (+3 more)

### Community 10 - "question_view.dart"
Cohesion: 0.20
Nodes (9): exam_timer.dart, explanation_panel.dart, label, _leave, onRetry, _Stat, state, value (+1 more)

### Community 11 - "quiz_repository.dart"
Cohesion: 0.50
Nodes (3): sharedPreferences, package:riverpod_annotation/riverpod_annotation.dart, sharedPreferencesProvider

### Community 12 - "quiz_state.dart"
Cohesion: 0.06
Nodes (33): bool get, Exception, int get, correctCount, current, currentAnswer, elapsedAt, EmptyQuizException (+25 more)

### Community 13 - "question.dart"
Cohesion: 0.09
Nodes (21): AnswerOption get, dart:ui, answer, AnswerOption, color, correctOption, difficulty, explain (+13 more)

### Community 14 - "quiz_view_model.dart"
Cohesion: 0.12
Nodes (15): ../../../../data/models/progress.dart, answer, build, _finish, next, _now, pause, _progress (+7 more)

### Community 15 - "quiz_page.dart"
Cohesion: 0.12
Nodes (17): ../../../../core/widgets/confirm_dialog.dart, build, _confirmExit, mode, _modeLabel, notifier, onResume, QuizPage (+9 more)

### Community 16 - "package:easy_localization/easy_localization.dart"
Cohesion: 0.18
Nodes (9): build, DisclaimerText, textAlign, build, ErrorRetryView, onRetry, ../localization/locale_keys.g.dart, TextAlign (+1 more)

### Community 17 - "history_page.dart"
Cohesion: 0.05
Nodes (49): _, @Riverpod, appRouter, appRouterProvider, addExam, availableStates, build, code (+41 more)

### Community 18 - "category_tile.dart"
Cohesion: 0.07
Nodes (33): @freezed, clockProvider, ConsumerState, ConsumerStatefulWidget, ../../../../data/state_catalog.dart, ProPage, _ProPageState, QuizState (+25 more)

### Community 19 - "ConsumerWidget"
Cohesion: 0.20
Nodes (10): ConsumerWidget, MyApp, AdBanner, _HomeBody, HomePage, MistakesPage, _MockIntroBody, MockIntroPage (+2 more)

### Community 20 - "../../../../core/localization/locale_keys.g.dart"
Cohesion: 0.19
Nodes (11): ../../../../core/localization/locale_keys.g.dart, ../../../../core/widgets/disclaimer_text.dart, SettingsPage, build, createState, initState, StartupPage, _StartupPageState (+3 more)

### Community 21 - "full_test_card.dart"
Cohesion: 0.06
Nodes (31): AssetBundle, dart:convert, dart:io, Directory, File, assetDir, assetPath, availableStates (+23 more)

### Community 22 - "package:flutter/material.dart"
Cohesion: 0.07
Nodes (28): answer, color, difficulty, exam, explain, fromJson, id, image (+20 more)

### Community 23 - "categoriesProvider"
Cohesion: 0.09
Nodes (20): blank, imageTypes, QuestionValidator, types, validate, all, byCode, code (+12 more)

### Community 24 - "historyRepositoryProvider"
Cohesion: 0.10
Nodes (20): progressStoreProvider, _historyKey, _lastInterstitialKey, loadProgress, maxExamRecords, _prefs, ProgressStore, proUnlocked (+12 more)

### Community 25 - "historyViewModelProvider"
Cohesion: 0.11
Nodes (18): ad_config.dart, ../data/progress_store.dart, InterstitialAd?, build, _enabled, initialize, _interstitial, _loadInterstitial (+10 more)

### Community 26 - "settingsRepositoryProvider"
Cohesion: 0.11
Nodes (18): blank, build, filled, isSign, _letters, onPick, _optionLeading, path (+10 more)

### Community 27 - "themeModeViewModelProvider"
Cohesion: 0.12
Nodes (17): build, build, build, build, build, build, _select, build (+9 more)

### Community 28 - "state_bank.dart"
Cohesion: 0.12
Nodes (15): double get, byTopic, byType, code, exam, ExamConfig, name, passMark (+7 more)

### Community 29 - "purchase_service.dart"
Cohesion: 0.13
Nodes (14): InAppPurchase, buy, _events, _handle, _iap, loadProduct, productId, PurchaseEvent (+6 more)

### Community 30 - "sign_cards_page.dart"
Cohesion: 0.17
Nodes (11): ../../../../core/widgets/asset_svg.dart, SignDeckState, build, _CardBack, _CardFront, _DoneView, onRestart, path (+3 more)

### Community 31 - "helpers.dart"
Cohesion: 0.18
Nodes (10): List, package:dmv_practice_test/core/storage/shared_preferences_provider.dart, package:dmv_practice_test/data/session_providers.dart, package:flutter_riverpod/misc.dart, bankFrom, bankJson, makeContainer, overrides (+2 more)

### Community 32 - "menu_card.dart"
Cohesion: 0.20
Nodes (9): build, leading, MenuCard, onTap, subtitle, title, trailing, String? (+1 more)

### Community 33 - "option_tile.dart"
Cohesion: 0.20
Nodes (9): build, centered, label, leading, letter, onTap, OptionStatus, OptionTile (+1 more)

### Community 34 - "pro_page.dart"
Cohesion: 0.22
Nodes (8): ../../../../core/widgets/menu_card.dart, build, createState, dispose, _events, initState, StreamSubscription, ../view_models/pro_view_model.dart

### Community 35 - "StatelessWidget"
Cohesion: 0.22
Nodes (9): AssetSvg, _PausedView, _QuizRunning, ExplanationText, _FillInText, QuestionCard, _QuestionImage, _SectionLabel (+1 more)

### Community 36 - "question_test.dart"
Cohesion: 0.25
Nodes (7): dart:math, ../../helpers.dart, package:dmv_practice_test/data/models/question.dart, package:dmv_practice_test/data/models/state_bank.dart, package:dmv_practice_test/data/models/state_bank_dto.dart, package:flutter/painting.dart, main

### Community 37 - "consent_service.dart"
Cohesion: 0.29
Nodes (6): dart:async, canRequestAds, gatherConsent, isPrivacyOptionsRequired, showPrivacyOptions, package:google_mobile_ads/google_mobile_ads.dart

### Community 38 - "asset_svg.dart"
Cohesion: 0.29
Nodes (6): double?, build, height, path, width, package:flutter_svg/flutter_svg.dart

### Community 39 - "startup_view_model.dart"
Cohesion: 0.29
Nodes (6): build, consentTimeout, _startPurchases, package:flutter/foundation.dart, ../../../../services/ad_service.dart, ../../../../services/consent_service.dart

### Community 40 - "@JsonSerializable"
Cohesion: 0.33
Nodes (6): @JsonSerializable, ExamRecord, MistakeEntry, ExamDto, QuestionDto, StateBankDto

### Community 41 - "pro_view_model.dart"
Cohesion: 0.33
Nodes (5): build, buy, restore, package:in_app_purchase/in_app_purchase.dart, ../../../../services/purchase_service.dart

### Community 42 - "package:shared_preferences/shared_preferences.dart"
Cohesion: 0.33
Nodes (5): package:dmv_practice_test/data/models/progress.dart, package:dmv_practice_test/data/progress_store.dart, package:flutter_test/flutter_test.dart, package:shared_preferences/shared_preferences.dart, main

## Knowledge Gaps
- **373 isolated node(s):** `build`, `appRouterProvider`, `_`, `AppRoutes`, `startup` (+368 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **20 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `StateBank` connect `Home Screen` to `state_bank.dart`?**
  _High betweenness centrality (0.020) - this node is a cross-community bridge._
- **Why does `QuizViewModel` connect `history_page.dart` to `category_tile.dart`, `quiz_view_model.dart`, `quiz_page.dart`?**
  _High betweenness centrality (0.019) - this node is a cross-community bridge._
- **Why does `build` connect `themeModeViewModelProvider` to `Home Screen`?**
  _High betweenness centrality (0.018) - this node is a cross-community bridge._
- **What connects `build`, `appRouterProvider`, `_` to the rest of the system?**
  _373 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Riverpod Providers & Routing` be split into smaller, more focused modules?**
  _Cohesion score 0.07692307692307693 - nodes in this community are weakly interconnected._
- **Should `Route & Theme Constants` be split into smaller, more focused modules?**
  _Cohesion score 0.1111111111111111 - nodes in this community are weakly interconnected._
- **Should `API Error Handling` be split into smaller, more focused modules?**
  _Cohesion score 0.13333333333333333 - nodes in this community are weakly interconnected._