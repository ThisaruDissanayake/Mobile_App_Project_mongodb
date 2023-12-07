import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:frontend/models/sneaker_models.dart';
import 'package:frontend/views/shared/stagger_tile.dart';



class FemaleAll extends StatelessWidget {
  const FemaleAll({
    super.key,
    required Future<List<Sneakers>> female,
  }) : _female = female;

  final Future<List<Sneakers>> _female;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sneakers>>(
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
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 16,
            itemCount: female!.length,
            staggeredTileBuilder: (index) =>
                const StaggeredTile.fit(1),
            itemBuilder: (context, index) {
              final cream = snapshot.data![index];
              return StaggerTile(
                price: "LKR ${cream.price}",
                name: cream.name,
                imageUrl: cream.imageUrl[0],
                  );
                });
          }
        });
  }
}
