import 'package:flutter/material.dart';
import 'package:frontend/views/shared/appstyle.dart';

class CartPage1 extends StatefulWidget {
  const CartPage1({super.key});

  @override
  State<CartPage1> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage1> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body:Center(
          child: Text("This is Cart", style: appstyle(40, Colors.black, FontWeight.bold),),
        ),
      )
      );
  }
}