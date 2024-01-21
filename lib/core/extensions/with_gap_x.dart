import 'package:flutter/material.dart';

extension WithGapX on List<Widget> {
  List<Widget> withGapX({double width = 15}) {
    List<Widget> children = toList();
    List<Widget> result = [];
    for (var child in children) {
      result.add(child);
      result.add(SizedBox(width: width));
    }
    return result;
  }
}
