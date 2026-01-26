import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../theme/app_colors.dart';
import '../services/localization_service.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.navigationShell, super.key});

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (int index) => _onTap(context, index),
        backgroundColor: Colors.white,
        indicatorColor: AppColors.primaryBlue.withOpacity(0.1),
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black.withOpacity(0.1),
        elevation: 10,
        height: 70,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(
              Icons.home_rounded,
              color: AppColors.primaryBlue,
            ),
            label: loc.translate('home'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.medical_services_outlined),
            selectedIcon: const Icon(
              Icons.medical_services_rounded,
              color: AppColors.primaryBlue,
            ),
            label: loc.translate('first_aid'),
          ),
          NavigationDestination(
            icon: const Icon(
              Icons.emergency_outlined,
              color: AppColors.emergencyRed,
            ),
            selectedIcon: const Icon(
              Icons.emergency_rounded,
              color: AppColors.emergencyRed,
            ),
            label: loc.translate('emergency'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.notifications_outlined),
            selectedIcon: const Icon(
              Icons.notifications_rounded,
              color: AppColors.primaryBlue,
            ),
            label: loc.translate('reminders_title'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(
              Icons.person,
              color: AppColors.primaryBlue,
            ),
            label: loc.translate('profile'),
          ),
        ],
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
