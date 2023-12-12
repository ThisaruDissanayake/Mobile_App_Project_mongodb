// ignore_for_file: file_names

// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/controllers/product_provider.dart';
import 'package:frontend/models/sneaker_models.dart';
import 'package:frontend/views/Ui/product_by_cart.dart';
import 'package:frontend/views/Ui/product_page.dart';
import 'package:frontend/views/shared/appstyle.dart';
import 'package:frontend/views/shared/new_creams.dart';
import 'package:frontend/views/shared/product_card.dart';
import 'package:frontend/views/shared/reusable_text.dart';
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
            height: 350.h,
            
            child: FutureBuilder<List<Sneakers>>(
                future: _female,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child:CircularProgressIndicator.adaptive()) ;
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
                              productNotifier.branchers = cream.branches;
                             

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductPage(sneakers:cream)));
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
              padding:  EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  reusableText(
                    text :"Latest Products",
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
                        reusableText(
                          text :"Show All",
                          style: appstyle(
                            20,
                            Colors.black,
                            FontWeight.w500,
                          ),
                        ),
                        Icon(
                          Icons.arrow_right,
                          size: 50.h,
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
            height: 99.h,
            child: FutureBuilder<List<Sneakers>>(
                future: _female,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child:CircularProgressIndicator.adaptive());
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
                            padding:  EdgeInsets.all(8.0.h),
                            child: NewCreams(
                              onTap:(){
                                productNotifier.branchers=cream.branches;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=> ProductPage(sneakers: cream))
                                );
                              },
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
