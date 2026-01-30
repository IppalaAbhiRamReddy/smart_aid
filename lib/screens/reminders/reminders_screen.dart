import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../models/reminder_model.dart';
import '../../services/reminder_service.dart';
import '../../services/localization_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_styles.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          loc.translate('reminders_title'),
          style: AppTextStyles.heading.copyWith(fontSize: 22),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: Consumer<ReminderService>(
        builder: (context, service, child) {
          final reminders = service.reminders;
          final morning = reminders.where((r) => _isMorning(r.time)).toList();
          final afternoon = reminders
              .where((r) => _isAfternoon(r.time))
              .toList();
          final evening = reminders.where((r) => _isEvening(r.time)).toList();

          morning.sort(_compareTime);
          afternoon.sort(_compareTime);
          evening.sort(_compareTime);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (morning.isNotEmpty) ...[
                _buildSectionHeader(
                  loc.translate('morning'),
                  Icons.wb_sunny_outlined,
                  Colors.orange,
                ),
                ...morning.map((r) => _buildReminderCard(context, r, service)),
                const SizedBox(height: 20),
              ],
              if (afternoon.isNotEmpty) ...[
                _buildSectionHeader(
                  loc.translate('afternoon'),
                  Icons.wb_sunny,
                  Colors.amber,
                ),
                ...afternoon.map(
                  (r) => _buildReminderCard(context, r, service),
                ),
                const SizedBox(height: 20),
              ],
              if (evening.isNotEmpty) ...[
                _buildSectionHeader(
                  loc.translate('evening'),
                  Icons.nightlight_round,
                  Colors.indigo,
                ),
                ...evening.map((r) => _buildReminderCard(context, r, service)),
                const SizedBox(height: 20),
              ],
              if (reminders.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Column(
                      children: [
                        Icon(
                          Icons.notifications_off_outlined,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          loc.translate('no_reminders'),
                          style: AppTextStyles.bodyText.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEditDialog(context, null),
        backgroundColor: AppColors.primaryBlue,
        icon: const Icon(Icons.add),
        label: Text(loc.translate('add_reminder')),
      ),
    );
  }

  bool _isMorning(TimeOfDay t) => t.hour >= 5 && t.hour < 12;
  bool _isAfternoon(TimeOfDay t) => t.hour >= 12 && t.hour < 17;
  bool _isEvening(TimeOfDay t) => t.hour >= 17 || t.hour < 5;

  int _compareTime(Reminder a, Reminder b) {
    if (a.time.hour != b.time.hour) return a.time.hour.compareTo(b.time.hour);
    return a.time.minute.compareTo(b.time.minute);
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 24, 4, 12),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderCard(
    BuildContext context,
    Reminder reminder,
    ReminderService service,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showAddEditDialog(context, reminder),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            reminder.time.format(context).split(' ')[0],
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            reminder.time.format(context).split(' ')[1],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryBlue,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            reminder.label,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF334155),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          _getRepeatText(
                            reminder.repeat,
                            Provider.of<LocalizationService>(context),
                          ),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.grey.shade400,
                        size: 20,
                      ),
                      onPressed: () =>
                          _confirmDelete(context, reminder.id, service),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getRepeatText(ReminderRepeat repeat, LocalizationService loc) {
    switch (repeat) {
      case ReminderRepeat.daily:
        return loc.translate('every_day');
      case ReminderRepeat.weekdays:
        return loc.translate('weekdays_only');
      case ReminderRepeat.weekends:
        return loc.translate('weekends_only');
      case ReminderRepeat.none:
        return loc.translate('repeat_once');
    }
  }

  void _confirmDelete(
    BuildContext context,
    String id,
    ReminderService service,
  ) {
    final loc = Provider.of<LocalizationService>(context, listen: false);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(loc.translate('delete_confirm')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(loc.translate('cancel')),
          ),
          TextButton(
            onPressed: () {
              service.deleteReminder(id);
              Navigator.pop(ctx);
            },
            child: Text(
              loc.translate('delete'),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEditDialog(BuildContext context, Reminder? reminder) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _ReminderDialog(existingReminder: reminder),
    );
  }
}

class _ReminderDialog extends StatefulWidget {
  final Reminder? existingReminder;
  const _ReminderDialog({this.existingReminder});
  @override
  State<_ReminderDialog> createState() => _ReminderDialogState();
}

class _ReminderDialogState extends State<_ReminderDialog> {
  late TimeOfDay _selectedTime;
  late TextEditingController _labelController;
  ReminderRepeat _repeat = ReminderRepeat.daily;
  ReminderCategory _category = ReminderCategory.medication;

  @override
  void initState() {
    super.initState();
    final r = widget.existingReminder;
    _selectedTime = r?.time ?? TimeOfDay.now();
    _labelController = TextEditingController(text: r?.label ?? '');
    _repeat = r?.repeat ?? ReminderRepeat.daily;
    _category = r?.category ?? ReminderCategory.medication;
  }

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context);
    final isEditing = widget.existingReminder != null;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isEditing
                      ? loc.translate('edit_reminder')
                      : loc.translate('add_reminder'),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                final t = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                  helpText: loc.translate('time_picker_select'),
                  cancelText: loc.translate('cancel'),
                  confirmText: loc.translate('ok'),
                  hourLabelText: loc.translate('hour'),
                  minuteLabelText: loc.translate('minute'),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        timePickerTheme: TimePickerThemeData(
                          entryModeIconColor: AppColors.primaryBlue,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (t != null) setState(() => _selectedTime = t);
              },
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    _selectedTime.format(context),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _labelController,
              decoration: AppStyles.inputDecoration(
                hintText: 'e.g., Morning Medicine',
                labelText: loc.translate('label'),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              loc.translate('category_label'),
              style: AppTextStyles.cardTitle,
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ReminderCategory.values
                    .map(
                      (cat) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(loc.translate('cat_${cat.name}')),
                          selected: _category == cat,
                          onSelected: (selected) {
                            if (selected) setState(() => _category = cat);
                          },
                          selectedColor: AppColors.primaryBlue.withOpacity(0.2),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 20),
            Text(loc.translate('repeat'), style: AppTextStyles.cardTitle),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildRepeatChip(
                    loc.translate('every_day'),
                    ReminderRepeat.daily,
                  ),
                  const SizedBox(width: 8),
                  _buildRepeatChip(
                    loc.translate('weekdays_only'),
                    ReminderRepeat.weekdays,
                  ),
                  const SizedBox(width: 8),
                  _buildRepeatChip(
                    loc.translate('weekends_only'),
                    ReminderRepeat.weekends,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  loc.translate('save'),
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRepeatChip(String label, ReminderRepeat value) {
    final isSelected = _repeat == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) setState(() => _repeat = value);
      },
      selectedColor: AppColors.primaryBlue.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primaryBlue : Colors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  void _save() {
    if (_labelController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            Provider.of<LocalizationService>(
              context,
              listen: false,
            ).translate('fill_all_fields'),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    final service = Provider.of<ReminderService>(context, listen: false);
    final id = widget.existingReminder?.id ?? const Uuid().v4();
    final reminder = Reminder(
      id: id,
      time: _selectedTime,
      label: _labelController.text.trim(),
      category: _category,
      repeat: _repeat,
      enabled: widget.existingReminder?.enabled ?? true,
    );
    if (widget.existingReminder != null) {
      service.updateReminder(reminder);
    } else {
      service.addReminder(reminder);
    }
    Navigator.pop(context);
  }
}
