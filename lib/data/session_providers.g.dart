// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(clock)
final clockProvider = ClockProvider._();

final class ClockProvider
    extends
        $FunctionalProvider<
          DateTime Function(),
          DateTime Function(),
          DateTime Function()
        >
    with $Provider<DateTime Function()> {
  ClockProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clockProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clockHash();

  @$internal
  @override
  $ProviderElement<DateTime Function()> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DateTime Function() create(Ref ref) {
    return clock(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime Function() value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime Function()>(value),
    );
  }
}

String _$clockHash() => r'3f65ad34ac6fcd532de9004042bdf2ed2bd85b13';

@ProviderFor(random)
final randomProvider = RandomProvider._();

final class RandomProvider extends $FunctionalProvider<Random, Random, Random>
    with $Provider<Random> {
  RandomProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'randomProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$randomHash();

  @$internal
  @override
  $ProviderElement<Random> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Random create(Ref ref) {
    return random(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Random value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Random>(value),
    );
  }
}

String _$randomHash() => r'83ff04d9c2bda3b7d29c4393f76230f33f8c6839';

@ProviderFor(SelectedState)
final selectedStateProvider = SelectedStateProvider._();

final class SelectedStateProvider
    extends $NotifierProvider<SelectedState, String?> {
  SelectedStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedStateHash();

  @$internal
  @override
  SelectedState create() => SelectedState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedStateHash() => r'1086b638a9cf181d0debe651b7ee9cb984b2d506';

abstract class _$SelectedState extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(availableStates)
final availableStatesProvider = AvailableStatesProvider._();

final class AvailableStatesProvider
    extends
        $FunctionalProvider<
          AsyncValue<Set<String>>,
          Set<String>,
          FutureOr<Set<String>>
        >
    with $FutureModifier<Set<String>>, $FutureProvider<Set<String>> {
  AvailableStatesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'availableStatesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$availableStatesHash();

  @$internal
  @override
  $FutureProviderElement<Set<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Set<String>> create(Ref ref) {
    return availableStates(ref);
  }
}

String _$availableStatesHash() => r'768da5bd0012f095b361bf7b78198b677697c772';

@ProviderFor(stateBank)
final stateBankProvider = StateBankProvider._();

final class StateBankProvider
    extends
        $FunctionalProvider<
          AsyncValue<StateBank>,
          StateBank,
          FutureOr<StateBank>
        >
    with $FutureModifier<StateBank>, $FutureProvider<StateBank> {
  StateBankProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stateBankProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stateBankHash();

  @$internal
  @override
  $FutureProviderElement<StateBank> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<StateBank> create(Ref ref) {
    return stateBank(ref);
  }
}

String _$stateBankHash() => r'd5db32858b5db3dd59c6670a51df1fbaef35453b';

@ProviderFor(Progress)
final progressProvider = ProgressFamily._();

final class ProgressProvider
    extends $NotifierProvider<Progress, StateProgress> {
  ProgressProvider._({
    required ProgressFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'progressProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$progressHash();

  @override
  String toString() {
    return r'progressProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Progress create() => Progress();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StateProgress value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StateProgress>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ProgressProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$progressHash() => r'e296bd4a4cb6d429a1e86616dc5d5a76e358d7c0';

final class ProgressFamily extends $Family
    with
        $ClassFamilyOverride<
          Progress,
          StateProgress,
          StateProgress,
          StateProgress,
          String
        > {
  ProgressFamily._()
    : super(
        retry: null,
        name: r'progressProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  ProgressProvider call(String stateCode) =>
      ProgressProvider._(argument: stateCode, from: this);

  @override
  String toString() => r'progressProvider';
}

abstract class _$Progress extends $Notifier<StateProgress> {
  late final _$args = ref.$arg as String;
  String get stateCode => _$args;

  StateProgress build(String stateCode);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<StateProgress, StateProgress>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StateProgress, StateProgress>,
              StateProgress,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(ProStatus)
final proStatusProvider = ProStatusProvider._();

final class ProStatusProvider extends $NotifierProvider<ProStatus, bool> {
  ProStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proStatusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$proStatusHash();

  @$internal
  @override
  ProStatus create() => ProStatus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$proStatusHash() => r'0862ac22dad2d4a8c1383924696d10fb9c6757d9';

abstract class _$ProStatus extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(ThemeModeSetting)
final themeModeSettingProvider = ThemeModeSettingProvider._();

final class ThemeModeSettingProvider
    extends $NotifierProvider<ThemeModeSetting, ThemeMode> {
  ThemeModeSettingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeModeSettingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeModeSettingHash();

  @$internal
  @override
  ThemeModeSetting create() => ThemeModeSetting();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$themeModeSettingHash() => r'39543b1558668f5b79552717043447906fcdfe02';

abstract class _$ThemeModeSetting extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
