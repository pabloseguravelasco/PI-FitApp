import 'package:fitapp_flutter/ui/screens/diet_create_screen.dart';
import 'package:fitapp_flutter/ui/screens/diet_screen.dart';
import 'package:fitapp_flutter/ui/screens/edit_exercise_screen.dart';
import 'package:fitapp_flutter/ui/screens/exercise_create_screen.dart';
import 'package:fitapp_flutter/ui/screens/exercise_list_screen.dart';
import 'package:fitapp_flutter/ui/screens/exercise_screen.dart';
import 'package:fitapp_flutter/ui/screens/home_screen.dart';
import 'package:fitapp_flutter/ui/screens/init_screen.dart';
import 'package:fitapp_flutter/ui/screens/login_screen.dart';
import 'package:fitapp_flutter/ui/screens/menu_screen.dart';
import 'package:fitapp_flutter/ui/screens/profile_screen.dart';
import 'package:fitapp_flutter/ui/screens/register_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/init',
      routes: {
        '/': (context) => const MenuScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/init': (context) => const InitScreen(),
        '/exercise': (context) => const ExerciseScreen(),
        '/exerciseList': (context) => const ExerciseListScreen(),
        '/diet': (context) => const DietScreen(),
        '/createExercise': (context) => const ExerciseCreateScreen(),
        '/createDiet': (context) => const DietCreateScreen(),
        '/editExercise':(context) => const ExerciseEditScreen()
      },
    );
  }
}
