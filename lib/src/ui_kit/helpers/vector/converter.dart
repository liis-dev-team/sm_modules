import 'package:freezed_annotation/freezed_annotation.dart';

import 'vector2/vector2.dart';

class VectorConverter<T> implements JsonConverter<T, Object?> {
  const VectorConverter();

  @override
  T fromJson(Object? json) {
    switch (json.runtimeType) {
      case List:
        return _handleList(json as List) as T;
      case Map:
        return _handleMap(json as Map) as T;
      case double:
        return json as T;
      case String:
        if (T.toString() == 'DateTime?') {
          return DateTime.parse(json as String).toLocal() as T;
        }
        return json as T;

      case DateTime:
        return json as T;
      default:
        return json as T;
    }
  }

  dynamic _handleMap(Map json) {
    if (T.toString() == 'Vector2<dynamic>?') {
      return Vector2.fromJson(Map<String, dynamic>.from(json));
    }
    switch (T) {
      default:
        return null;
    }
  }

  dynamic _handleList(List json) {
    switch (T) {
      default:
        return null;
    }
  }

  @override
  Object? toJson(T object) {
    if (object is List) {
      return (object).map((e) => e.toJson());
    }
    if (object is double) return object;
    if (object is String) return object;
    if (object is DateTime) return object.toUtc().toIso8601String();
    if (object is Vector2) return {'x': object.x, 'y': object.y};
    return object;
  }
}
