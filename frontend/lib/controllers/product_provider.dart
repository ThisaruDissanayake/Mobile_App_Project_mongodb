import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier {
  int _activepage = 0;
  List<dynamic> _branchers = [];
  int get activepage => _activepage;

  set activePage(int newIndex) {
    _activepage = newIndex;
    notifyListeners();
  }

  List<dynamic> get branchers => _branchers;
  set branchers(List<dynamic> newBranch) {
    _branchers = newBranch;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for (int i = 0; i < _branchers.length; i++) {
      if (i == index) {
        _branchers[i]['isSelected'] = !_branchers[i]['isSelected'];
      }
    }
  }
}
