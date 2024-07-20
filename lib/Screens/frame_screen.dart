import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Widgets/custom_button.dart';
import '../Widgets/custom_dropdown_button.dart';
import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import 'mobile_number_screen.dart';

class FrameScreen extends StatefulWidget {
  const FrameScreen({super.key});

  @override
  State<FrameScreen> createState() => _FrameScreenState();
}

class _FrameScreenState extends State<FrameScreen> {
  List<String> mList = [AppImages.IMG, AppImages.IMG_1];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 21),
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AppImages.IC_APP_LOGO)))),
                Text(
                  AppLocalizations.of(context)!.selectLanguage,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackColor,
                      letterSpacing: 0.7,
                      fontSize: 20),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.changeLanguage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey001Color,
                      letterSpacing: 0.7,
                      fontSize: 14),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 31),
                  child: CustomDropdownButton(mWidth: 216),
                ),
                CustomBTN(
                  mWidth: 216,
                  mHeight: 48,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MobileNumberScreen()));
                  },
                  mTitle: AppLocalizations.of(context)!.frameButton,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                Image.asset(AppImages.IMG_1),
                Positioned.fill(
                    child: Image.asset(AppImages.IMG, fit: BoxFit.fitHeight)),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
