import 'dart:convert';

import 'package:fitapp_flutter/bloc/diet/diet_bloc.dart';
import 'package:fitapp_flutter/bloc/exercise/exercise_bloc.dart';
import 'package:fitapp_flutter/models/diet/diet_response.dart';
import 'package:fitapp_flutter/models/exercise/exercise_response.dart';
import 'package:fitapp_flutter/models/user/user_dto.dart';
import 'package:fitapp_flutter/repository/DietRepository/diet_repository.dart';
import 'package:fitapp_flutter/repository/DietRepository/diet_repository_impl.dart';
import 'package:fitapp_flutter/repository/ExerciseRepository/exercise_repository.dart';
import 'package:fitapp_flutter/repository/ExerciseRepository/exercise_repository_impl.dart';
import 'package:fitapp_flutter/ui/widgets/home_app_bar.dart';
import 'package:fluid_action_card/FluidActionCard/fluid_action_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ExerciseRepository exerciseRepository;
  late DietRepository dietRepository;
  late Future<SharedPreferences> _prefs;


  @override
  void initState() {
    exerciseRepository = ExerciseRepositoryImpl();
    dietRepository = DietRepositoryImpl();
    _prefs = SharedPreferences.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return
    DefaultTabController(
      length:2,
    child: Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
         automaticallyImplyLeading: false, 
        title:  const HomeAppBar(),
        backgroundColor: Colors.red,
         bottom: const TabBar(
              tabs: [
                Tab(text: "Ejercicios"),
                Tab(text: 'Dietas',)
     ] )),
      body: TabBarView(
         children: [
           Center(
             child: Column(children: [
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
             Container(
                 alignment: Alignment.center,
               child: SizedBox(
                    width: 400,
                    height: 360,
                    child: BlocProvider(
                      create: (context) {
                        return BlocExerciseBloc(exerciseRepository)
                          ..add( FetchExercises());
                      },
                      child: Scaffold(body: _createExercises (context)),
                    )),
             ),
             Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 30),
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
           ),
           Center(
            child: Column(
       
       children: [
         
         Stack(
  children: <Widget>[
    
    
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text( 
        'PLATOS RECOMENDADOS',
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
    'PLATOS RECOMENDADOS',
        style: TextStyle(
          fontSize: 20,
          color: Colors.red[100],
        ),
      ),
    ),
  ],
),
          
         Container(
                 alignment: Alignment.center,
               child: SizedBox(
                    width: 400,
                    height: 360,
                    child: BlocProvider(
                      create: (context) {
                        return BlocDietBloc(dietRepository)
                          ..add( FetchDiets());
                      },
                      child: Scaffold(body: _createDiets(context)),
                    )),
             ),
             Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  child: Text('CREAR PLATO'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/createDiet');
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),
              )   
        
    
     ]
     ),)
         ],
       ),),
      
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
            return _buildExerciseItem(exercises[index], context);
          },
          itemCount: exercises.length,
        ));
  }

   _buildExerciseItem(Exercise exercise, BuildContext context) {

  String imageUrl =
      exercise.imagen;
 var nickname;
 var role;

 
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('EDITAR',
                    style: TextStyle(color: Colors.green),),
                    onPressed: () { Navigator.pushNamed(context, '/editExercise', arguments: exercise);},
                  ),
                  const SizedBox(width: 3),
                  TextButton(
                    child: const Text('ELIMINAR',
                      style: TextStyle(color: Colors.red),),
                    onPressed: () {
                        _prefs.then((SharedPreferences prefs) {   
                        nickname = prefs.getString("nickname");
                        role = prefs.getString("role");

                        if ( role == "ADMIN") {

                        BlocProvider.of<BlocExerciseBloc>(context)
                            .add(DeleteExerciseEvent(exercise.id));
                      Navigator.pushNamed(context, '/', arguments: exercise);} },
                  );
                  const SizedBox(width: 8);
   })],
              ),
            ],
          ),
        ),
      onTap: () {
                    Navigator.pushNamed(context, '/exercise', arguments: exercise);
                  }
   ));}
    /*Container(
  width: 300,
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(.3)))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: ListTile(
              leading: Image(image:NetworkImage(imageUrl) ,
              
            
              ),
              title: Text(
                exercise.title,
                style: TextStyle(
                    color: Colors.black.withOpacity(.8),
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
             
            ),
          ),
        ),
      
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Text(
                'Duración: ' + exercise.duration + "min",
                style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(.8)),
              ),
               
            ),
             Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Text(
            'Zona: ' + exercise.zone,
            style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(.8)),
          ),
           
        )
          ],
        ),
         
      ],
    ),
  );*/

 

  Widget _createDiets(BuildContext context) {
    return BlocBuilder<BlocDietBloc, BlocDietState>(
        builder: (context, state) {
      if (state is BlocDietInitial) {
        return const CircularProgressIndicator();
      } else if (state is BlocDietFetchedError) {
        return Text('Fail to loading diets');
      } else if (state is BlocDietFetched) {
        return _buildDiets(context, state.diets);
      } else {
        return const Text('Not support');
      }
    });
  }

   _buildDiets(BuildContext context, List<Diet> diets) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _buildDietItem(diets[index],context);
          },
          itemCount: diets.length,
        ));
  }

   _buildDietItem(Diet diet, BuildContext context) {

  String imageUrl =
      diet.imagen;
 var nickname;
 var role;

return  Center(
      child: GestureDetector(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
               ListTile(
                leading: Image.network(imageUrl, ) ,
                title: Text(diet.title,
                style: TextStyle(fontSize: 25),),
                subtitle: Text( diet.calories),
              ),
                Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
               
                  const SizedBox(width: 3),
                   TextButton(
                    child: const Text('ELIMINAR',
                      style: TextStyle(color: Colors.red),),
                    onPressed: () {
                        _prefs.then((SharedPreferences prefs) {   
                        nickname = prefs.getString("nickname");
                        role = prefs.getString("role");

                        if ( role == "ADMIN") {

                        BlocProvider.of<BlocDietBloc>(context)
                            .add(DeleteDietEvent(diet.id));
                      Navigator.pushNamed(context, '/', arguments: diet);} },
                  );
                  const SizedBox(width: 8);
   })
                ],
              ),
         
            ],
          ),
        ),
          onTap: () {
                    Navigator.pushNamed(context, '/diet', arguments: diet);
                  }
   ));}

   }

