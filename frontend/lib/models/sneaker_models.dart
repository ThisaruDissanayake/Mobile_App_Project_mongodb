
// import 'dart:convert';

// List<Sneakers> sneakersFromJson(String str) => List<Sneakers>.from(json.decode(str).map((x) => Sneakers.fromJson(x)));

// //String sneakersToJson(List<Sneakers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Sneakers {
//     final String id;
//     final String name;
//     final String category;
//     final List<String> imageUrl;
//     final List<dynamic> branch;
//     final String oldPrice;
//     final String price;
//     final String description;
//     final String brand;

//     Sneakers({
//         required this.id,
//         required this.name,
//         required this.category,
//         required this.imageUrl,
//         required this.branch,
//         required this.oldPrice,
//         required this.price,
//         required this.description,
//         required this.brand,
//     });

//     factory Sneakers.fromJson(Map<String, dynamic> json) => Sneakers(
//         id: json["id"],
//         name: json["name"],
//         category: json["category"],
//         imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
//         branch: List<dynamic>.from(json["branch"].map((x) => x)),
//         oldPrice: json["oldPrice"],
//         price: json["price"],
//         description: json["description"],
//         brand: json["brand"],
//     );

    
// }

import 'dart:convert';

List<Sneakers> sneakersFromJson(String str) => List<Sneakers>.from(json.decode(str).map((x) => Sneakers.fromJson(x)));

String sneakersToJson(List<Sneakers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sneakers {
    final String id;
    final String name;
    final String brand;
    final String category;
    final List<String> imageUrl;
    final String oldPrice;
    final List<dynamic> branches;
    final String price;
    final String description;

    Sneakers({
        required this.id,
        required this.name,
        required this.brand,
        required this.category,
        required this.imageUrl,
        required this.oldPrice,
        required this.branches,
        required this.price,
        required this.description,
    });

    factory Sneakers.fromJson(Map<String, dynamic> json) => Sneakers(
        id: json["_id"],
        name: json["name"],
        brand: json["brand"],
        category: json["category"],
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        oldPrice: json["oldPrice"],
        branches: List<dynamic>.from(json["branches"].map((x) => x)),
        price: json["price"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "brand": brand,
        "category": category,
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
        "oldPrice": oldPrice,
        "branches": List<String>.from(branches.map((x) => x.toJson())),
        "price": price,
        "description": description,
    };
}

class Branch {
    final String branch;
    final bool isSelected;
    final String id;

    Branch({
        required this.branch,
        required this.isSelected,
        required this.id,
    });

    factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        branch: json["branch"]  ,
        isSelected: json["isSelected"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "branch": branch,
        "isSelected": isSelected,
        "_id": id,
    };
}
