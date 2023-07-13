import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/config/colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.isPassword,
    required this.hintText,
    this.keyboardType,
  });
  final TextEditingController controller;
  final bool isPassword;
  final String hintText;
  final TextInputType? keyboardType;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      obscureText: widget.isPassword ? isHidden : widget.isPassword,
      obscuringCharacter: '•',
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      isHidden = !isHidden;
                    });
                  }
                },
                child: Icon(isHidden ? Remix.eye_line : Remix.eye_off_line),
              )
            : const SizedBox.shrink(),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 8.h,
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
          color: AppColors.kLightText,
        ),
        counterText: '',
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.kBorderColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.kBorderColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}
