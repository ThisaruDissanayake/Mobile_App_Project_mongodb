import 'package:flutter/material.dart';
import 'package:frontend/models/sneaker_models.dart';
import 'package:frontend/services/helper.dart';

class ProductNotifier extends ChangeNotifier {
  int _activepage = 0;
  List<dynamic> _branchers = [];
  List<String> _branche = [];

  

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
    notifyListeners();
  }

  List<String> get branch => _branche;

  set branch(List<String> newBranch1) {
    _branche = newBranch1;
    notifyListeners();
  }

  late Future<List<Sneakers>> male;
  late Future<List<Sneakers>> female;
  late Future<List<Sneakers>> kids;

  late Future<Sneakers> sneaker;

  void getMale() {
    male = Helper().getMaleSneakers();
  }

  void getFemale() {
    female = Helper().getFemaleSneakers();
  }

  void getKids() {
    kids = Helper().getKidSneakers();
  }

  

  void getCreams(String category,String id) {
    if (category == "women's hair care product" ||
        category == "women's skin care product" ||
        category == "women's makeup product") {
      sneaker = Helper().getFemaleSneakersById(id);
    } else if (category == "Men's hair care product" ||
        category == "Men's skin care product" ||
        category == "Men's makeup product") {
      sneaker = Helper().getMaleSneakersById(id);
    } else {
      sneaker = Helper().getKidSneakersById(id);
    }
  }
}
