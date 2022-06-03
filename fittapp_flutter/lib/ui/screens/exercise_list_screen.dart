import 'dart:convert';

import 'package:fitapp_flutter/models/exercise_response.dart';
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
    return Scaffold(

      body: Column(children: [
          Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 0, 10),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: const Text('Zona a Ejercitar',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
          
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
      ],),

      
      
      
      
      
    );

    
  }
   Future<List<Exercise>> fetchExercise() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=1c0ce60ed8e0cd9f90ffb9b539b4c646&language=en-US&page=1'));
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
                  'https://image.tmdb.org/t/p/w500/' + exercise.texto,
                  width: MediaQuery.of(context).size.width * 0.4),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(exercise.titulo.toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
            ])),
      ),
    );
  }
}
    
