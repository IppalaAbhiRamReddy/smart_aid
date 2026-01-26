import 'package:flutter/foundation.dart';
import '../models/reminder_model.dart';

class ReminderService extends ChangeNotifier {
  final List<Reminder> _reminders = [];

  List<Reminder> get reminders => List.unmodifiable(_reminders);

  void addReminder(Reminder reminder) {
    _reminders.add(reminder);
    notifyListeners();
    // Schedule notification logic here
  }

  void updateReminder(Reminder reminder) {
    final index = _reminders.indexWhere((r) => r.id == reminder.id);
    if (index != -1) {
      _reminders[index] = reminder;
      notifyListeners();
    }
  }

  void deleteReminder(String id) {
    _reminders.removeWhere((r) => r.id == id);
    notifyListeners();
  }

  void toggleReminder(String id) {
    final index = _reminders.indexWhere((r) => r.id == id);
    if (index != -1) {
      final r = _reminders[index];
      _reminders[index] = r.copyWith(enabled: !r.enabled);
      notifyListeners();
    }
  }

  Future<void> requestPermissions() async {
    // Mock permission request
  }
}
