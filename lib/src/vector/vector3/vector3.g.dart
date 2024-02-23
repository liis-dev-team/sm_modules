// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vector3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Vector3Impl<T> _$$Vector3ImplFromJson<T>(Map<String, dynamic> json) =>
    _$Vector3Impl<T>(
      x: VectorConverter<T?>().fromJson(json['x']),
      y: VectorConverter<T?>().fromJson(json['y']),
      z: VectorConverter<T?>().fromJson(json['z']),
    );

Map<String, dynamic> _$$Vector3ImplToJson<T>(_$Vector3Impl<T> instance) =>
    <String, dynamic>{
      'x': _$JsonConverterToJson<Object?, T>(
          instance.x, VectorConverter<T?>().toJson),
      'y': _$JsonConverterToJson<Object?, T>(
          instance.y, VectorConverter<T?>().toJson),
      'z': _$JsonConverterToJson<Object?, T>(
          instance.z, VectorConverter<T?>().toJson),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
