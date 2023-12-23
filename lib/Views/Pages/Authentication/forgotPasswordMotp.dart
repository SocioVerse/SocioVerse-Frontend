import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:socioverse/Views/Pages/Authentication/createNewPasswordPage.dart';

import '../../Widgets/buttons.dart';

class ForgotPasswordMotpPage extends StatefulWidget {
  const ForgotPasswordMotpPage({super.key});

  @override
  State<ForgotPasswordMotpPage> createState() => _ForgotPasswordMotpPageState();
}

class _ForgotPasswordMotpPageState extends State<ForgotPasswordMotpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forgot Password",
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
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Code has been sent to +91935****37",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Pinput(
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
                    endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 60,
                    widgetBuilder: (_, CurrentRemainingTime? time) {
                      if (time == null) {
                        return TextButton(
                          onPressed: () {},
                          child: Text(
                            'Resend OTP',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
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
                            '${time.sec}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
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
            ),
            const SizedBox(
              height: 20,
            ),
            MyElevatedButton1(
                title: "Verify",
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => CreateNewPasswordPage()));
                },
                ctx: context),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
