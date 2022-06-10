import 'dart:convert';

import 'package:fitapp_flutter/models/exercise/exercise_dto.dart';
import 'package:fitapp_flutter/models/exercise/exercise_response.dart';
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
  late Future<List<Exercise>> items;


  @override
  void initState() {
    exerciseRepository = ExerciseRepositoryImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

     return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return Bloc(exerciseRepository)
              ..add(fetchExercise(e));
          },
        ),
      ],
    child: Scaffold(
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
        ),
      ]),
    )
    );
  }

  Widget _createExercise(BuildContext context) {
  return BlocBuilder<>(
    builder: (context, state) {
      if (state is ) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is ) {
        return (
          message: state.message,
          retry: () {
            context
                .watch<>()
                .add(());
          },
        );
      } else if (state is ) {
        return (context, );
      } else {
        return const Text('Failed to create Exercise');
      }
    },
  );
}

Widget _createListExercise(BuildContext context, List<ExerciseDto> exercise) {
  return SizedBox(
    height: MediaQuery.of(context).size.height,
    child: ListView.separated(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemBuilder: (BuildContext context, int index) {
        return (context, [index]);
      },
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      scrollDirection: Axis.vertical,
      separatorBuilder: (context, index) => const VerticalDivider(
        color: Colors.transparent,
        width: 6.0,
      ),
      itemCount: .length,
    ),
  );
}

Widget _exercise(BuildContext contexto, Exercise data) {
  
}

 /* Future<List<Exercise>> fetchExercise() async {
    final response = await http
        .get(Uri.parse('https://fit-app-heroku.herokuapp.com/exercise/list'));
    if (response.statusCode == 201) {
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
              Image.network(exercise.imagen + exercise.text,
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
  }*/
}
