import 'package:fitapp_flutter/models/diet/diet_response.dart';
import 'package:flutter/material.dart';

class DietScreen extends StatefulWidget {
  const DietScreen({ Key? key }) : super(key: key);

  @override
  State<DietScreen> createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
   @override
  Widget build(BuildContext context) {
        final args = ModalRoute.of(context)!.settings.arguments as Diet;
        final bottomContentText = Text(
      args.ingredient,
      style: TextStyle(fontSize: 18.0),
    );
     final bottomContentText2 =            Divider(
                            color: Colors.grey[800],
                            thickness: 2.0,
                          );

     final bottomContentText3 = Text(
      " - Calorías: "+args.calories,
      style: TextStyle(fontSize: 11.0),
    );
  


    
    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText,bottomContentText2, bottomContentText3],
        ),
      ),
    );
         final levelIndicator = Container(
  
    );

    final coursePrice = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: new Text(
       
        "\$" + args.calories.toString(),
        style: TextStyle(color: Colors.white),
      ),
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
                        args.imagen,),),
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

