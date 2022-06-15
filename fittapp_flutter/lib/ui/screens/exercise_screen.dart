// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:fitapp_flutter/models/exercise/exercise_response.dart';
import 'package:fitapp_flutter/ui/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({ Key? key }) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    
        final args = ModalRoute.of(context)!.settings.arguments as Exercise;
          String imageUrl =
      args.imagen;
        final bottomContentText = Text(
      args.text,
      style: TextStyle(fontSize: 18.0),
    );
     final bottomContentText2 =            Divider(
                            color: Colors.grey[800],
                            thickness: 2.0,
                          );

     final bottomContentText3 = Text(
      " - Duración: "+args.duration,
      style: TextStyle(fontSize: 11.0),
    );
     final bottomContentText4 =   Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  child: Text('VIDEO'),
                  onPressed: () {
                    launch(args.link);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),
              ) ;
       final bottomContentText5 =  Text(
      " - Zona: " + args.zone,
      style: TextStyle(fontSize: 11.0),

    
        );
    
    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText,bottomContentText2, bottomContentText3,bottomContentText5,bottomContentText4],
        ),
      ),
    );
         final levelIndicator = Container(
  
    );

        final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 150.0),
       
      
        SizedBox(height: 10.0),
        Text(
          args.title,
          style: TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        SizedBox(height: 30.0),
     
      ],
    );
            final topContent = Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top:20),
          child: Container(
            color: Colors.black,
            width: MediaQuery.of(context).size.height ,
              height: MediaQuery.of(context).size.height * 0.5,
               child: Image.network(
                        imageUrl,),),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(0),
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.black),
          ),
        )
      ],
    );
     return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
     
      ),
    );
  }
}

