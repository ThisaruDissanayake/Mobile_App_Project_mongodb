import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/views/shared/appstyle.dart';
import 'package:frontend/views/shared/reusable_text.dart';

class StaggerTile extends StatefulWidget {
  const StaggerTile({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.category,
  });

  final String imageUrl;
  final String name;
  final String price;
  final String category;

  @override
  State<StaggerTile> createState() => _StaggerTileState();
}

class _StaggerTileState extends State<StaggerTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(imageUrl: widget.imageUrl, fit: BoxFit.fill),
            Container(
              padding: EdgeInsets.only(top: 12.h),
              height: 110.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: appstyleWithHt(20, Colors.black, FontWeight.w700, 1),
                  ),
                  reusableText(
                    text: widget.price,
                    style: appstyle(20, Colors.black, FontWeight.w500),
                  ),
                  reusableText(
                    text: widget.category,
                    style: appstyle(10, Colors.grey, FontWeight.w300),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
