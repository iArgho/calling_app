import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_getx/core/constants/colors.dart';

class InputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final TextInputType keyboardType;

  const InputField({
    super.key,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      //cursorColor: AppColors.textLightGrey,
      decoration: InputDecoration(
        filled: true,
        // fillColor: AppColors.shade,
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(color: Color(0xFFE6E6E6), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
      style: TextStyle(fontSize: 14.sp),
    );
  }
}
