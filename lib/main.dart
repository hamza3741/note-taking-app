import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootcamp_project/ViewModel/notes_viewmodel.dart';
import 'package:provider/provider.dart';

import 'View/login_screen.dart';
import 'View/signup_screen.dart';
import 'ViewModel/Auth_viewmodel.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Ensure this matches your platform.
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => NoteViewModel()),// Provide AuthViewModel
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(), // Set your initial screen
      ),
    );
  }
}
