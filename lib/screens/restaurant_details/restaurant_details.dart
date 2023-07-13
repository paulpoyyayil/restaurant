import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:restaurant/config/colors.dart';
import 'package:restaurant/model/restaurant.dart';
import 'package:restaurant/screens/restaurant_details/widgets/review_card.dart';
import 'package:restaurant/widgets/chip_widget.dart';
import 'package:maps_launcher/maps_launcher.dart';

class RestaurantDetails extends StatefulWidget {
  const RestaurantDetails({
    super.key,
    required this.restaurantData,
    required this.rating,
  });
  final RestaurantData restaurantData;
  final String rating;

  @override
  State<RestaurantDetails> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  String? selectedTime;
  List<DropdownMenuItem<String>> items = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setData();
    });
  }

  void setData() {
    setState(() {
      items =
          widget.restaurantData.operatingHours!.toJson().entries.map((entry) {
        return DropdownMenuItem<String>(
          value: '${entry.key}: ${entry.value}',
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Text('${entry.key}: ${entry.value}'),
          ),
        );
      }).toList();

      if (items.isNotEmpty) {
        selectedTime = items[0].value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MapsLauncher.launchCoordinates(
            widget.restaurantData.latlng!.lat!,
            widget.restaurantData.latlng!.lng!,
            widget.restaurantData.name!,
          );
        },
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Remix.arrow_right_s_line),
            Text('GO'),
          ],
        ),
      ),
      body: SingleChildScrollView(
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
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.restaurantData.name!,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      ChipWidget(rating: widget.rating),
                    ],
                  ),
                  Text(
                    widget.restaurantData.neighborhood!,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12.h),
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
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      const Icon(
                        Remix.time_fill,
                        color: AppColors.kLightText,
                      ),
                      SizedBox(width: 8.w),
                      DropdownButton<String>(
                        items: items,
                        value: selectedTime,
                        isDense: true,
                        underline: const SizedBox.shrink(),
                        padding: EdgeInsets.zero,
                        icon: const Icon(Remix.arrow_down_s_line),
                        onChanged: (newValue) {
                          setState(() {
                            selectedTime = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 48.h),
                  Text(
                    'Rating & Reviews',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) => ReviewCard(
                      rating: widget.restaurantData.reviews![index].rating
                          .toString(),
                      title: widget.restaurantData.reviews![index].name!,
                      body: widget.restaurantData.reviews![index].comments!,
                      date: widget.restaurantData.reviews![index].date!,
                    ),
                    separatorBuilder: (context, index) =>
                        const Divider(thickness: 1.5),
                    itemCount: widget.restaurantData.reviews!.length,
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
