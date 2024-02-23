// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vector3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Vector3<T> _$Vector3FromJson<T>(Map<String, dynamic> json) {
  return _Vector3<T>.fromJson(json);
}

/// @nodoc
mixin _$Vector3<T> {
  @VectorConverter()
  T? get x => throw _privateConstructorUsedError;
  @VectorConverter()
  T? get y => throw _privateConstructorUsedError;
  @VectorConverter()
  T? get z => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $Vector3CopyWith<T, Vector3<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Vector3CopyWith<T, $Res> {
  factory $Vector3CopyWith(Vector3<T> value, $Res Function(Vector3<T>) then) =
      _$Vector3CopyWithImpl<T, $Res, Vector3<T>>;
  @useResult
  $Res call(
      {@VectorConverter() T? x,
      @VectorConverter() T? y,
      @VectorConverter() T? z});
}

/// @nodoc
class _$Vector3CopyWithImpl<T, $Res, $Val extends Vector3<T>>
    implements $Vector3CopyWith<T, $Res> {
  _$Vector3CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = freezed,
    Object? y = freezed,
    Object? z = freezed,
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
      z: freezed == z
          ? _value.z
          : z // ignore: cast_nullable_to_non_nullable
              as T?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Vector3ImplCopyWith<T, $Res>
    implements $Vector3CopyWith<T, $Res> {
  factory _$$Vector3ImplCopyWith(
          _$Vector3Impl<T> value, $Res Function(_$Vector3Impl<T>) then) =
      __$$Vector3ImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {@VectorConverter() T? x,
      @VectorConverter() T? y,
      @VectorConverter() T? z});
}

/// @nodoc
class __$$Vector3ImplCopyWithImpl<T, $Res>
    extends _$Vector3CopyWithImpl<T, $Res, _$Vector3Impl<T>>
    implements _$$Vector3ImplCopyWith<T, $Res> {
  __$$Vector3ImplCopyWithImpl(
      _$Vector3Impl<T> _value, $Res Function(_$Vector3Impl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = freezed,
    Object? y = freezed,
    Object? z = freezed,
  }) {
    return _then(_$Vector3Impl<T>(
      x: freezed == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as T?,
      y: freezed == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as T?,
      z: freezed == z
          ? _value.z
          : z // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Vector3Impl<T> implements _Vector3<T> {
  const _$Vector3Impl(
      {@VectorConverter() this.x,
      @VectorConverter() this.y,
      @VectorConverter() this.z});

  factory _$Vector3Impl.fromJson(Map<String, dynamic> json) =>
      _$$Vector3ImplFromJson(json);

  @override
  @VectorConverter()
  final T? x;
  @override
  @VectorConverter()
  final T? y;
  @override
  @VectorConverter()
  final T? z;

  @override
  String toString() {
    return 'Vector3<$T>(x: $x, y: $y, z: $z)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Vector3Impl<T> &&
            const DeepCollectionEquality().equals(other.x, x) &&
            const DeepCollectionEquality().equals(other.y, y) &&
            const DeepCollectionEquality().equals(other.z, z));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(x),
      const DeepCollectionEquality().hash(y),
      const DeepCollectionEquality().hash(z));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Vector3ImplCopyWith<T, _$Vector3Impl<T>> get copyWith =>
      __$$Vector3ImplCopyWithImpl<T, _$Vector3Impl<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Vector3ImplToJson<T>(
      this,
    );
  }
}

abstract class _Vector3<T> implements Vector3<T> {
  const factory _Vector3(
      {@VectorConverter() final T? x,
      @VectorConverter() final T? y,
      @VectorConverter() final T? z}) = _$Vector3Impl<T>;

  factory _Vector3.fromJson(Map<String, dynamic> json) =
      _$Vector3Impl<T>.fromJson;

  @override
  @VectorConverter()
  T? get x;
  @override
  @VectorConverter()
  T? get y;
  @override
  @VectorConverter()
  T? get z;
  @override
  @JsonKey(ignore: true)
  _$$Vector3ImplCopyWith<T, _$Vector3Impl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
