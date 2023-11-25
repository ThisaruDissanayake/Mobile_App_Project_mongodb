// ignore: duplicate_ignore
// ignore_for_file: unused_field, unused_import

import 'package:flutter/material.dart';
import 'package:frontend/models/sneaker_models.dart';
import 'package:frontend/services/helper.dart';
import 'package:frontend/views/shared/appstyle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:frontend/views/shared/new_creams.dart';
import 'package:frontend/views/shared/product_card.dart';
//import 'package:flutter_antd_icons/flutter_antd_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  late Future<List<Sneakers>> _male;
  late Future<List<Sneakers>> _female;
  late Future<List<Sneakers>> _kids;

  void getMale() {
    _male = Helper().getMaleSneakers();
  }

  void getFemale() {
    _female = Helper().getFemaleSneakers();
  }

  void getKids() {
    _kids = Helper().getKidSneakers();
  }

  @override
  void initState() {
    super.initState();
    getMale();
    getFemale();
    getKids();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/t.jpg"),
                      fit: BoxFit.fill),
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 8, bottom: 15),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Skin Care Products",
                        style: appstyleWithHt(
                            38, Colors.white, FontWeight.bold, 1.5),
                      ),
                      Text(
                        "Collection",
                        style: appstyleWithHt(
                            38, Colors.white, FontWeight.bold, 1.2),
                      ),
                      TabBar(
                          padding: EdgeInsets.zero,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.transparent,
                          controller: _tabController,
                          isScrollable: true,
                          labelColor: Colors.white,
                          labelStyle:
                              appstyle(24, Colors.white, FontWeight.bold),
                          unselectedLabelColor: Colors.grey.withOpacity(0.3),
                          tabs: const [
                            Tab(
                              text: "Women Products",
                            ),
                            Tab(
                              text: "Men Products",
                            ),
                            Tab(
                              text: "Kids Products",
                            )
                          ]),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.265),
                child: Container(
                  padding: const EdgeInsets.only(left: 12),
                  child: TabBarView(controller: _tabController, children: [
                    Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.405,
                            child: FutureBuilder<List<Sneakers>>(
                                future: _female,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
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
                                          return ProductCard(
                                            price: cream.price,
                                            category: cream.category,
                                            id: cream.id,
                                            name: cream.name,
                                            image: cream.imageUrl[0],
                                          );
                                        });
                                  }
                                })),
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(12, 20, 12, 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Latest Products",
                                    style: appstyle(
                                      24,
                                      Colors.black,
                                      FontWeight.bold,
                                    ),
                                  ),
                                  Row(
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
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
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
                    ),

                     

                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.405,
                          color: Colors.green,
                          
                        )
                      ],
                    ),


                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
