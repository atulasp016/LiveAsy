import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:liveasy/Screens/verify_phone_screen.dart';
import 'package:liveasy/Widgets/back_button.dart';

import '../Widgets/custom_button.dart';
import '../utils/app_colors.dart';

class MobileNumberScreen extends StatefulWidget {
  const MobileNumberScreen({super.key});

  @override
  State<MobileNumberScreen> createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  var numberController = TextEditingController();
  var mVerificationId;
  String countryDialCode = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomBackButton(icon: Icons.close),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.mobileNumberText,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackColor,
                  letterSpacing: 0.7,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.receiveCode,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey001Color,
                  letterSpacing: 0.7,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 31),
              IntlPhoneField(
                initialCountryCode: 'IN',
                controller: numberController,
                decoration: InputDecoration(
                  counterText: '',
                  labelText: AppLocalizations.of(context)!.enterMobileNumber,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                onChanged: (phone) {
                  print('=========${phone.completeNumber}==========');
                  countryDialCode = phone.countryCode;
                  setState(() {});
                },
                onCountryChanged: (country) {
                  print('Country changed to: ${country.name}');
                  setState(() {
                    countryDialCode = '+${country.dialCode}';
                  });
                },
              ),
              const SizedBox(height: 31),
              CustomBTN(
                onPressed: () async {
                  if (numberController.text.isNotEmpty) {
                    String phoneNumber =
                        countryDialCode + numberController.text;

                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: phoneNumber,
                      verificationCompleted: (PhoneAuthCredential credential) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Verification Completed...')));
                      },
                      verificationFailed: (FirebaseAuthException e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Verification Failed : ${e.message}')));
                      },
                      codeSent: (String verificationId, int? resendToken) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'SMS code sent to ${numberController.text}')));
                        mVerificationId = verificationId;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerifyPhoneScreen(
                                mNumber: phoneNumber,
                                mVerificationId: mVerificationId),
                          ),
                        ).then((v) => numberController.clear());
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter valid number...')),
                    );
                  }
                },
                mTitle: AppLocalizations.of(context)!.numberButton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
