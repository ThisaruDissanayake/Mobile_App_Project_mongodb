// ignore_for_file: file_names

// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/product_provider.dart';
import 'package:frontend/models/sneaker_models.dart';
import 'package:frontend/views/Ui/product_by_cart.dart';
import 'package:frontend/views/Ui/product_page.dart';
import 'package:frontend/views/shared/appstyle.dart';
import 'package:frontend/views/shared/new_creams.dart';
import 'package:frontend/views/shared/product_card.dart';
import 'package:provider/provider.dart';

class HomeWidge extends StatelessWidget {
  const HomeWidge({
    super.key,
    required Future<List<Sneakers>> female,
    required this.tabIndex,
  }) : _female = female;

  final Future<List<Sneakers>> _female;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);

    return Column(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.43,
            width: MediaQuery.of(context).size.width * 0.9,
            child: FutureBuilder<List<Sneakers>>(
                future: _female,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error ${snapshot.error}");
                  } else {
                    final female = snapshot.data;
                    return ListView.builder(
                        itemCount: female!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final cream = snapshot.data![index];
                          return GestureDetector(
                            onTap: () {
                              productNotifier.branchers = cream.branch;
                             

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductPage(
                                          id: cream.id,
                                          category: cream.category)));
                            },
                            child: ProductCard(
                              price: "LKR ${cream.price}",
                              category: cream.category,
                              id: cream.id,
                              name: cream.name,
                              image: cream.imageUrl[0],
                            ),
                          );
                        });
                  }
                })),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Products",
                    style: appstyle(
                      24,
                      Colors.black,
                      FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductByCart(
                                    tabIndex: tabIndex,
                                  )));
                    },
                    child: Row(
                      children: [
                        Text(
                          "Show All",
                          style: appstyle(
                            22,
                            Colors.black,
                            FontWeight.bold,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_right,
                          size: 50,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.13,
            child: FutureBuilder<List<Sneakers>>(
                future: _female,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error ${snapshot.error}");
                  } else {
                    final female = snapshot.data;
                    return ListView.builder(
                        itemCount: female!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final cream = snapshot.data![index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NewCreams(
                              imageUrl: cream.imageUrl[1],
                            ),
                          );
                        });
                  }
                })),
      ],
    );
  }
}
