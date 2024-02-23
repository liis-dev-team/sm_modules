// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vector2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Vector2Impl<T> _$$Vector2ImplFromJson<T>(Map<String, dynamic> json) =>
    _$Vector2Impl<T>(
      x: VectorConverter<T?>().fromJson(json['x']),
      y: VectorConverter<T?>().fromJson(json['y']),
    );

Map<String, dynamic> _$$Vector2ImplToJson<T>(_$Vector2Impl<T> instance) =>
    <String, dynamic>{
      'x': _$JsonConverterToJson<Object?, T>(
          instance.x, VectorConverter<T?>().toJson),
      'y': _$JsonConverterToJson<Object?, T>(
          instance.y, VectorConverter<T?>().toJson),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
