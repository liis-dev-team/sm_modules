import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sm_modules/src/vector/converter.dart';

part 'vector2.freezed.dart';
part 'vector2.g.dart';

@freezed
class Vector2<T> with _$Vector2<T> {
  const factory Vector2({
    @VectorConverter() T? x,
    @VectorConverter() T? y,
  }) = _Vector2;

  factory Vector2.fromJson(Map<String, Object?> json) =>
      _$Vector2FromJson(json);
}
