import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:heyuni/firebase_options.dart';
import 'package:heyuni/providers/theme_provider.dart';
import 'package:heyuni/pages/mentors_page.dart';
import 'package:heyuni/services/auth/auth_gate.dart';
import 'package:heyuni/pages/chat_page.dart';
import 'package:heyuni/pages/applications_page.dart';
import 'package:heyuni/pages/settings_page.dart';
import 'package:heyuni/pages/loginandregister/login_and_register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HeyUni!',
      theme: themeProvider.themeData,
      home: const AuthGate(),
      routes: {
        '/loginAndRegister': (context) => const LoginAndRegisterPage(),
        '/chat': (context) => ChatPage(),
        '/applications': (context) => ApplicationsPage(),
        '/settings': (context) => const SettingsPage(),
        '/mentors': (context) => MentorsPage(),
      },
    );
  }
}
