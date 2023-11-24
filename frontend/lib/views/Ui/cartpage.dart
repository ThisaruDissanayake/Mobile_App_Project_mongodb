import 'package:flutter/material.dart';
import 'package:frontend/views/shared/appstyle.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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