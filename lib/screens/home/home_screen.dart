import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:torch_light/torch_light.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../../theme/app_styles.dart';
import '../../theme/app_colors.dart';
import '../../services/localization_service.dart';
import '../../services/safety_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? _userModel;
  bool _isLoading = true;
  bool _isFlashlightOn = false;
  String _currentTipKey = 'tip_1';
  Timer? _sosTimer;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadTipOfDay();
  }

  Future<void> _loadTipOfDay() async {
    final loc = Provider.of<LocalizationService>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();

    int totalTips = int.tryParse(loc.translate('tip_total_count')) ?? 1;
    if (totalTips < 1) totalTips = 1;

    final lastDate = prefs.getString('last_tip_date');
    final lastIndex = prefs.getInt('last_tip_index') ?? 1;
    final today = DateTime.now().toIso8601String().split('T').first;

    List<String> historyList = prefs.getStringList('tip_history') ?? [];
    Set<int> history = historyList
        .map((e) => int.tryParse(e) ?? 0)
        .where((e) => e > 0)
        .toSet();

    if (lastDate == today) {
      if (mounted) {
        setState(() {
          _currentTipKey = 'tip_$lastIndex';
        });
      }
    } else {
      List<int> available = [];
      for (int i = 1; i <= totalTips; i++) {
        if (!history.contains(i)) {
          available.add(i);
        }
      }

      if (available.isEmpty) {
        history.clear();
        available = List.generate(totalTips, (i) => i + 1);
      }

      final random = Random();
      int newIndex = available[random.nextInt(available.length)];

      history.add(newIndex);
      List<String> newHistoryList = history.map((e) => e.toString()).toList();
      if (newHistoryList.length > 7) {
        newHistoryList = newHistoryList.sublist(newHistoryList.length - 7);
      }

      await prefs.setString('last_tip_date', today);
      await prefs.setInt('last_tip_index', newIndex);
      await prefs.setStringList('tip_history', newHistoryList);

      if (mounted) {
        setState(() {
          _currentTipKey = 'tip_$newIndex';
        });
      }
    }
  }

  Future<void> _loadUserData() async {
    final userData = Provider.of<AuthService>(
      context,
      listen: false,
    ).userProfile;
    if (userData != null) {
      if (mounted) {
        setState(() {
          _userModel = userData;
          _isLoading = false;
        });
      }
    } else {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String _getGreeting(LocalizationService loc) {
    final hour = DateTime.now().hour;
    if (hour < 12) return loc.translate('greeting_morning');
    if (hour < 17) return loc.translate('greeting_afternoon');
    return loc.translate('greeting_evening');
  }

  @override
  void dispose() {
    _stopSosMode();
    TorchLight.disableTorch();
    super.dispose();
  }

  Future<void> _toggleFlashlight() async {
    final safetyService = Provider.of<SafetyService>(context, listen: false);
    if (safetyService.isSosActive) {
      _stopSosMode();
      return;
    }

    final loc = Provider.of<LocalizationService>(context, listen: false);
    try {
      if (_isFlashlightOn) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }
      setState(() {
        _isFlashlightOn = !_isFlashlightOn;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              loc.translate('error') == 'error'
                  ? 'Error'
                  : loc.translate('error'),
            ),
          ),
        );
      }
    }
  }

  Future<void> _toggleSosMode() async {
    final safetyService = Provider.of<SafetyService>(context, listen: false);
    if (safetyService.isSosActive) {
      _stopSosMode();
    } else {
      await _startSosMode();
    }
  }

  Future<void> _startSosMode() async {
    if (_isFlashlightOn) {
      await TorchLight.disableTorch();
      setState(() => _isFlashlightOn = false);
    }

    const int unit = 200; // Unused but kept for reference
    final safetyService = Provider.of<SafetyService>(context, listen: false);

    safetyService.setSosActive(true);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("S.O.S Mode Active"),
        duration: Duration(seconds: 2),
      ),
    );

    int step = 0;
    _sosTimer = Timer.periodic(const Duration(milliseconds: 200), (
      timer,
    ) async {
      final isSosActive = Provider.of<SafetyService>(
        context,
        listen: false,
      ).isSosActive;
      if (!isSosActive) {
        timer.cancel();
        return;
      }

      // S (1,0,1,0,1) - Gap (0,0,0) - O (1,1,1,0,1,1,1,0,1,1,1) - Gap - S
      final sequence = [
        1,
        0,
        1,
        0,
        1,
        0,
        0,
        1,
        1,
        1,
        0,
        1,
        1,
        1,
        0,
        1,
        1,
        1,
        0,
        0,
        1,
        0,
        1,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
      ];

      final currentStep = step % sequence.length;
      final isOn = sequence[currentStep] == 1;

      try {
        if (isOn) {
          await TorchLight.enableTorch();
        } else {
          await TorchLight.disableTorch();
        }
      } catch (e) {
        // ignore errors
      }

      step++;
    });
  }

  void _stopSosMode() {
    _sosTimer?.cancel();
    _sosTimer = null;
    Provider.of<SafetyService>(context, listen: false).setSosActive(false);
    TorchLight.disableTorch().catchError((_) {});
  }

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context);

    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final userName = _userModel?.name.split(' ').first ?? 'User';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_getGreeting(loc), style: AppTextStyles.subHeading),
                      const SizedBox(height: 4),
                      Text(userName, style: AppTextStyles.heading),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => context.go('/profile'),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                      child: Text(
                        userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                        style: const TextStyle(
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              _buildStatusWidget(loc),
              const SizedBox(height: 24),

              Text(
                loc.translate('quick_actions'),
                style: AppTextStyles.sectionHeader,
              ),
              const SizedBox(height: 16),
              _buildQuickActionsGrid(loc),

              const SizedBox(height: 24),

              Text(
                loc.translate('next_reminder'),
                style: AppTextStyles.sectionHeader,
              ),
              const SizedBox(height: 16),
              _buildReminderCard(loc),

              const SizedBox(height: 24),
              Text(
                loc.translate('tip_of_day'),
                style: AppTextStyles.sectionHeader,
              ),
              const SizedBox(height: 16),
              _buildSafetyTipCard(loc),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusWidget(LocalizationService loc) {
    final safetyService = Provider.of<SafetyService>(context);
    final isSos = safetyService.isSosActive;
    final isSharing = safetyService.isLocationSharing;

    // Use a Gradient for the main card
    final Gradient bgGradient = isSos
        ? AppColors.dangerGradient
        : (isSharing
              ? const LinearGradient(
                  colors: [Color(0xFF10B981), Color(0xFF059669)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : AppColors.primaryGradient);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: bgGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color:
                (isSos
                        ? AppColors.error
                        : (isSharing ? Colors.green : AppColors.primaryBlue))
                    .withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isSos
                  ? Icons.warning_amber_rounded
                  : (isSharing ? Icons.share_location : Icons.shield_outlined),
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isSos ? "EMERGENCY" : loc.translate('your_status'),
                  style: GoogleFonts.outfit(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  isSos
                      ? "SOS Mode Active!"
                      : (isSharing
                            ? "Sharing Live Location"
                            : loc.translate('all_systems_normal')),
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid(LocalizationService loc) {
    final safetyService = Provider.of<SafetyService>(context);

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.4,
      children: [
        _buildActionCard(
          icon: Icons.medical_services_outlined,
          label: loc.translate('first_aid'),
          color: AppColors.error,
          onTap: () => context.go('/first-aid'),
        ),
        _buildActionCard(
          icon: safetyService.isSosActive
              ? Icons.warning_amber_rounded
              : (_isFlashlightOn ? Icons.flashlight_on : Icons.flashlight_off),
          label: safetyService.isSosActive
              ? "S.O.S"
              : loc.translate('flashlight'),
          color: safetyService.isSosActive ? Colors.red : Colors.orange,
          onTap: _toggleFlashlight,
          onDoubleTap: _toggleSosMode,
        ),
        _buildActionCard(
          icon: Icons.sos,
          label: loc.translate('emergency'),
          color: AppColors.emergencyRed,
          onTap: () => context.go('/emergency'),
        ),
        _buildActionCard(
          icon: Icons.assignment_ind_outlined,
          label: loc.translate('medical_id'),
          color: AppColors.primaryBlue,
          onTap: () => context.go('/profile'),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    VoidCallback? onDoubleTap,
  }) {
    return InkWell(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: AppStyles.cardDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(height: 12),
            Text(label, style: AppTextStyles.cardTitle.copyWith(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderCard(LocalizationService loc) {
    return InkWell(
      onTap: () => context.go('/reminders'),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: AppStyles.cardDecoration,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.medication,
                color: AppColors.primaryBlue,
                size: 28,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.translate('medications'),
                    style: AppTextStyles.cardTitle.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    loc.translate('check_reminders_subtitle'),
                    style: AppTextStyles.bodyText,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyTipCard(LocalizationService loc) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4), // Green 50
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb, color: Colors.green.shade600, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Did You Know?",
                  style: GoogleFonts.outfit(
                    color: Colors.green.shade800,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  loc.translate(_currentTipKey),
                  style: GoogleFonts.outfit(
                    color: Colors.green.shade900,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
