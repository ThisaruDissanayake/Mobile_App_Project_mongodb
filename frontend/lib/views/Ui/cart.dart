import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/views/shared/appstyle.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend/views/shared/cheakout_btn.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartPage extends StatefulWidget {
const CartPage({super.key});
  

  @override
  State<CartPage> createState() => _CartPageState();
  
}

class _CartPageState extends State<CartPage> {
 
  final _cartBox = Hive.box("cart_box");

  @override
  Widget build(BuildContext context) {
    List<dynamic> cart = [];
    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "category": item['category'],
        "name": item['name'],
        "imageUrl": item['imageUrl'],
        "price": item['price'],
        "qty": item['qty'],
        "branch": item['branch'],
      };
    }).toList();
    cart = cartData.reversed.toList();
    // print(cart);
    return Scaffold(
       backgroundColor:  const Color.fromARGB(255, 190, 189, 189),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "My Cart",
                  style: appstyle(36, Colors.black, FontWeight.bold),
                ),
                
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ListView.builder(
                    itemCount: cart.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final data = cart[index];
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          child: Slidable(
                            key: const ValueKey(0),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  flex: 1,
                                  onPressed: doNothing,
                                  backgroundColor: const Color(0xFF000000),
                                  foregroundColor:
                                      const Color.fromARGB(255, 236, 88, 88),
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: CachedNetworkImage(
                                          imageUrl: data['imageUrl'],
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12, left: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data['name'],
                                              style: appstyle(16, Colors.black,
                                                  FontWeight.bold),
                                            ),
                                            const SizedBox(height: 5,),
                                            Text(
                                              data['category'],
                                              style: appstyle(12, Colors.grey,
                                                  FontWeight.w600),
                                            ),
                                            const SizedBox(height: 5,),
                                            Row(
                                              children: [
                                                Text(
                                                  data['price'],
                                                  style: appstyle(18, Colors.black,
                                                      FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  width: 40,
                                                ),
                                                
                                                Text(
                                                  "${data['branch']}",
                                                  style: appstyle(12, Colors.black,
                                                      FontWeight.w600),
                                                ),
                                              ],
                                            ),


                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(16))
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: (){
                                                // cartprovider.increment
                                              },
                                              child: const Icon(
                                                Icons.remove_circle,size: 20,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              data['qty'].toString(),
                                              style: appstyle(16, Colors.black, FontWeight.w600,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: (){
                                                // carprovider.decrement
                                              },
                                              child: const Icon(
                                                Icons.add_box,
                                                size: 20,
                                                color: Colors.black,
                                              ),
                                            ),
                                            

                                          ],
                                        ),
                                      ),)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            const Align(alignment: Alignment.bottomCenter,
            child: CheackoutButton(label: "Proceed to Cheackout"),)
          ],
        ),
      ),
    );
  }

  void doNothing(BuildContext context) {
  }
}
