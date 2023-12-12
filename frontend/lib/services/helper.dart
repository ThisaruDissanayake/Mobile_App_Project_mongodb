//import 'dart:html';
import 'package:flutter/services.dart' as the_bundle;
import 'package:frontend/models/sneaker_models.dart';
import 'package:frontend/services/config.dart';
import 'package:http/http.dart' as http;

class Helper {
  static var client = http.Client();

//Men

  Future<List<Sneakers>> getMaleSneakers() async {
    //var url = Uri.http(Config.apiUrl, Config.sneakers);
    var url = Uri.parse('${Config.apiUrl}${Config.sneakers}');

    var response = await client.get(url);
    if (response.statusCode == 200) {
      final maleList = sneakersFromJson(response.body);
      var male = maleList
          .where((element) =>
           element.category == "Men's hair care product" ||
          element.category == "Men's skin care product" ||
           element.category == "Men's makeup product"
          
           );
      return male.toList();
    } else {
      throw Exception("Failed to get sneakers list");
    }
  }

//Women
  Future<List<Sneakers>> getFemaleSneakers() async {
    //var url = Uri.http(Config.apiUrl, Config.sneakers);
    var url = Uri.parse('${Config.apiUrl}${Config.sneakers}');

    var response = await client.get(url);
    if (response.statusCode == 200) {
      final femaleList = sneakersFromJson(response.body);
      var female = femaleList
          .where((element) => 
          element.category == "women's hair care product" ||
          element.category == "women's skin care product" ||
          element.category == "women's makeup product");
      return female.toList();
    } else {
      throw Exception("Failed to get sneakers list");
    }
  }

//Kids
  Future<List<Sneakers>> getKidSneakers() async {
      // var url = Uri.http(Config.apiUrl, Config.sneakers);
      var url = Uri.parse('${Config.apiUrl}${Config.sneakers}');

       var response = await client.get(url);
    if (response.statusCode == 200) {
      final kidsList = sneakersFromJson(response.body);
      var kids = kidsList
          .where((element) => 
          element.category == "kid's skin care product" ||
          element.category == "kid's hair care product"
          );
      return kids.toList();
    } else {
      throw Exception("Failed to get sneakers list");
    }
  }

//single Women
  Future<Sneakers> getFemaleSneakersById(String id) async {
    final data = await the_bundle.rootBundle
        .loadString("assets/json/women_products.json");
    final femaleList = sneakersFromJson(data);

    final sneaker = femaleList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }

//single Men
  Future<Sneakers> getMaleSneakersById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/men_products.json");
    final maleList = sneakersFromJson(data);

    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }

//single kid
  Future<Sneakers> getKidSneakersById(String id) async {
    final data = await the_bundle.rootBundle
        .loadString("assets/json/kids_products.json");
    final kidsList = sneakersFromJson(data);

    final sneaker = kidsList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }
}
