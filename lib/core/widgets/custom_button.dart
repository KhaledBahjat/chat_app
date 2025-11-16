import 'package:chat_app/core/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
   CustomButton({
    super.key, required this.label,
    this.onTap,
  });
  void Function()? onTap;
  final String label;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 25.sp,
            color: AppColor.primaryColor,
          ),
        ),
      ),
    );
  }
}
