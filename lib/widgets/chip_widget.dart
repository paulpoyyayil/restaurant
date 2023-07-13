import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:restaurant/config/colors.dart';

class ChipWidget extends StatelessWidget {
  const ChipWidget({
    super.key,
    required this.rating,
  });

  final String rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.kRatingChipColor,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        children: [
          Text(
            rating,
            style: const TextStyle(
              color: AppColors.kBackgroundColor,
            ),
          ),
          SizedBox(width: 4.w),
          const Icon(
            Remix.star_fill,
            color: AppColors.kBackgroundColor,
          ),
        ],
      ),
    );
  }
}
