import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

extension ListExtension<E> on List<E> {
  List<E> separate(E separator) {
    var result = <E>[
      for (var i = 0; i < length; i++) ...[
        this[i],
        if (i != length - 1) separator
      ]
    ];

    return result;
  }

  List<Widget> separateWithPadding(EdgeInsets insets) {
    assert(this is List<Widget>);
    var result = <Widget>[
      for (var i = 0; i < length; i++) ...[
        Padding(
          padding: i != length - 1 ? insets : const EdgeInsets.all(0),
          child: this[i] as Widget,
        )
      ]
    ];

    return result;
  }

  List<Widget> coverWithPadding(EdgeInsets insets) {
    assert(this is List<Widget>);
    var result = <Widget>[
      for (var i = 0; i < length; i++) ...[
        Padding(
          padding: insets,
          child: this[i] as Widget,
        )
      ]
    ];

    return result;
  }

  bool compare(List<E>? other) {
    Function eq = const ListEquality().equals;
    return eq(this, other);
  }

  bool compareR(List<E>? other) {
    Function eq = const ListEquality().equals;
    return !eq(this, other);
  }

  bool deepCompare(List<E>? other) {
    Function eq = const DeepCollectionEquality().equals;
    return eq(this, other);
  }

  bool deepCompareR(List<E>? other) {
    Function eq = const DeepCollectionEquality().equals;
    return !eq(this, other);
  }
}
