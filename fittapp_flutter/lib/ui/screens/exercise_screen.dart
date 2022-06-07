import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({ Key? key }) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white24 ,
      appBar: AppBar(
        title: const Text('FIT APP'),
        backgroundColor: Colors.red,
      
      ),
      
    );
  }
}