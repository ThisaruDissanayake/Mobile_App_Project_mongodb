// ignore: duplicate_ignore
// ignore_for_file: unused_field, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/controllers/product_provider.dart';
import 'package:frontend/models/sneaker_models.dart';
import 'package:frontend/services/helper.dart';
import 'package:frontend/views/shared/HomeWidge.dart';
import 'package:frontend/views/shared/appstyle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:frontend/views/shared/new_creams.dart';
import 'package:frontend/views/shared/product_card.dart';
import 'package:frontend/views/shared/reusable_text.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_antd_icons/flutter_antd_icons.dart';

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
    var productNotifier = Provider.of<ProductNotifier>(context);
    productNotifier.getFemale();
    productNotifier.getMale();
    productNotifier.getKids();

    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 249, 223, 237),
        body: SizedBox(
          height: 820.h,
          width: 378.w,
          child: Stack(
            children: [
              Container(
                padding:  EdgeInsets.fromLTRB(16.w, 45.h, 0, 0),
                height: 375.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/t.jpg"),
                      fit: BoxFit.cover),
                ),
                child: Container(
                  padding:  EdgeInsets.only(left: 2.w, bottom: 15.h),
                  width: 378.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusableText(
                        text : "Buty Products",
                        style: appstyleWithHt(
                            36, const Color.fromARGB(255, 188, 3, 142), FontWeight.bold, 1.5),
                      ),
                      reusableText(
                        text : "Collection",
                        style: appstyleWithHt(
                            38, const Color.fromARGB(255, 188, 3, 142), FontWeight.bold, 1.2),
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
                    top:203.h),
                child: Container(
                  padding:  EdgeInsets.only(left: 12.w),
                  child: TabBarView(controller: _tabController, children: [
                    HomeWidge(
                      female: productNotifier.female,
                      tabIndex: 0,
                    ),
                    HomeWidge(
                      female: productNotifier.male,
                      tabIndex: 1,
                    ),
                    HomeWidge(
                      female: productNotifier.kids,
                      tabIndex: 2,
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
