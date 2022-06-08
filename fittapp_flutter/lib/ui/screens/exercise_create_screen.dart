import 'dart:io';

import 'package:fitapp_flutter/bloc/exercise/exercise_bloc.dart';
import 'package:fitapp_flutter/models/exercise_Dto.dart';
import 'package:fitapp_flutter/repository/ExerciseRepository/exercise_repository.dart';
import 'package:fitapp_flutter/repository/ExerciseRepository/exercise_repository_impl.dart';
import 'package:fitapp_flutter/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExerciseCreateScreen extends StatefulWidget {
  const ExerciseCreateScreen({ Key? key }) : super(key: key);

  @override
  State<ExerciseCreateScreen> createState() => _ExerciseCreateScreenState();
}

class _ExerciseCreateScreenState extends State<ExerciseCreateScreen> {


  late ExerciseRepository exerciseRepository;
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return ImagePickBlocBloc(exerciseRepository);
        },
        child: _createBody(context));
  }

   _createBody(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(20),
            child: BlocConsumer<ImagePickBlocBloc, ImagePickBlocState>(
                listenWhen: (context, state) {
              return state is SaveUserSuccessState ||
                  state is RegisterErrorState;
            }, listener: (context, state) async {
              if (state is SaveUserSuccessState) {
                final prefs = await SharedPreferences.getInstance();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              } else if (state is RegisterErrorState) {
                _showSnackbar(context, state.message);
              }
            }, buildWhen: (context, state) {
              return state is ImagePickBlocInitial ||
                  state is RegisterLoadingState ||
                  state is ImageSelectedSuccessState;
            }, builder: (ctx, state) {
              if (state is ImageSelectedSuccessState) {
                return buildForm(ctx, state.pickedFile.path);
              } else if (state is RegisterLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return buildForm(ctx, '');
              }
            })),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget buildForm(BuildContext context, String filePath) {
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
                            'assets/images/logo_titulo.png',
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
                                      suffixIcon: Icon(Icons.person),
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
                                      suffixIcon: Icon(Icons.person),
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
                                  controller: durationController,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.email),
                                      suffixIconColor: Colors.white,
                                      hintText: 'Duracion del ejericio (min)',
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
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.vpn_key),
                                      suffixIconColor: Colors.white,
                                      hintText: 'Zona a Trabajar',
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                  validator: (value) {
                                    return (value == null || value.isEmpty)
                                        ? 'Escribe una contraseña'
                                        : null;
                                  },
                                ),
                              ),

                             
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                width: deviceWidth - 100,
                                child: BlocProvider(
                                  create: (context) {
                                    return ImagePickBlocBloc(
                                        exerciseRepository);
                                  },
                                  child: BlocConsumer<ImagePickBlocBloc,
                                          ImagePickBlocState>(
                                      listenWhen: (context, state) {
                                        return state
                                            is ImageSelectedSuccessState;
                                      },
                                      listener: (context, state) {},
                                      buildWhen: (context, state) {
                                        return state is ImagePickBlocInitial ||
                                            state is ImageSelectedSuccessState;
                                      },
                                      builder: (context, state) {
                                        if (state
                                            is ImageSelectedSuccessState) {
                                          print(
                                              'PATH ${state.pickedFile.path}');
                                          return Column(children: [
                                            Image.file(
                                              File(state.pickedFile.path),
                                              height: 100,
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.black,
                                                ),
                                                onPressed: () {},
                                                child: const Text(
                                                    'Actualizar Imagen'))
                                          ]);
                                        }
                                        return Center(
                                            child: ElevatedButton(
                                                 style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),) 
                                                ,
                                                onPressed: () {
                                                  BlocProvider.of<
                                                              ImagePickBlocBloc>(
                                                          context)
                                                      .add(
                                                          const SelectImageEvent(
                                                              ImageSource
                                                                  .gallery));
                                                },
                                                child: const Text(
                                                    'Seleccionar una Imagen')));
                                      }),
                                ),
                              ),
                            ],
                          ),
              
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                final exerciseDto = ExerciseDto(
                                    title: titleController.text,
                                    text: textController.text,
                                    link: linkController.text,
                                    zone: zoneController.text,
                                    duration: durationController.text,
                                 );
                                BlocProvider.of<ImagePickBlocBloc>(context)
                                    .add(SaveExerciseEvent(exerciseDto, filePath));
                              }
                            },
                            child: Container(
                                height: 50,
                                width: 400,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: TextButton(
                                  child: const Text('FINALIZAR',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255))),
                                  style: TextButton.styleFrom(
                                      backgroundColor:
                                          Colors.redAccent),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/');
                                  },
                                )),
                          )
                        ],
                      ),
                    )))));
  }
}
 

  