// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:frontend/views/shared/appstyle.dart';
import 'package:frontend/views/shared/bottom_nav_widget.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        
        bottomNavigationBar: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BotomNavwidget(onTap: () {}, icon: Icons.home),
                BotomNavwidget(onTap: () {}, icon: Icons.search),
                BotomNavwidget(onTap: () {}, icon: Icons.add_box),
                BotomNavwidget(onTap: () {}, icon: Icons.shopping_cart),
                BotomNavwidget(onTap: () {}, icon: Icons.person),
              ],
            ),
          ),
        )),
      ),
      
    );
  }
}
