// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vector2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Vector2<T> _$Vector2FromJson<T>(Map<String, dynamic> json) {
  return _Vector2<T>.fromJson(json);
}

/// @nodoc
mixin _$Vector2<T> {
  @VectorConverter()
  T? get x => throw _privateConstructorUsedError;
  @VectorConverter()
  T? get y => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $Vector2CopyWith<T, Vector2<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Vector2CopyWith<T, $Res> {
  factory $Vector2CopyWith(Vector2<T> value, $Res Function(Vector2<T>) then) =
      _$Vector2CopyWithImpl<T, $Res, Vector2<T>>;
  @useResult
  $Res call({@VectorConverter() T? x, @VectorConverter() T? y});
}

/// @nodoc
class _$Vector2CopyWithImpl<T, $Res, $Val extends Vector2<T>>
    implements $Vector2CopyWith<T, $Res> {
  _$Vector2CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = freezed,
    Object? y = freezed,
  }) {
    return _then(_value.copyWith(
      x: freezed == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as T?,
      y: freezed == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as T?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Vector2ImplCopyWith<T, $Res>
    implements $Vector2CopyWith<T, $Res> {
  factory _$$Vector2ImplCopyWith(
          _$Vector2Impl<T> value, $Res Function(_$Vector2Impl<T>) then) =
      __$$Vector2ImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({@VectorConverter() T? x, @VectorConverter() T? y});
}

/// @nodoc
class __$$Vector2ImplCopyWithImpl<T, $Res>
    extends _$Vector2CopyWithImpl<T, $Res, _$Vector2Impl<T>>
    implements _$$Vector2ImplCopyWith<T, $Res> {
  __$$Vector2ImplCopyWithImpl(
      _$Vector2Impl<T> _value, $Res Function(_$Vector2Impl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = freezed,
    Object? y = freezed,
  }) {
    return _then(_$Vector2Impl<T>(
      x: freezed == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as T?,
      y: freezed == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Vector2Impl<T> implements _Vector2<T> {
  const _$Vector2Impl({@VectorConverter() this.x, @VectorConverter() this.y});

  factory _$Vector2Impl.fromJson(Map<String, dynamic> json) =>
      _$$Vector2ImplFromJson(json);

  @override
  @VectorConverter()
  final T? x;
  @override
  @VectorConverter()
  final T? y;

  @override
  String toString() {
    return 'Vector2<$T>(x: $x, y: $y)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Vector2Impl<T> &&
            const DeepCollectionEquality().equals(other.x, x) &&
            const DeepCollectionEquality().equals(other.y, y));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(x),
      const DeepCollectionEquality().hash(y));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Vector2ImplCopyWith<T, _$Vector2Impl<T>> get copyWith =>
      __$$Vector2ImplCopyWithImpl<T, _$Vector2Impl<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Vector2ImplToJson<T>(
      this,
    );
  }
}

abstract class _Vector2<T> implements Vector2<T> {
  const factory _Vector2(
      {@VectorConverter() final T? x,
      @VectorConverter() final T? y}) = _$Vector2Impl<T>;

  factory _Vector2.fromJson(Map<String, dynamic> json) =
      _$Vector2Impl<T>.fromJson;

  @override
  @VectorConverter()
  T? get x;
  @override
  @VectorConverter()
  T? get y;
  @override
  @JsonKey(ignore: true)
  _$$Vector2ImplCopyWith<T, _$Vector2Impl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
