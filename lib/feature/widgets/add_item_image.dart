import 'dart:io';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';

class AddItemImage extends StatelessWidget {
  final String? imagePath;
  final VoidCallback onImagePressed;

  AddItemImage({
    required this.imagePath,
    required this.onImagePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onImagePressed,
      child: Container(
        height: 70.h,
        width: 70.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: kBackgroundColor, width: 2)),
        child: imagePath == null || imagePath!.isEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(15.0.r),
                child: Center(
                  child: Image.asset(
                    getAsset('add_new_ad'),
                    height: 25.h,
                    width: 25.w,
                  ),
                ),
              )
            : imagePath!.contains('http')
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(15.0.r),
                    child: FancyShimmerImage(
                      imageUrl: imagePath!,
                      boxFit: BoxFit.cover,
                      errorWidget: Image.asset(
                        getAsset('profile_image'),
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Image.file(
                      File(imagePath!),
                      fit: BoxFit.cover,
                    ),
                  ),
      ),
    );
  }
}
