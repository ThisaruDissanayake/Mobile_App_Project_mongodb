import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/controllers/product_provider.dart';
import 'package:frontend/controllers/favorites_notifier.dart';
import 'package:frontend/models/sneaker_models.dart';
// import 'package:frontend/services/helper.dart';
import 'package:frontend/views/shared/appstyle.dart';
import 'package:frontend/views/Ui/favorites.dart';
import 'package:frontend/views/Ui/homepage.dart';
import 'package:frontend/views/shared/cheakout_btn.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key,  required this.sneakers});

  // final String id;
  // final String category;
  final Sneakers sneakers;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();
  final _cartBox = Hive.box('cart_box');
  // final _favBox = Hive.box('fav_box');

  Future<void> _createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

  // Future<void> _createFav(Map<String, dynamic> addFav) async {
  //   await _favBox.add(addFav);
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
  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getCreams();
  // }

  @override
  Widget build(BuildContext context) {
    // var productNotifier = Provider.of<ProductNotifier>(context);
    // productNotifier.getCreams(widget.category, widget.id);
    var favoritesNotifer =
        Provider.of<FavoritesNotifier>(context, listen: true);
    favoritesNotifer.getFavorites();
    return MaterialApp(
      home: Scaffold(
        
          body: Consumer<ProductNotifier>(

            
                      builder: (context, productNotifier, child) {
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                            automaticallyImplyLeading: false,
                            leadingWidth: 0,
                            title: Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage()), // Corrected here
                                      );
                                      productNotifier.branchers.clear();
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.black,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: null,
                                    child: const Icon(
                                      Icons.more_horiz,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            pinned: true,
                            snap: false,
                            floating: true,
                            backgroundColor: Colors.transparent,
                            expandedHeight: MediaQuery.of(context).size.height,
                            flexibleSpace: FlexibleSpaceBar(
                                background: Stack(
                              children: [
                                SizedBox(
                                  height: 406.h,
                                  width: 378.w,
                                  child: PageView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget.sneakers.imageUrl.length,
                                      controller: pageController,
                                      onPageChanged: (page) {
                                        productNotifier.activePage = page;
                                      },
                                      itemBuilder: (context, int index) {
                                        return Stack(
                                          children: [
                                            Container(
                                              height: 316.h,
                                              width: 378.w,
                                              color: Colors.grey.shade300,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    widget.sneakers.imageUrl[index],
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Positioned(
                                                right: 20,
                                                top: 100,
                                                child:
                                                    Consumer<FavoritesNotifier>(
                                                        builder: (context,
                                                            favoritesNotifier,
                                                            child) {
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      if (favoritesNotifier.ids
                                                          .contains(
                                                              widget.sneakers.id)) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const Favorites()));
                                                      } else {
                                                        favoritesNotifer
                                                            .createFav({
                                                          "id": widget.sneakers.id,
                                                          "name": widget.sneakers.name,
                                                          "category":
                                                              widget.sneakers.category,
                                                          "price":
                                                              widget.sneakers.price,
                                                          "imageUrl": widget.sneakers                                                              .imageUrl[0],
                                                        });
                                                      }
                                                      setState(() {});
                                                    },
                                                    child: favoritesNotifier.ids
                                                            .contains(
                                                                widget.sneakers.id)
                                                        ? const Icon(
                                                            Icons.favorite)
                                                        : const Icon(Icons
                                                            .favorite_border),
                                                  );
                                                })),
                                            Positioned(
                                                bottom: 0,
                                                right: 0,
                                                left: 0,
                                                height: 244.h,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children:
                                                      List<Widget>.generate(
                                                          widget.sneakers                                                              .imageUrl.length,
                                                          (index) => Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        4),
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 5,
                                                                  backgroundColor: productNotifier
                                                                              .activepage !=
                                                                          index
                                                                      ? Colors
                                                                          .grey
                                                                      : Colors
                                                                          .black,
                                                                ),
                                                              )),
                                                )),
                                          ],
                                        );
                                      }),
                                ),
                                Positioned(
                                    bottom: 30,
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                        ),
                                        child: Container(
                                          height: 600.h,
                                          width: 378.w,
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  widget.sneakers.name,
                                                  style: appstyle(
                                                      40,
                                                      Colors.black,
                                                      FontWeight.bold),
                                                ),
                                                Column(
                                                  children: [
                                                    Text(widget.sneakers.category,
                                                        style: appstyle(
                                                            20,
                                                            Colors.grey,
                                                            FontWeight.w500)),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    RatingBar.builder(
                                                      initialRating: 4,
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: 16,
                                                      itemPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 2),
                                                      itemBuilder:
                                                          (context, _) =>
                                                              const Icon(
                                                        Icons.star,
                                                        size: 20,
                                                        color: Colors.black,
                                                      ),
                                                      onRatingUpdate:
                                                          (rating) {},
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "LKR ${widget.sneakers.price}",
                                                      style: appstyle(
                                                          26,
                                                          Colors.black,
                                                          FontWeight.w600),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Colors",
                                                          style: appstyle(
                                                              18,
                                                              Colors.black,
                                                              FontWeight.w400),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        const CircleAvatar(
                                                          radius: 7,
                                                          backgroundColor:
                                                              Colors.black,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        const CircleAvatar(
                                                          radius: 7,
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  217,
                                                                  8,
                                                                  8),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        // Text(
                                                        //   "Selcted Branch",
                                                        //   style: appstyle(
                                                        //       20,
                                                        //       Colors.black,
                                                        //       FontWeight.w600),
                                                        // ),

                                                        Text(
                                                          "Nearset Branchers",
                                                          style: appstyle(
                                                              20,
                                                              Colors.grey,
                                                              FontWeight.w600),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    SizedBox(
                                                      height: 40,
                                                      child: ListView.builder(
                                                          itemCount:
                                                              productNotifier
                                                                  .branchers
                                                                  .length,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          padding:
                                                              EdgeInsets.zero,
                                                          itemBuilder:
                                                              (context, index) {
                                                            final branches =
                                                                productNotifier
                                                                        .branchers[
                                                                    index];

                                                            return Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                                child:
                                                                    ChoiceChip(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              60),
                                                                      side: const BorderSide(
                                                                          color: Colors
                                                                              .black,
                                                                          style: BorderStyle
                                                                              .solid,
                                                                          width:
                                                                              1)),
                                                                  disabledColor:
                                                                      Colors
                                                                          .white,
                                                                  label: Text(
                                                                    branches[
                                                                        'branch'],
                                                                    style: appstyle(
                                                                        18,
                                                                        branches['isSelected']
                                                                            ? Colors
                                                                                .white
                                                                            : Colors
                                                                                .black,
                                                                        FontWeight
                                                                            .w500),
                                                                  ),
                                                                  selectedColor:
                                                                      Colors
                                                                          .black,
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          8),
                                                                  selected:
                                                                      branches[
                                                                          'isSelected'],
                                                                  onSelected:
                                                                      (newState) {
                                                                    if (productNotifier
                                                                        .branches
                                                                        .contains(
                                                                            branches["branch"])) {
                                                                      productNotifier
                                                                          .branches
                                                                          .remove(
                                                                              branches['branch']);
                                                                    } else {
                                                                      productNotifier
                                                                          .branches
                                                                          .add(branches[
                                                                              'branch']);
                                                                    }
                                                                    // print(productNotifier
                                                                    //     .branch);

                                                                    productNotifier
                                                                        .toggleCheck(
                                                                            index);
                                                                  },
                                                                ));
                                                          }),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Divider(
                                                  indent: 20,
                                                  endIndent: 20,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(
                                                  width: 303.w,
                                                  child: Text(
                                                    widget.sneakers.brand,
                                                    style: appstyle(
                                                        20,
                                                        Colors.black,
                                                        FontWeight.w700),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  widget.sneakers.description,
                                                  textAlign: TextAlign.justify,
                                                  maxLines: 20,
                                                  style: appstyle(
                                                      14,
                                                      Colors.black,
                                                      FontWeight.normal),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: CheackoutButton(
                                                      onTap: () async {
                                                        _createCart({
                                                          "id": widget.sneakers.id,
                                                          "name": widget.sneakers.name,
                                                          "category":
                                                              widget.sneakers.category,
                                                          "branches":
                                                              productNotifier
                                                                  .branches,
                                                          "imageUrl": widget.sneakers                                                              .imageUrl[0],
                                                          "price":
                                                              widget.sneakers.price,
                                                          "qty": 1
                                                        });

                                                        productNotifier.branches
                                                            .clear();
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const HomePage()));
                                                      },
                                                      label: ' Add to Bag ',
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )))
                              ],
                            )))
                      ],
                    );
                  })
                ),
    );
  }
}
