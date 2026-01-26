import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/emergency/emergency_screen.dart';
import 'screens/first_aid/first_aid_screen.dart';
import 'screens/first_aid/first_aid_detail_screen.dart';
import 'screens/reminders/reminders_screen.dart';
import 'models/first_aid_item.dart';
import 'widgets/scaffold_with_nav_bar.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => const SignupScreen()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/first-aid',
              builder: (context, state) => const FirstAidScreen(),
              routes: [
                GoRoute(
                  path: 'detail',
                  builder: (context, state) {
                    final item = state.extra as FirstAidItem;
                    return FirstAidDetailScreen(item: item);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/emergency',
              builder: (context, state) => const EmergencyScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/reminders',
              builder: (context, state) => const RemindersScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
