import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Widgets/custom_button.dart';
import '../Widgets/custom_select_profile_container.dart';
import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import 'frame_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? selectedProfile;

  void selectProfile(String profile) {
    setState(() {
      selectedProfile = profile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.12),
            Text(
              AppLocalizations.of(context)!.selectProfileText,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackColor,
                  letterSpacing: 0.7,
                  fontSize: 20),
            ),
            const SizedBox(height: 31),
            CustomSelectProfileContainer(
                iconImage: AppImages.IC_SHIPPER,
                title: AppLocalizations.of(context)!.shipperText,
                subTitle: AppLocalizations.of(context)!.subTitleProfile,
                isSelected: selectedProfile ==
                    AppLocalizations.of(context)!.shipperText,
                onTap: () =>
                    selectProfile(AppLocalizations.of(context)!.shipperText)),
            const SizedBox(height: 31),
            CustomSelectProfileContainer(
                iconImage: AppImages.IC_TRANSPORTER,
                title: AppLocalizations.of(context)!.transporterText,
                subTitle: AppLocalizations.of(context)!.subTitleProfile,
                isSelected: selectedProfile ==
                    AppLocalizations.of(context)!.transporterText,
                onTap: () => selectProfile(
                    AppLocalizations.of(context)!.transporterText)),
            const SizedBox(height: 31),
            CustomBTN(
                onPressed: () {
                  if (selectedProfile != null) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FrameScreen()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Not selected...')));
                  }
                },
                mTitle: AppLocalizations.of(context)!.numberButton)
          ],
        ),
      ),
    ));
  }
}
