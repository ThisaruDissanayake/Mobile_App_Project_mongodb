// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:frontend/controllers/mainscreen_provider.dart';
import 'package:frontend/controllers/product_provider.dart';
import 'package:frontend/views/Ui/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('cart_box');
 await Hive.openBox('fav_box');

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
    ChangeNotifierProvider(create: (context) => ProductNotifier()),
  ], child: const MyApp()));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'dbestech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}
