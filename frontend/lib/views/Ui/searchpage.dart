import 'package:flutter/material.dart';
import 'package:frontend/views/shared/appstyle.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 249, 223, 237),
        body:Center(
          child: Text("This is search", style: appstyle(40, Colors.black, FontWeight.bold),),
        ),
      )
      );
  }
}