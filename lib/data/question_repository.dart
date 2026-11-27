import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'models/state_bank.dart';
import 'models/state_bank_dto.dart';

part 'question_repository.g.dart';

class QuestionRepository {
  QuestionRepository(this._bundle, {required this.includeUnverified});

  static const assetDir = 'assets/questions/';

  static String assetPath(String stateCode) =>
      '$assetDir${stateCode.toLowerCase()}.json';

  final AssetBundle _bundle;

  /// Questions still marked `verify: true` have not been checked against the
  /// statute yet; release builds must not ship them.
  final bool includeUnverified;

  final _cache = <String, Future<StateBank>>{};

  Future<StateBank> load(String stateCode) => _cache[stateCode] ??= _bundle
      .loadString(assetPath(stateCode))
      .then(
        (raw) => StateBankDto.fromJson(
          jsonDecode(raw) as Map<String, dynamic>,
        ).toDomain(includeUnverified: includeUnverified),
      );

  Future<Set<String>> availableStates() async {
    final manifest = await AssetManifest.loadFromAssetBundle(_bundle);
    return {
      for (final asset in manifest.listAssets())
        if (asset.startsWith(assetDir) && asset.endsWith('.json'))
          asset
              .substring(assetDir.length, asset.length - '.json'.length)
              .toUpperCase(),
    };
  }
}

@Riverpod(keepAlive: true)
QuestionRepository questionRepository(Ref ref) =>
    QuestionRepository(rootBundle, includeUnverified: !kReleaseMode);
