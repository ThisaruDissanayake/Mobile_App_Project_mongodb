import 'package:flutter/material.dart';
import 'package:frontend/controllers/mainscreen_provider.dart';
import 'package:frontend/views/Ui/cartpage.dart';
import 'package:frontend/views/Ui/homepage.dart';
import 'package:frontend/views/Ui/profile.dart';
import 'package:frontend/views/Ui/searchpage.dart';
import 'package:frontend/views/shared/bottom_nav.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  List<Widget> pageList = const [
    HomePage(),
    SearchPage(),
    HomePage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    //int pageIndex = 3;
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return MaterialApp(
          home: Scaffold(
            backgroundColor:  const Color.fromARGB(110, 79, 18, 63),
            body: pageList[mainScreenNotifier.pageIndex],
            bottomNavigationBar: const BottomNavBar(),
            //body: pageList[pageIndex],
          ),
        );
      },
    );
  }
}

