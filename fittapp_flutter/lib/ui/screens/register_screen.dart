import 'dart:io';

import 'package:fitapp_flutter/bloc/image_pick/image_pick_bloc_bloc.dart';
import 'package:fitapp_flutter/models/register_dto.dart';
import 'package:fitapp_flutter/repository/auth_repository/auth_repository.dart';
import 'package:fitapp_flutter/repository/auth_repository/auth_repository_impl.dart';
import 'package:fitapp_flutter/repository/register_repository/register_repository.dart';
import 'package:fitapp_flutter/repository/register_repository/register_repository_impl.dart';
import 'package:fitapp_flutter/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'menu_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late AuthRepository authRepository;
  late RegisterRepository registerRepository;
  final _formKey = GlobalKey<FormState>();

  TextEditingController nickController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    authRepository = AuthRepositoryImpl();
    registerRepository = RegisterRepositoryImpl();
    nickController.text = "Pablito97";
    nombreController.text = "Pablo";
    emailController.text = "a@a";
    passwordController.text = "1234";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return ImagePickBlocBloc(registerRepository);
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
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
                                  controller: nombreController,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.person),
                                      suffixIconColor: Colors.white,
                                      hintText: 'Nombre',
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                width: deviceWidth - 100,
                                child: TextFormField(
                                  controller: nickController,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.person),
                                      suffixIconColor: Colors.white,
                                      hintText: 'Nick',
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                width: deviceWidth - 100,
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.email),
                                      suffixIconColor: Colors.white,
                                      hintText: 'Email',
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                width: deviceWidth - 100,
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.vpn_key),
                                      suffixIconColor: Colors.white,
                                      hintText: 'Contraseña',
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
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.vpn_key),
                                      suffixIconColor: Colors.white,
                                      hintText: 'Confirmar contraseña',
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                  validator: (value) {
                                    return (value == null || value.isEmpty)
                                        ? 'Escribe una contrasña'
                                        : null;
                                  },
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
                                          BlocProvider.of<ImagePickBlocBloc>(
                                                  context)
                                              .add(const SelectImageEvent(
                                                  ImageSource.gallery));
                                        },
                                        child: const Text(
                                            'Seleccionar una Imagen'))),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              const Text('¿Ya estás registrado?'),
                              TextButton(
                                child: const Text(
                                  'Inicia Sesión',
                                  style: TextStyle(fontSize: 14),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final registerDto = RegisterDto(
                                  nombre: nombreController.text,
                                  nickname: nickController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                BlocProvider.of<ImagePickBlocBloc>(context)
                                    .add(SaveUserEvent(registerDto, filePath));
                              }
                            },
                            child: Text('REGISTRAR'),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20),
                                textStyle: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    )))));
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
