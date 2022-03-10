import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSvgAsset extends StatelessWidget {
  final String image;
  final double? imageW;
  final double? imageH;
  final Color? color;

  const AppSvgAsset({Key? key, required this.image, this.imageW, this.imageH, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/$image',
      width: imageW?.w,
      height: imageH?.h,
      color: color,
    );
  }
}
