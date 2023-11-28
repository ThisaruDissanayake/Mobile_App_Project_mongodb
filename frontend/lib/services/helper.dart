import 'package:flutter/services.dart' as the_bundle;
import 'package:frontend/models/sneaker_models.dart';

class Helper {
//Women
  Future<List<Sneakers>> getFemaleSneakers() async {
    final data = await the_bundle.rootBundle
        .loadString("assets/json/women_products.json");
    final femaleList = sneakersFromJson(data);

    return femaleList;
  }

  //Men

  Future<List<Sneakers>> getMaleSneakers() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/men_products.json");
    final maleList = sneakersFromJson(data);

    return maleList;
  }

//Kids
  Future<List<Sneakers>> getKidSneakers() async {
    final data = await the_bundle.rootBundle
        .loadString("assets/json/kids_products.json");
    final kidsList = sneakersFromJson(data);

    return kidsList;
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
    final data = await the_bundle.rootBundle
        .loadString("assets/json/men_products.json");
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
