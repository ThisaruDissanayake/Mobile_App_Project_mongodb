import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/views/shared/appstyle.dart';

class CheackoutButton extends StatelessWidget {
  const CheackoutButton({
    super.key, this.onTap, required this.label,
  });

  final void Function()? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          height: 50,
          width: 340.w,
          child: Center(
            child:
                Text(label, style: appstyle(20, Colors.white, FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
