import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:frontend/views/shared/appstyle.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                          child: ListView.builder(
                              itemCount: 6,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    color: Colors.grey,
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width*0.6,
                                  ),
                                );
                              }),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12,20,12,20),
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
                                        Icons.keyboard_double_arrow_right_sharp,
                                        size: 20,
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
                          child: ListView.builder(
                              itemCount: 6,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration:const  BoxDecoration(  
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(Radius.circular(16))
                                    ),
                                    
                                    height: MediaQuery.of(context).size.height*0.12,
                                    width: MediaQuery.of(context).size.width*0.28,
                                    child: CachedNetworkImage(
                                      imageUrl:"https://media.gettyimages.com/id/1449656094/photo/a-red-lipstick-in-a-blue-case-uncovered-lying-on-a-white-background.jpg?s=612x612&w=0&k=20&c=9i6QZwtV5ROp-zC3K686L9DFtNnbby4BCbkX7jSZKYQ=",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              }),
                          
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.405,
                          color: Colors.green,
                        )
                      ],
                    )
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

