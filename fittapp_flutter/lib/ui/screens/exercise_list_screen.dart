import 'dart:convert';
import 'package:fitapp_flutter/bloc/exercise/exercise_bloc.dart';
import 'package:fitapp_flutter/models/exercise/exercise_response.dart';
import 'package:fitapp_flutter/repository/ExerciseRepository/exercise_repository.dart';
import 'package:fitapp_flutter/repository/ExerciseRepository/exercise_repository_impl.dart';
import 'package:fitapp_flutter/ui/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class ExerciseListScreen extends StatefulWidget {
  const ExerciseListScreen({ Key? key }) : super(key: key);

  @override
  State<ExerciseListScreen> createState() => _ExerciseListScreenState();
  
}

class _ExerciseListScreenState extends State<ExerciseListScreen> {

  late ExerciseRepository exerciseRepository;

  @override
  void initState() {
    exerciseRepository = ExerciseRepositoryImpl();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor:Colors.white24 ,
    
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        title:  const HomeAppBar(),
        backgroundColor: Colors.red),
        

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

          
             

             Container(
                 alignment: Alignment.center,
               child: SizedBox(
                       width: MediaQuery.of(context).size.width,
        height: 400,
                    child: BlocProvider(
                      create: (context) {
                        return BlocExerciseBloc(exerciseRepository)
                          ..add( FetchExercises());
                      },
                      child: Scaffold(body: _createExercises (context)),
                    )),
             ),
        ],),
      ),
     
      

      
      
      
      
      
    );

    
  }
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

  String imageUrl =
      exercise.imagen;

 return Center(
      child: GestureDetector(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
               ListTile(
                leading: Image.network(imageUrl, ) ,
                title: Text(exercise.title,
                style: TextStyle(fontSize: 25),),
                subtitle: Text( exercise.text),
              ),
            
            ],
          ),
        ),
      onTap: () {
                    Navigator.pushNamed(context, '/exercise', arguments: exercise);
                  }
                  
   ));}
}

/**
 * 
 * 
 * Container(
            child: Card(

              child: Column(
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.network(
                      urlDiet,
                    
                    fit: BoxFit.fill,
                    ),
                    
                    
                  ),
                  Text(urlTitle)
                ],
              ),
              
            ),
          );Container(
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
    
      
                ],
              ),
      
            ), */