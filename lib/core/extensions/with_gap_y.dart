import 'package:flutter/material.dart';

extension WithGapY on List<Widget> {
  List<Widget> withGapY({double height = 15}) {
    List<Widget> children = toList();
    List<Widget> result = [];
    for (var child in children) {
      result.add(child);
      result.add(SizedBox(height: height));
    }
    return result;
  }
}
