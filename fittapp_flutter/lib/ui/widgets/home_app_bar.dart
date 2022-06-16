import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: const EdgeInsets.only(top: 10),
      child:  Padding(
        padding: const EdgeInsets.all(80.0),
        child: Image.asset(
                'assets/images/banner.png',
                height: 40,
              ),
      ),
      );
  }


 @override
  Size get preferredSize => const Size.fromHeight(60);
}