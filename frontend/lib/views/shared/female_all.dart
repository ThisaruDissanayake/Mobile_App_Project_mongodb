import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:frontend/controllers/product_provider.dart';
import 'package:frontend/models/sneaker_models.dart';
import 'package:frontend/views/Ui/product_page.dart';
import 'package:frontend/views/shared/stagger_tile.dart';
import 'package:provider/provider.dart';

class FemaleAll extends StatelessWidget {
  const FemaleAll({
    super.key,
    required Future<List<Sneakers>> female,
  }) : _female = female;

  final Future<List<Sneakers>> _female;

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    return FutureBuilder<List<Sneakers>>(
        future: _female,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          } else {
            final female = snapshot.data;

            return StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 16,
                itemCount: female!.length,
                staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                itemBuilder: (context, index) {
                  final cream = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      // productNotifier.branchers = cream.branches!;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(sneakers: cream,
                          ),
                        ),
                      );
                    },
                    child: StaggerTile(
                      price: "LKR ${cream.price}",
                      name: cream.name,
                      category: cream.category,
                      imageUrl: cream.imageUrl[0],
                    ),
                  );
                });
          }
        });
  }
}
