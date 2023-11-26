import 'package:flutter/material.dart';
import 'package:frontend/models/sneaker_models.dart';
import 'package:frontend/services/helper.dart';
import 'package:frontend/views/shared/appstyle.dart';
import 'package:frontend/views/shared/stagger_tile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductByCart extends StatefulWidget {
  const ProductByCart({super.key});

  @override
  State<ProductByCart> createState() => _ProductByCartState();
}

class _ProductByCartState extends State<ProductByCart>
    with TickerProviderStateMixin {
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
    return Scaffold(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 12, 16, 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.close, color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(Icons.filter_alt,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    TabBar(
                        padding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.transparent,
                        controller: _tabController,
                        isScrollable: true,
                        labelColor: Colors.white,
                        labelStyle: appstyle(24, Colors.white, FontWeight.bold),
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
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2,
                    left: 16,
                    right: 12),
                child: TabBarView(controller: _tabController, children: [
                  FutureBuilder<List<Sneakers>>(
                      future: _female,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text("Error ${snapshot.error}");
                        } else {
                          final female = snapshot.data;
                          

                          return StaggeredGridView.countBuilder(
                              padding: EdgeInsets.zero,
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 16,
                              itemCount: female!.length,
                              scrollDirection: Axis.vertical,
                              staggeredTileBuilder: (index) =>
                                  StaggerTile.extent(
                                      (index % 2 == 0) ? 1 : 1,
                                      (index % 4 == 1 || index % 4 == 3)
                                          ? MediaQuery.of(context).size.height *  
                                              0.35
                                          : MediaQuery.of(context).size.width *
                                              0.3),
                              itemBuilder: (context, index) {
                                final cream = snapshot.data![index];
                                return StaggerTile(
                                    imageUrl: cream.imageUrl[1],
                                    name: cream.name,
                                    price: cream.price);
                              });
                        }
                      }),
                  Container(
                    height: 500,
                    width: 300,
                    color: Colors.green,
                  ),
                  Container(
                    height: 500,
                    width: 300,
                    color: Colors.green,
                  )
                ]),
              ),
            ],
          ),
        ));
  }
}
