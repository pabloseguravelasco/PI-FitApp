import 'package:fitapp_flutter/ui/screens/diet_list_screen.dart';
import 'package:fitapp_flutter/ui/screens/exercise_list_screen.dart';
import 'package:fitapp_flutter/ui/screens/home_screen.dart';
import 'package:fitapp_flutter/ui/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const DietListScreen(),
    const ProfileScreen(),
    const ExerciseListScreen(),


  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
        body: pages[_currentIndex], bottomNavigationBar: _buildBottomBar());
  }

  Widget _buildBottomBar() {
    return Container(
      
      
        decoration: BoxDecoration(
          
            border: const Border(
              
          top: BorderSide(
            color: Color(0xfff1f1f1),
            width: 1.0,
            
          ),
          
        )),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
     
        height: 70,
        
        child: Row(
          
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: Icon(Icons.home,
                  color: _currentIndex == 0
                      ? Colors.red
                      : const Color(0xff000000)),
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            GestureDetector(
              child: Icon(Icons.food_bank_outlined,
                  color: _currentIndex == 1
                      ? Colors.red
                      : const Color(0xff000000)),
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
           GestureDetector(
              child: Icon(Icons.person,
                  color: _currentIndex == 2
                      ? Colors.red
                      : const Color(0xff000000)),
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
            GestureDetector(
              child: Icon(Icons.miscellaneous_services,
                  color: _currentIndex == 3
                      ? Colors.red
                      : const Color(0xff000000)),
              onTap: () {
                setState(() {
                  _currentIndex = 3;
                });
              },
            ),
          ],
        ));
  }
}
