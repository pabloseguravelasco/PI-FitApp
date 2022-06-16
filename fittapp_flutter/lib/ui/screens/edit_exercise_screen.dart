import 'dart:io';

import 'package:fitapp_flutter/bloc/exercise/exercise_bloc.dart';
import 'package:fitapp_flutter/models/exercise/exercise_dto.dart';
import 'package:fitapp_flutter/models/exercise/exercise_response.dart';
import 'package:fitapp_flutter/repository/ExerciseRepository/exercise_repository.dart';
import 'package:fitapp_flutter/repository/ExerciseRepository/exercise_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'menu_screen.dart';

class ExerciseEditScreen extends StatefulWidget {
  const ExerciseEditScreen({ Key? key }) : super(key: key);

  @override
  State<ExerciseEditScreen> createState() => _ExerciseEditScreenState();
}

class _ExerciseEditScreenState extends State<ExerciseEditScreen> {
late ExerciseRepository exerciseRepository;
   late String path = '';
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();
  TextEditingController zoneController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  @override
  void initState() {
    exerciseRepository = ExerciseRepositoryImpl();

    super.initState();
  }
  

Widget build(BuildContext context) {
  
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return BlocExerciseBloc(exerciseRepository);
        },
        child: BlocConsumer<BlocExerciseBloc, BlocExerciseState>(
          listenWhen: (context, state) {
            return state is ImageSelectedExerciseSuccessState;
          },
          listener: (context, state) {
            if (state is NewExerciseSuccessState) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MenuScreen()));
            } else if (state is NewExerciseErrorState) {
              _showSnackBar(context, state.message);
            }
          },
          buildWhen: (context, state) {
            return state is BlocExerciseInitial ||
                state is ImageSelectedExerciseSuccessState ||
                state is NewExerciseLoadingState;
          },
          builder: (context, state) {
            if (state is ImageSelectedExerciseSuccessState) {
              path = state.pickedFile.path;
              return buildForm(context, path);
            } else if (state is NewExerciseLoadingState) {
              return Center(child: const CircularProgressIndicator());
            }
            return buildForm(context, path);
          },
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {}

  Widget buildForm(BuildContext context, String filePath) {

    final args = ModalRoute.of(context)!.settings.arguments as Exercise;

    double deviceWidth = MediaQuery.of(context).size.width;
    return Form(
        key: _formKey,
        child: SafeArea(
            child: SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 90,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/images/banner.png',
                            height: 80,
                          ),
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                width: deviceWidth - 100,
                                child: TextFormField(
                                  controller: titleController,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.title),
                                      suffixIconColor: Colors.white,
                                      hintText: 'Nombre del Ejercicio',
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                width: deviceWidth - 100,
                                child: TextFormField(
                                  controller: textController,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.text_fields),
                                      suffixIconColor: Colors.white,
                                      hintText: 'Descripción del Ejercicio',
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                width: deviceWidth - 100,
                                child: TextFormField(
                                  controller: linkController,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.link),
                                      suffixIconColor: Colors.white,
                                      hintText: 'Vídeo del ejercicio (enlace)',
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                width: deviceWidth - 100,
                                child: TextFormField(
                                  controller: zoneController,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.accessibility_new),
                                      suffixIconColor: Colors.white,
                                      hintText: 'Zona a ejercitar',
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                width: deviceWidth - 100,
                                child: TextFormField(
                                  controller: durationController,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.watch),
                                      suffixIconColor: Colors.white,
                                      hintText: 'Duración del Ejercicio (min)',
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                ),
                              ),
                              buildImg(filePath),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                width: deviceWidth - 100,
                                child: Center(
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.redAccent),
                                        ),
                                        onPressed: () {
                                          BlocProvider.of<BlocExerciseBloc>(
                                                  context)
                                              .add(const SelectImageExerciseEvent(
                                                  ImageSource.gallery));
                                        },
                                        child: const Text(
                                            'Seleccionar una Imagen'))),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                final exerciseDto = ExerciseDto(
                                  title: titleController.text,
                                  text: textController.text,
                                  link: linkController.text,
                                  zone: zoneController.text,
                                  duration: durationController.text,
                                );
                                BlocProvider.of<BlocExerciseBloc>(context).add(
                                    EditExerciseEvent(exerciseDto, filePath, args.id));
                              }
                            },
                                child: Text('FINALIZAR'),
                                  style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.redAccent),
                                        ),
                            
                                  
                                )]),
                           
                            
                         
                          )
                        ,
                      ),
                    )));
  }

  buildImg(String filePath) {
    if (filePath.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          width: 100,
          height: 100,
          child: Image.file(File(filePath)),
        ),
      );
    } else {
      return Text('');
    }
  }
}
