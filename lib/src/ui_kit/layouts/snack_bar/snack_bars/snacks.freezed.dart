// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'snacks.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppSnack {
  String? get index => throw _privateConstructorUsedError;
  Widget? get child => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  Widget? get actions => throw _privateConstructorUsedError;
  List<SnackOption>? get options => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppSnackCopyWith<AppSnack> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppSnackCopyWith<$Res> {
  factory $AppSnackCopyWith(AppSnack value, $Res Function(AppSnack) then) =
      _$AppSnackCopyWithImpl<$Res, AppSnack>;
  @useResult
  $Res call(
      {String? index,
      Widget? child,
      String? text,
      Widget? actions,
      List<SnackOption>? options,
      Duration duration});
}

/// @nodoc
class _$AppSnackCopyWithImpl<$Res, $Val extends AppSnack>
    implements $AppSnackCopyWith<$Res> {
  _$AppSnackCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = freezed,
    Object? child = freezed,
    Object? text = freezed,
    Object? actions = freezed,
    Object? options = freezed,
    Object? duration = null,
  }) {
    return _then(_value.copyWith(
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as String?,
      child: freezed == child
          ? _value.child
          : child // ignore: cast_nullable_to_non_nullable
              as Widget?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      actions: freezed == actions
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as Widget?,
      options: freezed == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<SnackOption>?,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppSnackImplCopyWith<$Res>
    implements $AppSnackCopyWith<$Res> {
  factory _$$AppSnackImplCopyWith(
          _$AppSnackImpl value, $Res Function(_$AppSnackImpl) then) =
      __$$AppSnackImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? index,
      Widget? child,
      String? text,
      Widget? actions,
      List<SnackOption>? options,
      Duration duration});
}

/// @nodoc
class __$$AppSnackImplCopyWithImpl<$Res>
    extends _$AppSnackCopyWithImpl<$Res, _$AppSnackImpl>
    implements _$$AppSnackImplCopyWith<$Res> {
  __$$AppSnackImplCopyWithImpl(
      _$AppSnackImpl _value, $Res Function(_$AppSnackImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = freezed,
    Object? child = freezed,
    Object? text = freezed,
    Object? actions = freezed,
    Object? options = freezed,
    Object? duration = null,
  }) {
    return _then(_$AppSnackImpl(
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as String?,
      child: freezed == child
          ? _value.child
          : child // ignore: cast_nullable_to_non_nullable
              as Widget?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      actions: freezed == actions
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as Widget?,
      options: freezed == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<SnackOption>?,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

class _$AppSnackImpl implements _AppSnack {
  const _$AppSnackImpl(
      {this.index,
      this.child,
      this.text,
      this.actions,
      final List<SnackOption>? options,
      this.duration = const Duration(seconds: 10)})
      : _options = options;

  @override
  final String? index;
  @override
  final Widget? child;
  @override
  final String? text;
  @override
  final Widget? actions;
  final List<SnackOption>? _options;
  @override
  List<SnackOption>? get options {
    final value = _options;
    if (value == null) return null;
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final Duration duration;

  @override
  String toString() {
    return 'AppSnack(index: $index, child: $child, text: $text, actions: $actions, options: $options, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSnackImpl &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.child, child) || other.child == child) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.actions, actions) || other.actions == actions) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index, child, text, actions,
      const DeepCollectionEquality().hash(_options), duration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppSnackImplCopyWith<_$AppSnackImpl> get copyWith =>
      __$$AppSnackImplCopyWithImpl<_$AppSnackImpl>(this, _$identity);
}

abstract class _AppSnack implements AppSnack {
  const factory _AppSnack(
      {final String? index,
      final Widget? child,
      final String? text,
      final Widget? actions,
      final List<SnackOption>? options,
      final Duration duration}) = _$AppSnackImpl;

  @override
  String? get index;
  @override
  Widget? get child;
  @override
  String? get text;
  @override
  Widget? get actions;
  @override
  List<SnackOption>? get options;
  @override
  Duration get duration;
  @override
  @JsonKey(ignore: true)
  _$$AppSnackImplCopyWith<_$AppSnackImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
