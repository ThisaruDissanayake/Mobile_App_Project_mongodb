import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/product_provider.dart';
import 'package:frontend/models/sneaker_models.dart';
import 'package:frontend/services/helper.dart';
import 'package:frontend/views/shared/appstyle.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});

  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();

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
                                      Navigator.pop(context);
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
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Positioned(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
                                                right: 20,
                                                child: const Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.grey,
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
                                                    topLeft:Radius.circular(30),
                                                    topRight:Radius.circular(30) , 
                                                    ),

                                                    child:Container(
                                                      height:MediaQuery.of(context).size.height*0.645 ,
                                                      width:MediaQuery.of(context).size.width ,
                                                      color: Colors.white,
                                                      child:Padding(
                                                        padding:  EdgeInsets.all(12),
                                                        
                                                        child:Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text( sneaker.name,
                                                            style:appstyle(40, Colors.black, FontWeight.bold),),

                                                            Row(
                                                              children: [
                                                                Text(sneaker.category,
                                                                style: appstyle(20, Colors.grey, FontWeight.w500)),

                                                               const  SizedBox(
                                                                  width:20,
                                                                ),
                                                                 
                                                                  // RatingBar.builder(
                                                                  //initialRating:4,
                                                                  //minRating:1,
                                                                  //direction:Axis.horizontal,
                                                                  //allowHalfRating:true,
                                                                  //itemCount:5,
                                                                  //itemSize:22,
                                                                  //itemPadding: EdgeInsets.symmetric(horizontal:1 ),
                                                                  //itemBuilder:(context, _)
                                                                  // =>const Icon(Icons.star,
                                                                  //size:18,
                                                                  //color:Colors.black,),
                                                                  //onRatingUpdate:(rating){},
                                                                 //)
                                                             
                                                             
                                                              ],
                                                              )
                                                              ],

                                                        ) ,
                                                        ),
                                                    )
                                                    )
                                                    )
                                          
                              ],
                            )
                            )
                            )
                      ],
                    );
                  });
                }
              })),
    );
  }
}
