import 'package:flutter/material.dart';
import 'package:frontend/models/constants.dart';
import 'package:frontend/views/Ui/favorites.dart';
import 'package:frontend/views/shared/appstyle.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: unused_import
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key,
      required this.price,
      required this.category,
      required this.id,
      required this.name,
      required this.image});

  final String price;
  final String category;
  final String id;
  final String name;
  final String image;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final _favBox = Hive.box("fav_box");

  Future<void> _createFav(Map<String, dynamic> addFav) async {
    await _favBox.add(addFav);
    getFavorites();
  }

  getFavorites() {
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);

      return {
        "key": key,
        "id": item["id"],
      };
    }).toList();

    favor = favData.toList();
    ids = favor.map((item) => item['id']).toList();
    setState(() {
      
    });
  }

  bool selected = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.65,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1, 1))
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.image),
                        
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: GestureDetector(
                      onTap: () async {
                        if (ids.contains(widget.id)) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Favorites()));
                        } else {
                          _createFav({
                            "id": widget.id,
                            "name": widget.name,
                            "category": widget.category,
                            "price": widget.price,
                            "imageUrl": widget.image,
                          });
                        }
                      },
                      child: ids.contains(widget.id)
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: appstyleWithHt(
                          36, Colors.black, FontWeight.bold, 1.1),
                    ),
                    Text(
                      widget.category,
                      style:
                          appstyleWithHt(18, Colors.grey, FontWeight.bold, 1.5),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.price,
                        style: appstyle(20, Colors.black, FontWeight.w700),
                      ),
                      Row(
                        children: [
                          Text(
                            "Colors",
                            style: appstyle(18, Colors.grey, FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          ChoiceChip(
                            label: const Text(""),
                            selected: selected,
                            visualDensity: VisualDensity.compact,
                            selectedColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  50.0), // Adjust the radius as needed
                            ),
                          )
                        ],
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
