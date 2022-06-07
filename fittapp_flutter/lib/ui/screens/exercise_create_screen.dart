import 'package:flutter/material.dart';

class ExerciseCreateScreen extends StatefulWidget {
  const ExerciseCreateScreen({ Key? key }) : super(key: key);

  @override
  State<ExerciseCreateScreen> createState() => _ExerciseCreateScreenState();
}

class _ExerciseCreateScreenState extends State<ExerciseCreateScreen> {
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