import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Models/authUserModels.dart';
import 'package:socioverse/Services/authentication_services.dart';
import 'package:socioverse/Views/Pages/AccountSetup/SelectCountry.dart';
import 'package:socioverse/Views/Pages/Authentication/createNewPasswordPage.dart';

import '../../Widgets/buttons.dart';

class ForgotPasswordOtpPage extends StatefulWidget {
  final SignupUser signupUser;
  final bool isSignup;
  const ForgotPasswordOtpPage(
      {super.key, required this.signupUser, required this.isSignup});

  @override
  State<ForgotPasswordOtpPage> createState() => _ForgotPasswordOtpPageState();
}

class _ForgotPasswordOtpPageState extends State<ForgotPasswordOtpPage> {
  final TextEditingController _otpController = TextEditingController();
  void getOtp() async {
    context.loaderOverlay.show();
    log(widget.signupUser.email!);
    await AuthServices.generateOtp(widget.isSignup,
        email: widget.signupUser.email!);

    context.loaderOverlay.hide();
  }

  @override
  void initState() {
    getOtp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Verify Email",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: 25,
              ),
        ),
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Code has been sent to ${widget.signupUser.email!.replaceRange(
                        (widget.signupUser.email!.indexOf("@") / 2).floor(),
                        widget.signupUser.email!.indexOf("@"),
                        "**",
                      )}",
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Pinput(
                      controller: _otpController,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      keyboardType: TextInputType.number,
                      defaultPinTheme: PinTheme(
                        width: 80,
                        height: 66,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CountdownTimer(
                      endTime: DateTime.now().millisecondsSinceEpoch +
                          1000 * 60 * 10,
                      widgetBuilder: (_, CurrentRemainingTime? time) {
                        if (time == null) {
                          return TextButton(
                            onPressed: () {
                              getOtp();
                            },
                            child: Text(
                              'Resend OTP',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          );
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Resend OTP ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                            Text(
                              '${time.min} m : ${time.sec} s',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                            Text(
                              ' s',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                MyElevatedButton1(
                    title: "Verify",
                    onPressed: () async {
                      context.loaderOverlay.show();
                      ApiResponse? response = widget.isSignup
                          ? await AuthServices.verifyOtp(
                              email: widget.signupUser.email!,
                              otp: _otpController.text)
                          : await AuthServices.userLogin(
                              loginUser: LoginUser(
                                  email: widget.signupUser.email!,
                                  otp: _otpController.text,
                                  fcmtoken: await FirebaseMessaging.instance
                                      .getToken()));
                      context.loaderOverlay.hide();
                      if (response!.success) {
                        Fluttertoast.showToast(
                            msg: widget.isSignup ? "OTP Verified" : "Logged In",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);

                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => widget.isSignup
                                    ? SelectCountryPage(
                                        signupUser: widget.signupUser,
                                      )
                                    : CreateNewPasswordPage()));
                      } else {
                        Fluttertoast.showToast(
                            msg: "Invalid OTP",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    ctx: context),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
