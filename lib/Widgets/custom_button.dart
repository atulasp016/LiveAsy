import 'package:flutter/material.dart';
import 'package:liveasy/utils/app_colors.dart';

class CustomBTN extends StatelessWidget {
  final Function() onPressed;
  final String mTitle;
  final double mWidth;
  final double mHeight;
  const CustomBTN({
    super.key,
    required this.onPressed,
    required this.mTitle,
    this.mWidth = double.infinity,
    this.mHeight = 56,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: mHeight,
        width: mWidth,
        color: AppColors.primaryColor,
        child: Center(
          child: Text(
            mTitle,
            style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.whiteColor,
                fontSize: 16,
                letterSpacing: 0.5),
          ),
        ),
      ),
    );
  }
}
