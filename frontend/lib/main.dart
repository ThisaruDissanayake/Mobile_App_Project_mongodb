// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/controllers/cart_provider.dart';
import 'package:frontend/controllers/favorites_notifier.dart';
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
     ChangeNotifierProvider(create: (context) => FavoritesNotifier()),
     ChangeNotifierProvider(create: (context) => CartProvider()),
     
  ], child: const MyApp()));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
designSize:  const Size (378 , 820),
minTextAdapt: true,
splitScreenMode: true,
builder: (context, child){
return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'dbestech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );


}


);
  }
}
