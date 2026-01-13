import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_screen(tuan7).dart';
import 'firebase_options.dart'; // File này sinh ra khi cấu hình Firebase CLI

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform, 
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UTH SmartTasks',
      home: LoginScreen(),
    );
  }
}
