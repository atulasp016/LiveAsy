import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  final IconData icon;
  const CustomBackButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 71, top: 11,left: 0),
        child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child:  Icon(icon,
                color: AppColors.mainBlackColor, size: 26)),
      ),
    );
  }
}
