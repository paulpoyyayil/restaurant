import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:restaurant/config/colors.dart';
import 'package:restaurant/model/restaurant.dart';
import 'package:restaurant/screens/restaurant_details/restaurant_details.dart';
import 'package:restaurant/utils/navigation.dart';
import 'package:restaurant/widgets/chip_widget.dart';

class RestaurantCard extends StatefulWidget {
  const RestaurantCard({super.key, required this.restaurantData});
  final RestaurantData restaurantData;

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  Random random = Random();
  double randomNum = 0.0;

  @override
  void initState() {
    super.initState();
    randomNum = random.nextDouble() * 5.0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigationPush(
        context,
        RestaurantDetails(
          restaurantData: widget.restaurantData,
          rating: randomNum.toStringAsFixed(1),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.kBackgroundColor,
          borderRadius: BorderRadius.circular(4.r),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 2),
              spreadRadius: 0,
              blurRadius: 4,
              color: AppColors.kShadowColor,
            )
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              child: CachedNetworkImage(
                imageUrl: widget.restaurantData.photograph!,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.restaurantData.name!,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      ChipWidget(rating: randomNum.toStringAsFixed(1)),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      const Icon(
                        Remix.close_circle_fill,
                        color: AppColors.kLightText,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        widget.restaurantData.cuisineType!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      const Icon(
                        Remix.map_pin_2_fill,
                        color: AppColors.kLightText,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        widget.restaurantData.address!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
