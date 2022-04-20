import 'package:fitapp_flutter/bloc/login/login_bloc.dart';
import 'package:fitapp_flutter/models/login_dto.dart';
import 'package:fitapp_flutter/repository/auth_repository/auth_repository.dart';
import 'package:fitapp_flutter/repository/auth_repository/auth_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
import 'menu_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthRepository authRepository;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nickController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    authRepository = AuthRepositoryImpl();
    nickController.text = "PabloSeg";
    passwordController.text = "Pablo@123";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return LoginBloc(authRepository);
        },
        child: _createBody(context));
  }

  _createBody(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            color: Color.fromARGB(255, 255, 255, 255),
            padding: const EdgeInsets.all(20),
            child: BlocConsumer<LoginBloc, LoginState>(
                listenWhen: (context, state) {
              return state is LoginSuccessState || state is LoginErrorState;
            }, listener: (context, state) async {
              if (state is LoginSuccessState) {
                final prefs = await SharedPreferences.getInstance();

                prefs.setString('token', state.loginResponse.token);
                prefs.setString('avatar', state.loginResponse.avatar);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuScreen()),
                );
              } else if (state is LoginErrorState) {
                _showSnackbar(context, state.message);
              }
            }, buildWhen: (context, state) {
              return state is LoginInitialState || state is LoginLoadingState;
            }, builder: (ctx, state) {
              if (state is LoginInitialState) {
                return buildForm(ctx);
              } else if (state is LoginLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return buildForm(ctx);
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

  Widget buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Image.asset(
            
              'assets/images/logo_titulo.png',
              height: 80,
            ),
           Stack(
  children: <Widget>[
    
    
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text( 
        '                     ¡Bienvenido!',
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
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '                     ¡Bienvenido!',
        style: TextStyle(
          fontSize: 20,
          color: Colors.red[100],
        ),
      ),
    ),
  ],
),
            

            
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              margin: const EdgeInsets.only(top: 50),
              child: TextFormField(
                controller: nickController,
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.email),
                    suffixIconColor: Colors.white,
                    hintText: 'Nombre de Usuario',
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
                onSaved: (String? value) {},
                validator: (String? value) {
                  return (value == null) ? 'El Nick no puede estar vacio.' : null;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              margin: const EdgeInsets.only(top: 20, bottom: 30),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.vpn_key),
                    suffixIconColor: Colors.white,
                    hintText: 'Contraseña',
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
                onSaved: (String? value) {},
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? 'Escribe una contraseña'
                      : null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox( 
                width: MediaQuery.of(context).size.width / 1.5,
                height: 50,
              
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),) ,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final loginDto = LoginDto(
                            nick: nickController.text,
                            password: passwordController.text);
                        BlocProvider.of<LoginBloc>(context)
                            .add(DoLoginEvent(loginDto));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Iniciando sesión')),
                        );
                      }
                    },
                    child: Text('Iniciar Sesion'),
                    )
                    ,
              ),
            ),
            Row(
              children: <Widget>[
                const Text('Not a member?'),
                TextButton(
                  child: const Text(
                    'Register now',
                    style: TextStyle(fontSize: 12,
                    color: Colors.redAccent),
                    
                    
                  ),
                  
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              height: 2,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                Color(0x55FFFFFF),
                                Color(0xFF0000000),
                              ])),
                            )),
                        Expanded(
                          flex: 2,
                          child: const Text(
                            '            Or continue',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              height: 2,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                Color(0xFF0000000),
                                Color(0xFFFFFFFF)
                              ])),
                            )),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(
                      'https://cdn-icons-png.flaticon.com/512/2991/2991148.png',
                      width: 30,
                    ),
                    Image.network(
                      'https://cdn3.iconfinder.com/data/icons/picons-social/57/56-apple-512.png',
                      width: 40,
                    ),
                    Image.network(
                      'https://cdn3.iconfinder.com/data/icons/capsocial-round/500/facebook-512.png',
                      width: 30,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
