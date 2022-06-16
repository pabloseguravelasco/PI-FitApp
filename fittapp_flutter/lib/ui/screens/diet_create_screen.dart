import 'dart:io';

import 'package:fitapp_flutter/bloc/diet/diet_bloc.dart';
import 'package:fitapp_flutter/models/diet/diet_dto.dart';
import 'package:fitapp_flutter/repository/DietRepository/diet_repository.dart';
import 'package:fitapp_flutter/repository/DietRepository/diet_repository_impl.dart';
import 'package:fitapp_flutter/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'menu_screen.dart';

class DietCreateScreen extends StatefulWidget {
  const DietCreateScreen({ Key? key }) : super(key: key);

  @override
  State<DietCreateScreen> createState() => _DietCreateScreenState();


}

class _DietCreateScreenState extends State<DietCreateScreen> {

    late DietRepository dietRepository;
       late String path = '';
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
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return BlocDietBloc(dietRepository);
        },
        child: BlocConsumer<BlocDietBloc, BlocDietState>(
          listenWhen: (context, state) {
            return state is ImageSelectedDietSuccessState;
          },
          listener: (context, state) {
            if (state is NewDietSuccessState) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MenuScreen()));
            } else if (state is NewDietErrorState) {
              _showSnackBar(context, state.message);
            }
          },
          buildWhen: (context, state) {
            return state is BlocDietInitial ||
                state is ImageSelectedDietSuccessState ||
                state is NewDietLoadingState;
          },
          builder: (context, state) {
            if (state is ImageSelectedDietSuccessState) {
              path = state.pickedFile.path;
              return buildForm(context, path);
            } else if (state is NewDietLoadingState) {
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
                                      suffixIcon: Icon(Icons.food_bank),
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
                                      suffixIcon: Icon(Icons.nature),
                                      suffixIconColor: Colors.white,
                                      hintText: 'Calorías',
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
                                          BlocProvider.of<BlocDietBloc>(
                                                  context)
                                              .add(const SelectImageDietEvent(
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
                                final dietDto = DietDto(
                                  title: titleController.text,
                                  ingredient: ingredientController.text,
                                  calories: caloriesController.text,
                              
                                );
                                BlocProvider.of<BlocDietBloc>(context).add(
                                    SaveDietEvent(dietDto, filePath));
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