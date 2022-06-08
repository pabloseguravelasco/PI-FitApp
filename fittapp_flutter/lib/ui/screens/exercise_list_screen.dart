import 'dart:convert';
import 'package:fitapp_flutter/models/exercise/exercise_response.dart';
import 'package:fitapp_flutter/models/exercise/exercise_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExerciseListScreen extends StatefulWidget {
  const ExerciseListScreen({ Key? key }) : super(key: key);

  @override
  State<ExerciseListScreen> createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseListScreen> {
  @override
  Widget build(BuildContext context) {
     final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:Colors.white24 ,
      appBar: AppBar(
        title: const Text('FIT APP'),
        backgroundColor: Colors.red,
      
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
          
                 Stack(
  children: <Widget>[
    
    Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text( 
            'EJERCICIOS ESPECÍFICOS',
            style: TextStyle(
              fontSize: 20,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 4
                ..color = Colors.red[700]!,
            ),
          ),
        ),
    ),
    
    Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
        'EJERCICIOS ESPECÍFICOS',
            style: TextStyle(
              fontSize: 20,
              color: Colors.red[100],
            ),
          ),
        ),
    ),
  ],
),

Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            height: 100.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
               Container(
               
               alignment: Alignment.center,
               padding: EdgeInsets.all(10),
               
               child:ElevatedButton(
                 
                 
              child: Text('ABDOMINAL'),
              
              onPressed: () {
                     Navigator.pushNamed(context, '');
                     
                 },
              style: ElevatedButton.styleFrom(
                   side: BorderSide(
                  width: 3.0,
                  color: Colors.white),
                  primary: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  textStyle: TextStyle(
                  fontSize: 15,

                  fontWeight: FontWeight.bold),
                  ),
                 
              
             )
          
          
     ,
), Container(
               
               alignment: Alignment.center,
               padding: EdgeInsets.all(10),
               child:ElevatedButton(
                 
              child: Text('PECHO'),
              onPressed: () {
                     Navigator.pushNamed(context, '');
                     
                 },
                 
              style: ElevatedButton.styleFrom(
                  side: BorderSide(
                  width: 3.0,
                  color: Colors.white),
                  primary: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
                 
              
             )
          
          
     ,
),
               Container(
               
               alignment: Alignment.center,
               padding: EdgeInsets.all(10),
               child:ElevatedButton(
                 
              child: Text('ESPALDA'),
              onPressed: () {
                     Navigator.pushNamed(context, '');
                     
                 },
              style: ElevatedButton.styleFrom(
                  side: BorderSide(
                  width: 3.0,
                  color: Colors.white),
                  primary: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
                 
              
             )
          
          
     ,
),
                 Container(
               
               alignment: Alignment.center,
               padding: EdgeInsets.all(10),
               child:ElevatedButton(
                 
              child: Text('BRAZOS'),
              onPressed: () {
                     Navigator.pushNamed(context, '');
                     
                 },
              style: ElevatedButton.styleFrom(
                  side: BorderSide(
                  width: 3.0,
                  color: Colors.white),
                  primary: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
                 
              
             )
          
          
     ,
), Container(
               
               alignment: Alignment.center,
               padding: EdgeInsets.all(10),
               child:ElevatedButton(
                 
              child: Text('PIERNAS'),
              onPressed: () {
                     Navigator.pushNamed(context, '');
                     
                 },
              style: ElevatedButton.styleFrom(
                  side: BorderSide(
                  width: 3.0,
                  color: Colors.white),
                  primary: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
                 
              
             )
          
          
     ,
),
 Container(
               
               alignment: Alignment.center,
               padding: EdgeInsets.all(10),
               child:ElevatedButton(
                 
              child: Text('GLUTEOS'),
              onPressed: () {
                     Navigator.pushNamed(context, '');
                     
                 },
              style: ElevatedButton.styleFrom(
                  side: BorderSide(
                  width: 3.0,
                  color: Colors.white),
                  primary: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
                 
              
             )
          
          
     ,
),
 Container(
               
               alignment: Alignment.center,
               padding: EdgeInsets.all(10),
               child:ElevatedButton(
                 
              child: Text('HOMBROS'),
              onPressed: () {
                     Navigator.pushNamed(context, '');
                     
                 },
              style: ElevatedButton.styleFrom(
                  side: BorderSide(
                  width: 3.0,
                  color: Colors.white),
                  primary: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
                 
              
             )
          
          
     ,
),
              ],
            ),
          ),

             Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 0, 10),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: const Text('Ejercicios',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold))),
            
           ),

            Container(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Card(
        child: SizedBox(
          width: 150,
          height: 200,
          child: Padding
          (  padding: const EdgeInsets.fromLTRB(50, 15, 0, 0),
          child: Text('Ejercicio')),
        ),
      ),
        Card(
        child: SizedBox(
          width: 150,
          height: 200,
          child: Padding
          (  padding: const EdgeInsets.fromLTRB(50, 15, 0, 0),
          child: Text('Ejercicio')),
        ),
      ),
        Card(
        child: SizedBox(
          width: 150,
          height: 200,
          child: Padding
          (  padding: const EdgeInsets.fromLTRB(50, 15, 0, 0),
          child: Text('Ejercicio')),
        ),
      ),
        Card(
        child: SizedBox(
          width: 150,
          height: 200,
          child: Padding
          (  padding: const EdgeInsets.fromLTRB(50, 15, 0, 0),
          child: Text('Ejercicio')),
        ),
      ),
      
                ],
              ),
      
            ),
        ],),
      ),
     
      

      
      
      
      
      
    );

    
  }
   Future<List<Exercise>> fetchExercise() async {
    final response = await http.get(Uri.parse(
        'https://fit-app-heroku.herokuapp.com/exercise/list'));
    if (response.statusCode == 200) {
      return ExerciseResponse.fromJson(jsonDecode(response.body)).content;
    } else {
      throw Exception('Failed to load the exercises');
    }
  }

  Widget _exerciseList(List<Exercise> exerciseList) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: exerciseList.length,
        itemBuilder: (context, index) {
          return _exerciseItem(exerciseList.elementAt(index), index);
        },
      ),
    );
  }

  Widget _exerciseItem(Exercise exercise, int index) {
    return Card(
      margin: const EdgeInsets.fromLTRB(5, 15, 5, 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () =>
            Navigator.pushNamed(context, '/exercise', arguments: exercise),
        child: SizedBox(
            width: 200,
            height: 200,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.network(
                  'https://image.tmdb.org/t/p/w500/' + exercise.text,
                  width: MediaQuery.of(context).size.width * 0.4),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(exercise.title.toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
            ])),
      ),
    );
  }
}
    
