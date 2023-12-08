import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/views/Ui/favorites.dart';
// import 'package:frontend/models/constants.dart';
// import 'package:frontend/views/Ui/favorites.dart';
import 'package:frontend/views/shared/appstyle.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:frontend/controllers/favorites_notifier.dart';
import 'package:frontend/views/shared/reusable_text.dart';
// ignore: unused_import
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

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
  // final _favBox = Hive.box("fav_box");

  // Future<void> _createFav(Map<String, dynamic> addFav) async {
  //   await _favBox.add(addFav);
  //   getFavorites();
  // }

  // getFavorites() {
  //   final favData = _favBox.keys.map((key) {
  //     final item = _favBox.get(key);

  //     return {
  //       "key": key,
  //       "id": item["id"],
  //     };
  //   }).toList();

  //   favor = favData.toList();
  //   ids = favor.map((item) => item['id']).toList();
  //   setState(() {

  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var favoritesNotifer =
        Provider.of<FavoritesNotifier>(context, listen: true);
    favoritesNotifer.getFavorites();
    bool selected = true;
    return Padding(
      padding:  EdgeInsets.fromLTRB(8.w, 0, 20.w, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          height: 325.h,
          width: 250.w,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.white,
                spreadRadius: 2,
                blurRadius: 0.8,
                offset: Offset(1, 1))
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 190.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.image),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10.w,
                    top: 10.h,
                    child: GestureDetector(
                      onTap: () async {
                        if (favoritesNotifer.ids.contains(widget.id)) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Favorites()));
                        } else {
                          favoritesNotifer.createFav({
                            "id": widget.id,
                            "name": widget.name,
                            "category": widget.category,
                            "price": widget.price,
                            "imageUrl": widget.image,
                          });
                        }
                        setState(() {
                          
                        });


                      },
                      child: favoritesNotifer.ids.contains(widget.id)
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:  EdgeInsets.only(left: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                       widget.name,
                      style: appstyleWithHt(
                          30, Colors.black, FontWeight.bold, 1.1),
                    ),
                    reusableText(
                      text: widget.category,
                      style:
                          appstyleWithHt(18, Colors.grey, FontWeight.bold, 1.5),
                    )
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 4.w, right: 4.w),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      reusableText(
                        text :widget.price,
                        style: appstyle(20, Colors.black, FontWeight.w700),
                      ),
                      Row(
                        children: [
                          reusableText(
                            text : "Colors",
                            style: appstyle(18, Colors.grey, FontWeight.w500),
                          ),
                           SizedBox(
                            width: 3.w,
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
