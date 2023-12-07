import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/favorites_notifier.dart';
// import 'package:frontend/models/constants.dart';
import 'package:frontend/views/Ui/mainscreen.dart';
import 'package:frontend/views/shared/appstyle.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  

 

  @override
  Widget build(BuildContext context) {
    var favoritesNotifier = Provider.of<FavoritesNotifier>(context);
    favoritesNotifier.getAllData();

    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/t.jpg"), fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              "My Favorutes",
              style: appstyle(36, Colors.white, FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
              itemCount: favoritesNotifier.fav.length,
              padding: const EdgeInsets.only(top: 100),
              itemBuilder: (BuildContext context, int index) {
                final cream = favoritesNotifier.fav[index];
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.11,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade500,
                                spreadRadius: 5,
                                blurRadius: 0.3,
                                offset: const Offset(0, 1))
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: CachedNetworkImage(
                                  imageUrl: cream['imageUrl'][0],
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 12,
                                  left: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cream['name'],
                                      style: appstyle(
                                          16, Colors.black, FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      cream['category'],
                                      style: appstyle(
                                          14, Colors.grey, FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${cream['price']}',
                                          style: appstyle(12, Colors.black,
                                              FontWeight.w600),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: GestureDetector(
                              onTap: () {
                                // Assuming 'id' is the correct key in your favData
                                int keyToDelete = cream['key'];

                                // Delete the item from Hive
                                favoritesNotifier.deleteFav(keyToDelete);

                                // Remove the id from the list (if necessary)
                                favoritesNotifier.ids.removeWhere(
                                    (element) => element == cream['id']);

                                // Navigate to MainScreen
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Favorites()));
                              },
                              child: const Icon(Icons.heart_broken),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        )
      ]),
    ));
  }
}
