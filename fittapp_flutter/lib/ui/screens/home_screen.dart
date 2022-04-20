import 'package:fluid_action_card/FluidActionCard/fluid_action_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
return Scaffold(
      appBar: AppBar(
        title: const Text('FIT APP'),
        backgroundColor: Colors.red,
      
      ),

      
       body: FluidActionCard(
            color1: Colors.black,
            color2: Colors.black,
            backgroundcolor: Colors.transparent,
            borderRadius1: BorderRadius.circular(100),
            borderRadius2: BorderRadius.circular(20),
            TextPosition_Top: 20.0,
            TextPosition_Down: 20.0,
            width: 30,
            height: 30,
            CardCount: 6,
            text1: Text(
              "Nombre del Ejercicio",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontStyle: FontStyle.italic),
            ),
            text2: Text(
              "Duración :---",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
              ),
            ),
            Position: 0.0,
            shadow: BoxShadow(
              
              color: Colors.black12,
              blurRadius: 10.0,
              spreadRadius: 0.2,
              offset: Offset(0, 3),
            ),
            assetimage: 'assets/images/ejercicio.png',

            
            ontap: () {},
          ),
          
        );
  }
}
    
