import 'package:flutter/material.dart';

class FirstAidItem {
  final String id;
  final String titleKey; // Localization key
  final IconData? iconData; // For display
  final String severity; // Low, Medium, High, Critical
  final String category; // Common, Critical, Outdoor
  final List<String> steps; // Localization keys
  final List<ToolItem> tools;
  final List<String> dos; // Localization keys
  final List<String> donts; // Localization keys

  FirstAidItem({
    required this.id,
    required this.titleKey,
    this.iconData,
    required this.severity,
    required this.category,
    this.steps = const [],
    this.tools = const [],
    this.dos = const [],
    this.donts = const [],
  });
}

class ToolItem {
  final String nameKey;
  final IconData iconData;

  ToolItem({required this.nameKey, required this.iconData});
}
