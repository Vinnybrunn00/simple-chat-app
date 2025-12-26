import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ghost/core/models/user_app.dart';
import 'package:ghost/core/providers/current_platform.dart';
import 'package:ghost/ui/pages/auth_page.dart';
import 'package:ghost/ui/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (!isMobile.value) {
    await windowManager.ensureInitialized();

    final Size size = Size(700, 700);

    final WindowOptions windowOptions = WindowOptions(
      size: size,
      center: true,
      minimumSize: size,
      maximumSize: size,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
    runApp(const ChatApp());
  } else {
    runApp(const ChatApp());
  }
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: choosePage(),
    );
  }

  StreamBuilder<User?> choosePage() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) return HomePage();
        return ChangeNotifierProvider(
          create: (context) => UserModel(),
          child: AuthPage(),
        );
      },
    );
  }
}
