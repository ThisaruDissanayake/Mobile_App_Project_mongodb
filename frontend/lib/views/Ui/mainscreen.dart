import 'package:flutter/material.dart';
import 'package:frontend/controllers/mainscreen_provider.dart';
import 'package:frontend/views/Ui/cart.dart';
// import 'package:frontend/views/Ui/cartpage.dart';
//import 'package:frontend/views/Ui/cart.dart';
import 'package:frontend/views/Ui/favorites.dart';
import 'package:frontend/views/Ui/homepage.dart';
import 'package:frontend/views/Ui/profile.dart';
import 'package:frontend/views/Ui/searchpage.dart';
import 'package:frontend/views/shared/bottom_nav.dart';
import 'package:provider/provider.dart';
// import 'package:frontend/views/Ui/auth_controller.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  List<Widget> pageList = [
    const HomePage(),
    const SearchPage(),
    Favorites(),
    const CartPage(),
    const ProfilePage(),
  ];
  static const String rountName = "/mainscrren";
  @override
  Widget build(BuildContext context) {
    //int pageIndex = 3;
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return MaterialApp(
          home: Scaffold(
            backgroundColor: const Color.fromARGB(250, 250, 210, 239),
            body: pageList[mainScreenNotifier.pageIndex],
            bottomNavigationBar: const BottomNavBar(),
            //body: pageList[pageIndex],
          ),
        );
      },
    );
  }
}
