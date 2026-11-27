# Graph Report - .  (2026-11-27)

## Corpus Check
- Corpus is ~365 words - fits in a single context window. You may not need a graph.

## Summary
- 63 nodes · 69 edges · 9 communities (8 shown, 1 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

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

## God Nodes (most connected - your core abstractions)
1. `ApiException` - 3 edges
2. `ApiResult` - 3 edges
3. `ApiSuccess` - 3 edges
4. `ApiFailure` - 3 edges
5. `dioClient` - 3 edges
6. `appRouter` - 3 edges
7. `MyApp` - 2 edges
8. `ErrorInterceptor` - 2 edges
9. `HomePage` - 2 edges
10. `build` - 1 edges

## Surprising Connections (you probably didn't know these)
- None detected - all connections are within the same source files.

## Import Cycles
- None detected.

## Communities (9 total, 1 thin omitted)

### Community 0 - "Riverpod Providers & Routing"
Cohesion: 0.18
Nodes (10): @Riverpod, app_routes.dart, dioClientProvider, ../../features/home/presentation/views/home_page.dart, dioClient, appRouter, appRouterProvider, package:go_router/go_router.dart (+2 more)

### Community 1 - "Route & Theme Constants"
Cohesion: 0.20
Nodes (8): AppRoutes, home, AppTheme, dark, light, _seed, static const, static final

### Community 2 - "API Error Handling"
Cohesion: 0.22
Nodes (8): Exception, int?, ApiException, fromDio, message, statusCode, toString, package:dio/dio.dart

### Community 3 - "API Result Types"
Cohesion: 0.39
Nodes (7): api_exception.dart, ApiFailure, ApiResult, ApiSuccess, data, error, T

### Community 4 - "Dio Interceptors"
Cohesion: 0.29
Nodes (6): Interceptor, dio, ErrorInterceptor, onError, package:flutter/foundation.dart, return

### Community 5 - "Root App Widget"
Cohesion: 0.33
Nodes (5): ConsumerWidget, ../core/router/app_router.dart, ../core/theme/app_theme.dart, build, MyApp

### Community 6 - "Home Screen"
Cohesion: 0.33
Nodes (5): build, HomePage, package:easy_localization/easy_localization.dart, package:flutter/material.dart, StatelessWidget

### Community 7 - "App Entry Point"
Cohesion: 0.40
Nodes (4): app/app.dart, ensureInitialized, main, package:flutter_riverpod/flutter_riverpod.dart

## Knowledge Gaps
- **21 isolated node(s):** `build`, `message`, `statusCode`, `fromDio`, `toString` (+16 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **1 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `ApiException` connect `API Error Handling` to `API Result Types`?**
  _High betweenness centrality (0.043) - this node is a cross-community bridge._
- **Why does `dioClient` connect `Riverpod Providers & Routing` to `Dio Interceptors`?**
  _High betweenness centrality (0.043) - this node is a cross-community bridge._
- **What connects `build`, `message`, `statusCode` to the rest of the system?**
  _21 weakly-connected nodes found - possible documentation gaps or missing edges._