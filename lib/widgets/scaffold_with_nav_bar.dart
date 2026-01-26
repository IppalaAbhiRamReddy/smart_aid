import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.navigationShell, super.key});

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
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
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(
              Icons.home_rounded,
              color: AppColors.primaryBlue,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.medical_services_outlined),
            selectedIcon: Icon(
              Icons.medical_services_rounded,
              color: AppColors.primaryBlue,
            ),
            label: 'First Aid',
          ),
          NavigationDestination(
            icon: Icon(Icons.emergency_outlined, color: AppColors.emergencyRed),
            selectedIcon: Icon(
              Icons.emergency_rounded,
              color: AppColors.emergencyRed,
            ),
            label: 'Emergency',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(
              Icons.notifications_rounded,
              color: AppColors.primaryBlue,
            ),
            label: 'Reminders',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: AppColors.primaryBlue),
            label: 'Profile',
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
