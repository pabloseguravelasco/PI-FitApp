import 'dart:io';

import 'package:fitapp_flutter/bloc/diet/diet_bloc.dart';
import 'package:fitapp_flutter/models/diet/diet_dto.dart';
import 'package:fitapp_flutter/repository/DietRepository/diet_repository.dart';
import 'package:fitapp_flutter/repository/DietRepository/diet_repository_impl.dart';
import 'package:fitapp_flutter/ui/screens/diet_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DietCreateScreen extends StatefulWidget {
  const DietCreateScreen({ Key? key }) : super(key: key);

  @override
  State<DietCreateScreen> createState() => _DietCreateScreenState();


}

class _DietCreateScreenState extends State<DietCreateScreen> {

    late DietRepository dietRepository;
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController ingredientController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  


  @override
  void initState() {
   
    dietRepository = DietRepositoryImpl();

    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return ImagePickBlocBloc(dietRepository);
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
                  MaterialPageRoute(builder: (context) => const DietListScreen()),
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
                                      hintText: 'Nombre del Plato',
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                width: deviceWidth - 100,
                                child: TextFormField(
                                  controller: ingredientController,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.person),
                                      suffixIconColor: Colors.white,
                                      hintText: 'Ingredientes',
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                width: deviceWidth - 100,
                                child: TextFormField(
                                  controller: caloriesController,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.email),
                                      suffixIconColor: Colors.white,
                                      hintText: 'Calorías',
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                ),
                              ),
                              

                             
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                width: deviceWidth - 100,
                                child: BlocProvider(
                                  create: (context) {
                                    return ImagePickBlocBloc(
                                        dietRepository);
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
                                final dietDto = DietDto(
                                    title: titleController.text,
                                    ingredient: ingredientController.text,
                                    calories:caloriesController.text,
                               
                                 );
                                BlocProvider.of<ImagePickBlocBloc>(context)
                                    .add(SaveDietEvent(dietDto, filePath));
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
  }}