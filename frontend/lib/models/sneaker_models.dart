
import 'dart:convert';

List<Sneakers> sneakersFromJson(String str) => List<Sneakers>.from(json.decode(str).map((x) => Sneakers.fromJson(x)));

//String sneakersToJson(List<Sneakers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sneakers {
    final String id;
    final String name;
    final String category;
    final List<String> imageUrl;
    final List<dynamic> branch;
    final String oldPrice;
    final String price;
    final String description;
    final String brand;

    Sneakers({
        required this.id,
        required this.name,
        required this.category,
        required this.imageUrl,
        required this.branch,
        required this.oldPrice,
        required this.price,
        required this.description,
        required this.brand,
    });

    factory Sneakers.fromJson(Map<String, dynamic> json) => Sneakers(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        branch: List<dynamic>.from(json["branch"].map((x) => x)),
        oldPrice: json["oldPrice"],
        price: json["price"],
        description: json["description"],
        brand: json["brand"],
    );

    
}

