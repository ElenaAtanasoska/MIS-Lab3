import 'package:lab2/providers/favorite_joke_provider.dart';
import 'package:lab2/screens/favorite_jokes_screen.dart';
import 'package:lab2/services/alarm_exact.dart';
import 'package:lab2/services/local_notif_service.dart';
import 'package:lab2/services/notif_service.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/joke_types_screen.dart';
import 'screens/jokes_by_type_screen.dart';
import 'screens/random_joke_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check if Firebase apps already exist before initializing
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // Initialize Notification Services
  NotificationService.initialize();
  tz.initializeTimeZones();
  await LocalNotificationService.initialize();

  // Handle Exact Alarm permissions and notifications
  if (await ExactAlarmHelper.checkExactAlarmPermission()) {
    await LocalNotificationService.scheduleDailyNotification();
  } else {
    var isGranted = await ExactAlarmHelper.requestExactAlarmPermission();
    if (isGranted) {
      await LocalNotificationService.scheduleDailyNotification();
    }
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      initialRoute: '/',
      routes: {
        '/': (context) => const JokeTypesScreen(),
        '/jokes_by_type': (context) => const JokesByTypeScreen(),
        '/random_joke': (context) => const RandomJokeScreen(),
        '/favorites': (context) => const FavoritesScreen(),
      },
    );
  }
}
