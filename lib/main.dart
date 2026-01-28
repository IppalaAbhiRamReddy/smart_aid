import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

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

  // Lock orientation to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const SmartAidApp());
}

class SmartAidApp extends StatelessWidget {
  const SmartAidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => SafetyService()),
        ChangeNotifierProvider(create: (_) => ReminderService()),
        ChangeNotifierProvider(create: (_) => LocalizationService()),
        ChangeNotifierProvider(
          create: (_) {
            final prefs = PreferencesService();
            prefs.init();
            return prefs;
          },
        ),
      ],
      child: Consumer2<LocalizationService, PreferencesService>(
        builder: (context, localization, prefs, child) {
          return MaterialApp.router(
            title: 'Smart Aid',
            theme: appTheme,
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.linear(prefs.fontSize)),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
