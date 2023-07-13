import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/widgets/chip_widget.dart';

class ReviewCard extends StatefulWidget {
  const ReviewCard({
    super.key,
    required this.rating,
    required this.title,
    required this.body,
    required this.date,
  });

  final String rating, title, body, date;

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ChipWidget(rating: widget.rating),
            SizedBox(width: 8.w),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          widget.body,
          maxLines: isClicked ? 10 : 3,
          textAlign: TextAlign.justify,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 8.h),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              if (mounted) {
                setState(() {
                  isClicked = !isClicked;
                });
              }
            },
            child: Text(
              isClicked ? 'Show Less' : 'Read more',
              style: const TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(widget.date),
        ),
      ],
    );
  }
}
