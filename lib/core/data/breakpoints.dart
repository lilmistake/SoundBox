import 'package:flutter/material.dart';

enum S { xs, sm, md, lg, xl }

List<S> screenSize(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  List<S> sizes = [S.sm];
  if (width > 1200) {
    sizes.add(S.xl);
  }
  if (width > 992) {
    sizes.add(S.lg);
  }
  if (width > 768) {
    sizes.add(S.md);
  }
  if (width > 400) {
    sizes.add(S.sm);
  }
  return sizes;
}

showPermanentQueue(BuildContext context) {
  return screenSize(context).contains(S.md);
}