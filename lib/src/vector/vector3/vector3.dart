import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sm_modules/src/vector/converter.dart';

part 'vector3.freezed.dart';
part 'vector3.g.dart';

@freezed
class Vector3<T> with _$Vector3<T> {
  const factory Vector3({
    @VectorConverter() T? x,
    @VectorConverter() T? y,
    @VectorConverter() T? z,
  }) = _Vector3;

  factory Vector3.fromJson(Map<String, Object?> json) =>
      _$Vector3FromJson(json);
}
