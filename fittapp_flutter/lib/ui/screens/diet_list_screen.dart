import 'package:flutter/material.dart';

class DietListScreen extends StatefulWidget {
  const DietListScreen({ Key? key }) : super(key: key);

  @override
  State<DietListScreen> createState() => _DietListScreenState();
}

class _DietListScreenState extends State<DietListScreen> {
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