import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:liveasy/Screens/profile_screen.dart';
import 'package:liveasy/Widgets/back_button.dart';
import '../Widgets/custom_button.dart';
import '../utils/app_colors.dart';

class VerifyPhoneScreen extends StatefulWidget {
  final String mNumber;
  String mVerificationId;

  VerifyPhoneScreen({
    super.key,
    required this.mNumber,
    required this.mVerificationId,
  });

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  var otpNo1Controller = TextEditingController();
  var otpNo2Controller = TextEditingController();
  var otpNo3Controller = TextEditingController();
  var otpNo4Controller = TextEditingController();
  var otpNo5Controller = TextEditingController();
  var otpNo6Controller = TextEditingController();

  Timer? timer;
  int startTime = 60;
  bool isResendOTP = false;
  int? resendToken;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    startTime = 60;
    isResendOTP = false;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (startTime == 0) {
          setState(() {
            isResendOTP = true;
            timer.cancel();
          });
        } else {
          setState(() {
            startTime--;
          });
        }
      },
    );
  }

  void resendOtp() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.mNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Sign in automatically
        await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Verification Failed: ${e.message}')),
        );
      },
      codeSent: (String verificationId, int? newResendToken) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('SMS code sent to ${widget.mNumber}')),
        );
        setState(() {
          widget.mVerificationId = verificationId;
          resendToken = newResendToken;
        });
        startTimer(); // Restart the timer after resending OTP
      },
      forceResendingToken: resendToken,
      codeAutoRetrievalTimeout: (String verificationId) {
        // Optional: handle code auto-retrieval timeout
        widget.mVerificationId = verificationId;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const CustomBackButton(icon: Icons.arrow_back_sharp),
              Text(
                AppLocalizations.of(context)!.verifyPhoneText,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackColor,
                  letterSpacing: 0.7,
                  fontSize: 20,
                ),
              ),
              Text(
                '${AppLocalizations.of(context)!.sentCodeText} ${widget.mNumber}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey001Color,
                  letterSpacing: 0.7,
                  fontSize: 14,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 31),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    mTextField(mController: otpNo1Controller, isFocus: true),
                    mTextField(mController: otpNo2Controller),
                    mTextField(mController: otpNo3Controller),
                    mTextField(mController: otpNo4Controller),
                    mTextField(mController: otpNo5Controller),
                    mTextField(mController: otpNo6Controller),
                  ],
                ),
              ),
              isResendOTP
                  ? Padding(
                padding: const EdgeInsets.only(bottom: 31),
                child: RichText(
                  text: TextSpan(
                    text: '${AppLocalizations.of(context)!.dontReceiveCodeText}\t',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey001Color,
                      letterSpacing: 0.7,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.requestAgain,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700,
                          color: AppColors.mainBlackColor,
                          letterSpacing: 0.7,
                          fontSize: 14,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            resendOtp();
                          },
                      ),
                    ],
                  ),
                ),
              )
                  : Padding(
                padding: const EdgeInsets.only(bottom: 31),
                child: RichText(
                  text: TextSpan(
                    text: '${AppLocalizations.of(context)!.requestResendOTP}\t',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey001Color,
                      letterSpacing: 0.7,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: startTime.toString(),
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700,
                          color: AppColors.mainBlackColor,
                          letterSpacing: 0.7,
                          fontSize: 14,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (isResendOTP) {
                              resendOtp();
                            }
                          },
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: widget.mVerificationId.isNotEmpty ? 1 : 0,
                duration: const Duration(seconds: 2),
                child: CustomBTN(
                  onPressed: () async {
                    String smsCode = otpNo1Controller.text +
                        otpNo2Controller.text +
                        otpNo3Controller.text +
                        otpNo4Controller.text +
                        otpNo5Controller.text +
                        otpNo6Controller.text;

                    PhoneAuthCredential credential =
                    PhoneAuthProvider.credential(
                        verificationId: widget.mVerificationId,
                        smsCode: smsCode);

                    try {
                      var cred = await FirebaseAuth.instance
                          .signInWithCredential(credential);
                      print(cred.toString());

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid OTP: ${e.toString()}')),
                      );
                    }
                  },
                  mTitle: AppLocalizations.of(context)!.verifyButton,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mTextField({
    required TextEditingController mController,
    bool isFocus = false,
  }) {
    return Container(
      color: AppColors.secondaryColor,
      width: 48,
      height: 48,
      child: TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        controller: mController,
        autofocus: isFocus,
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          }
        },
        maxLength: 1,
        maxLines: 1,
        decoration:
        const InputDecoration(counterText: '', border: InputBorder.none),
      ),
    );
  }
}
