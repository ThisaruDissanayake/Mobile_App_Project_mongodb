import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/constants.dart';
import 'package:frontend/controllers/product_provider.dart';
import 'package:frontend/controllers/favorites_notifier.dart';
import 'package:frontend/models/sneaker_models.dart';
import 'package:frontend/services/helper.dart';
import 'package:frontend/views/shared/appstyle.dart';
import 'package:frontend/views/Ui/favorites.dart';
import 'package:frontend/views/Ui/homepage.dart';
import 'package:frontend/views/shared/cheakout_btn.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});

  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();
  final _cartBox = Hive.box('cart_box');
  final _favBox = Hive.box('fav_box');

  late Future<Sneakers> _sneaker;

  void getCreams() {
    if (widget.category == "women's hair care product" ||
        widget.category == "women's skin care product" ||
        widget.category == "women's makeup product") {
      _sneaker = Helper().getFemaleSneakersById(widget.id);
    } else if (widget.category == "Men's hair care product" ||
        widget.category == "Men's skin care product" ||
        widget.category == "Men's makeup product") {
      _sneaker = Helper().getMaleSneakersById(widget.id);
    } else {
      _sneaker = Helper().getKidSneakersById(widget.id);
    }
  }

  Future<void> _createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

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
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCreams();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: FutureBuilder<Sneakers>(
              future: _sneaker,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                } else {
                  final sneaker = snapshot.data;

                  return Consumer<ProductNotifier>(
                      builder: (context, productNotifier, child) {
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                            automaticallyImplyLeading: false,
                            leadingWidth: 0,
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  width: MediaQuery.of(context).size.width,
                                  child: PageView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: sneaker!.imageUrl.length,
                                      controller: pageController,
                                      onPageChanged: (page) {
                                        productNotifier.activePage = page;
                                      },
                                      itemBuilder: (context, int index) {
                                        return Stack(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.39,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color: Colors.grey.shade300,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    sneaker.imageUrl[index],
                                                
                                              ),
                                            ),
                                            Positioned(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
                                                right: 10,
                                                child:
                                                    Consumer<FavoritesNotifier>(
                                                  builder: (context,
                                                      favoritesNotifier,
                                                      child) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        if (ids.contains(
                                                            widget.id)) {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                         const Favorites()));
                                                        } else {
                                                          _createFav({
                                                            "id": sneaker.id,
                                                            "name": sneaker.name,
                                                            "category": sneaker.category,
                                                            "price": sneaker.price,
                                                            "imageUrl": sneaker.imageUrl[0],
                                                          });
                                                        }
                                                      },
                                                      child: ids.contains(
                                                              sneaker.id)
                                                          ? const Icon(
                                                              Icons.favorite)
                                                          : const Icon(Icons
                                                              .favorite_border),
                                                    );
                                                  },
                                                )),
                                            Positioned(
                                                bottom: 0,
                                                right: 0,
                                                left: 0,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.3,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children:
                                                      List<Widget>.generate(
                                                          sneaker
                                                              .imageUrl.length,
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.645,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  sneaker.name,
                                                  style: appstyle(
                                                      40,
                                                      Colors.black,
                                                      FontWeight.bold),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(sneaker.category,
                                                        style: appstyle(
                                                            20,
                                                            Colors.grey,
                                                            FontWeight.w500)),
                                                    const SizedBox(
                                                      width: 20,
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
                                                              horizontal: 1),
                                                      itemBuilder:
                                                          (context, _) =>
                                                              const Icon(
                                                        Icons.star,
                                                        size: 18,
                                                        color: Colors.black,
                                                      ),
                                                      onRatingUpdate:
                                                          (rating) {},
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "LKR ${sneaker.price}",
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
                                                        Text(
                                                          "Selcted Branch",
                                                          style: appstyle(
                                                              20,
                                                              Colors.black,
                                                              FontWeight.w600),
                                                        ),
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        Text(
                                                          "Nearset Branchers",
                                                          style: appstyle(
                                                              10,
                                                              Colors.grey,
                                                              FontWeight.w500),
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
                                                            final branch =
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
                                                                    branch[
                                                                        'branch'],
                                                                    style: appstyle(
                                                                        18,
                                                                        branch['isSelected']
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
                                                                  selected: branch[
                                                                      'isSelected'],
                                                                  onSelected:
                                                                      (newState) {
                                                                    if (productNotifier
                                                                        .branch
                                                                        .contains(
                                                                            branch["branch"])) {
                                                                      productNotifier
                                                                          .branch
                                                                          .remove(
                                                                              branch['branch']);
                                                                    } else {
                                                                      productNotifier
                                                                          .branch
                                                                          .add(branch[
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
                                                  indent: 10,
                                                  endIndent: 10,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.8,
                                                  child: Text(
                                                    sneaker.brand,
                                                    style: appstyle(
                                                        20,
                                                        Colors.black,
                                                        FontWeight.w700),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  sneaker.description,
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
                                                            top: 12),
                                                    child: CheackoutButton(
                                                      onTap: () async {
                                                        _createCart({
                                                          "id": sneaker.id,
                                                          "name": sneaker.name,
                                                          "category":
                                                              sneaker.category,
                                                          "branch":
                                                              productNotifier
                                                                  .branch,
                                                          "imageUrl": sneaker
                                                              .imageUrl[0],
                                                          "price":
                                                              sneaker.price,
                                                          "qty": 1
                                                        });

                                                        productNotifier.branch
                                                            .clear();
                                                        Navigator.pop(context);
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
                  });
                }
              })),
    );
  }
}
