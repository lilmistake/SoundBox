import 'package:flutter/material.dart';

class PopUpMenuOption {
  final Icon icon;
  final String label;
  final Function() onTap;

  PopUpMenuOption(
      {required this.icon, required this.label, required this.onTap});
}