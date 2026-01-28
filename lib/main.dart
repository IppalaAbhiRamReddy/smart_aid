import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme/app_theme.dart';
import 'router.dart';

import 'services/auth_service.dart';
import 'services/safety_service.dart';
import 'services/reminder_service.dart';
import 'services/localization_service.dart';
import 'services/preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Force sign out removed to allow persistent login
  // await FirebaseAuth.instance.signOut();

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  // Lock orientation to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(SmartAidApp(prefs: prefs));
}

class SmartAidApp extends StatefulWidget {
  final SharedPreferences prefs;

  const SmartAidApp({super.key, required this.prefs});

  @override
  State<SmartAidApp> createState() => _SmartAidAppState();
}

class _SmartAidAppState extends State<SmartAidApp> {
  late final AuthService _authService;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
    _router = createRouter(_authService);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _authService),
        ChangeNotifierProvider(create: (_) => SafetyService()),
        ChangeNotifierProvider(create: (_) => ReminderService()),
        // Create PreferencesService with instance
        ChangeNotifierProvider(create: (_) => PreferencesService(widget.prefs)),
        // Create LocalizationService with saved language
        ChangeNotifierProvider(
          create: (_) => LocalizationService(
            initialLanguage: widget.prefs.getString('language') ?? 'en',
          ),
        ),
      ],
      child: Consumer2<LocalizationService, PreferencesService>(
        builder: (context, localization, prefsService, child) {
          // Sync mechanism: If preference changes, update localization
          if (localization.currentLanguage != prefsService.languageCode) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              localization.changeLocale(prefsService.languageCode);
            });
          }

          return MaterialApp.router(
            title: 'Smart Aid',
            theme: appTheme,
            debugShowCheckedModeBanner: false,
            routerConfig: _router,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(prefsService.fontSize),
                ),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
