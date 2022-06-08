import 'dart:convert';

import 'package:fitapp_flutter/models/diet/diet_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DietListScreen extends StatefulWidget {
  const DietListScreen({ Key? key }) : super(key: key);

  @override
  State<DietListScreen> createState() => _DietListScreenState();
}

class _DietListScreenState extends State<DietListScreen> {

    late Future<List<Diet>> items;

  @override
  void initState() {
    items = fetchDiet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white24 ,
      appBar: AppBar(
        title: const Text('FIT APP'),
        backgroundColor: Colors.red,
      
      ),

      
   body: Column(
       
       children: [
         
         Stack(
  children: <Widget>[
    
    
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text( 
        'PLATOS RECOMENDADOS',
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
      padding: const EdgeInsets.all(20.0),
      child: Text(
    'PLATOS RECOMENDADOS',
        style: TextStyle(
          fontSize: 20,
          color: Colors.red[100],
        ),
      ),
    ),
  ],
),
           SizedBox(
             
              height: MediaQuery.of(context).size.height * 0.45,
              child: FutureBuilder<List<Diet>>(
                future: items,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _dietList(snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              )),
           Container(
             
             alignment: Alignment.center,
             padding: EdgeInsets.all(0),
             child:ElevatedButton(
               
            child: Text('CREAR PLATO'),
            onPressed: () {
                   Navigator.pushNamed(context, '/createDiet');
                   
               },
            style: ElevatedButton.styleFrom(
                
                primary: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold)),
               
            
           )
        
        
     ,
),
     ]
     ),
  );
  }
Future<List<Diet>> fetchDiet() async {
    final response = await http.get(Uri.parse(
        'https://fit-app-heroku.herokuapp.com/diet/list'));
    if (response.statusCode == 200) {
      return DietResponse.fromJson(jsonDecode(response.body)).content;
    } else {
      throw Exception('Failed to load the diets');
    }
  }

  Widget _dietList(List<Diet> dietList) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dietList.length,
        itemBuilder: (context, index) {
          return _dietItem(dietList.elementAt(index), index);
        },
      ),
    );
  }

  Widget _dietItem(Diet diet, int index) {
    return Card(
      margin: const EdgeInsets.fromLTRB(5, 15, 5, 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () =>
            Navigator.pushNamed(context, '/diet', arguments: diet),
        child: SizedBox(
            width: 200,
            height: 200,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.network(
                  diet.imagen + diet.ingredient,
                  width: MediaQuery.of(context).size.width * 0.4),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(diet.title.toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
            ])),
      ),
    );
  }
}

    