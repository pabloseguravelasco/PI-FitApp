import 'dart:convert';

import 'package:fitapp_flutter/models/exercise_response.dart';
import 'package:fluid_action_card/FluidActionCard/fluid_action_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Exercise>> items;

  @override
  void initState() {
    items = fetchExercise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
return Scaffold(
      appBar: AppBar(
        title: const Text('FIT APP'),
        backgroundColor: Colors.red,
      
      ),

  

     body: Column(
       children: [
         Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 0, 10),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: const Text('Ejercicios Recomendados',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
          
         ),
           SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: FutureBuilder<List<Exercise>>(
                future: items,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _exerciseList(snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              )),
              Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 0, 10),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: const Text('Plan de Ejercicios',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
          
         ),
       ],
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
                  exercise.imagen + exercise.text,
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
    
