import 'dart:io';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';
import '../../core/httpHelper/http_helper.dart';

class ImageContainer extends StatelessWidget {
  final String? imagePath;
  final bool isLoading;
  final VoidCallback onImagePressed;

  ImageContainer({
    required this.imagePath,
    required this.onImagePressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Card(
          elevation: 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
          child: (imagePath != null && imagePath!.isNotEmpty)
              ? imagePath!.contains('http')
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50.r),
                      child: FancyShimmerImage(
                        imageUrl: base_url_image + imagePath!,
                        boxFit: BoxFit.cover,
                        height: 80.h,
                        width: 80.w,
                        errorWidget: Image.asset(
                          getAsset('user_profile_icon'),
                          height: 80.h,
                          width: 80.w,
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50.r),
                      child: Image.file(
                        File(imagePath!),
                        fit: BoxFit.cover,
                        height: 80.h,
                        width: 80.w,
                      ),
                    )
              : Container(
                  height: 80.h,
                  width: 80.w,
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              kMainColor,
                            ),
                          ),
                        )
                      : Center(
                          child: Image.asset(
                            getAsset('user_profile_icon'),
                            height: 50.h,
                            width: 50.w,
                          ),
                        ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.r)),
                ),
        ),
        GestureDetector(
          onTap: onImagePressed,
          child: Center(
            child: Container(
              decoration:
                  BoxDecoration(color: kMainColor, shape: BoxShape.circle),
              height: 30.h,
              width: 30.w,
              child: Icon(
                Icons.add_a_photo,
                color: kAccentColor,
                size: 16,
              ),
            ),
          ),
        )
      ],
    );
  }
}
