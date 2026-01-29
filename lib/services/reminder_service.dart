import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/reminder_model.dart';

class ReminderService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Reminder> _reminders = [];
  StreamSubscription<QuerySnapshot>? _subscription;

  List<Reminder> get reminders => List.unmodifiable(_reminders);

  ReminderService() {
    _init();
  }

  void _init() {
    _auth.authStateChanges().listen((user) {
      _subscription?.cancel();

      if (user != null) {
        _subscribeToReminders(user.uid);
      } else {
        _reminders = [];
        notifyListeners();
      }
    });
  }

  // ---------------------------------------------------------------------------
  // FIRESTORE
  // ---------------------------------------------------------------------------

  void _subscribeToReminders(String userId) {
    _subscription = _firestore
        .collection('users')
        .doc(userId)
        .collection('reminders')
        .snapshots()
        .listen((snapshot) {
          final newReminders = snapshot.docs.map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return Reminder.fromMap(data);
          }).toList();

          _reminders = newReminders;
          notifyListeners();
        });
  }

  Future<void> addReminder(Reminder reminder) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('reminders')
        .doc(reminder.id)
        .set(reminder.toMap());
  }

  Future<void> updateReminder(Reminder reminder) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('reminders')
        .doc(reminder.id)
        .update(reminder.toMap());
  }

  Future<void> deleteReminder(String id) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('reminders')
        .doc(id)
        .delete();
  }

  Future<void> toggleReminder(String id) async {
    final reminder = _reminders.firstWhere(
      (r) => r.id == id,
      orElse: () => throw Exception('Reminder not found'),
    );

    await updateReminder(reminder.copyWith(enabled: !reminder.enabled));
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
