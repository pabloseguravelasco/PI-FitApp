import 'package:flutter/material.dart';
import 'package:grad_text/grad_text.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({ Key? key }) : super(key: key);

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width * 1,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/fondo_init.jpg"),
                      fit: BoxFit.cover))),
          Container(
              margin: const EdgeInsets.only(top: 44.0, right: 20.0),
              alignment: Alignment.topRight,
              child: const Text(
                'Skip',
                textAlign: TextAlign.right,
                style:
                    TextStyle(color: Colors.white, 
                    fontWeight: FontWeight.w900),
              )),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width * 1,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                
          GradientText(
            
            text: 'FIT APP',
            colors: <Color>[
                Colors.white,
                Colors.red
            ],
            style: TextStyle(fontSize: 60.0),
        ),
                  Container(
                    padding: const EdgeInsets.only(top: 200.0),
                    margin:const EdgeInsets.fromLTRB(10, 10, 10, 10 ),
                    child: const Text(
                      'La falta de conocimiento ya no es excusa',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white,
                      fontSize: 20),
                      
                    ),
                  ),
                  const Text(
                    
                    'Ponte a entrenar con nosotros',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,
                    fontSize: 20),
                  ),
                  SizedBox(
                    width: 350,
                    child: Container(
                      padding: const EdgeInsets.only(top: 25.0),
                  
                      ),
                    ),
                 
                  SizedBox(
                    width: 350,
                  
                  ),
                   Container(
                                height: 50,
                                width: 400,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                     margin: const EdgeInsets.only(top: 20.0, right: 60.0, left: 60.0),
                                child: TextButton(
                
                                  child: const Text('REGÍSTRATE',
                                      style: TextStyle(
                                        
                                          color: Color.fromARGB(
                                              255, 255, 255, 255))),
                                  style: TextButton.styleFrom(
                                      backgroundColor:
                                          Colors.redAccent),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/register');
                                  },
                                )),
                              Container(
                                height: 50,
                                width: 400,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                     margin: const EdgeInsets.only(top: 20.0, right: 60.0, left: 60.0),
                                child: TextButton(
                
                                  child: const Text('INICIAR SESIÓN',
                                      style: TextStyle(
                                        
                                          color: Color.fromARGB(
                                              255, 255, 255, 255))),
                                  style: TextButton.styleFrom(
                                      backgroundColor:
                                          Colors.redAccent),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                )),
                ],
              )))
        ],
      )),
    );
  }
}
