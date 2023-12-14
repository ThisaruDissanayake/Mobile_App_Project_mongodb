import 'package:frontend/models/UserModel.dart';
import 'package:frontend/screens/authentication/authenticate.dart';
import 'package:frontend/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:frontend/views/Ui/mainscreen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return MainScreen();
    }
  }
}
