import 'package:flutter/material.dart';

enum ReminderRepeat { none, daily, weekdays, weekends }

enum ReminderCategory { medication, appointment, checkup, other }

class Reminder {
  final String id;
  final TimeOfDay time;
  final String label;
  final bool enabled;
  final ReminderRepeat repeat;
  final ReminderCategory category;

  Reminder({
    required this.id,
    required this.time,
    required this.label,
    this.enabled = true,
    this.repeat = ReminderRepeat.daily,
    this.category = ReminderCategory.medication,
  });

  Reminder copyWith({
    String? id,
    TimeOfDay? time,
    String? label,
    bool? enabled,
    ReminderRepeat? repeat,
    ReminderCategory? category,
  }) {
    return Reminder(
      id: id ?? this.id,
      time: time ?? this.time,
      label: label ?? this.label,
      enabled: enabled ?? this.enabled,
      repeat: repeat ?? this.repeat,
      category: category ?? this.category,
    );
  }
}
