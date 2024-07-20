import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

class CustomSelectProfileContainer extends StatelessWidget {
  final String iconImage;
  final String title;
  final String subTitle;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomSelectProfileContainer({
    super.key,
    required this.iconImage,
    required this.title,
    required this.subTitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 89,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: AppColors.blackColor,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 21),
            CircleAvatar(
              radius: 12,
              backgroundColor: AppColors.mainBlackColor,
              child: CircleAvatar(
                  radius: 11,
                  backgroundColor: AppColors.whiteColor,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: isSelected
                        ? AppColors.primaryColor
                        : AppColors.whiteColor,
                  )),
            ),
            const SizedBox(width: 21),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                image: DecorationImage(image: AssetImage(iconImage)),
              ),
            ),
            const SizedBox(width: 21),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.roboto(
                      color: AppColors.mainBlackColor,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.7,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    subTitle,
                    style: GoogleFonts.roboto(
                      color: AppColors.grey001Color,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.7,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
