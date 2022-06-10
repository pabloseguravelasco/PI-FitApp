import 'dart:convert';

import 'package:fitapp_flutter/bloc/exercise/exercise_bloc.dart';
import 'package:fitapp_flutter/models/exercise/exercise_response.dart';
import 'package:fitapp_flutter/repository/ExerciseRepository/exercise_repository.dart';
import 'package:fitapp_flutter/repository/ExerciseRepository/exercise_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ExerciseRepository exerciseRepository;


  @override
  void initState() {
    exerciseRepository = ExerciseRepositoryImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
        title: const Text('FIT APP'),
        backgroundColor: Colors.red,
      ),
      body: Column(children: [
        Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'EJERCICIOS RECOMENDADOS',
                style: TextStyle(
                  fontSize: 20,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 4
                    ..color = Colors.red[700]!,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'EJERCICIOS RECOMENDADOS',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red[100],
                ),
              ),
            ),
          ],
        ),
      /////////////////////////////////////////////////////////////////
      ///
       SizedBox(
            width: 800,
            height: 800,
            child: BlocProvider(
              create: (context) {
                return BlocExerciseBloc(exerciseRepository)
                  ..add( FetchExercises());
              },
              child: Scaffold(body: _createExercises (context)),
            )),
       Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(0),
          child: ElevatedButton(
            child: Text('CREAR EJERCICIO'),
            onPressed: () {
              Navigator.pushNamed(context, '/createExercise');
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle:
                    TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
        ),]),
   );}
        
  

  Widget _createExercises(BuildContext context) {
    return BlocBuilder<BlocExerciseBloc, BlocExerciseState>(
        builder: (context, state) {
      if (state is BlocExerciseInitial) {
        return const CircularProgressIndicator();
      } else if (state is BlocExerciseFetchedError) {
        return Text('Fail to loading exercises');
      } else if (state is BlocExerciseFetched) {
        return _buildExercises(context, state.exercises);
      } else {
        return const Text('Not support');
      }
    });
  }

   _buildExercises(BuildContext context, List<Exercise> exercises) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _buildExerciseItem(exercises[index]);
          },
          itemCount: exercises.length,
        ));
  }

   _buildExerciseItem(Exercise exercise) {
    final contentWidth = MediaQuery.of(context).size.width;
  final contentHeight = MediaQuery.of(context).size.height;
 
  String imageUrl =
      exercise.imagen.replaceAll("http://localhost:8080", Constant.apiUrl);

  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(.3)))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            ),
            title: Text(
              exercise.title,
              style: TextStyle(
                  color: Colors.black.withOpacity(.8),
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            trailing: const Icon(Icons.more_vert),
          ),
        ),
      
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: const <Widget>[
                  Icon(Icons.favorite_border, size: 31),
                  SizedBox(
                    width: 12,
                  ),
                  Icon(Icons.comment_sharp, size: 31),
                  SizedBox(
                    width: 12,
                  ),
                  Icon(Icons.send, size: 31),
                ],
              ),
              const Icon(Icons.bookmark_border, size: 31)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Text(
            'Les ha gustado esta publicación',
            style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(.8)),
          ),
        )
      ],
    ),
  );

   }
}
