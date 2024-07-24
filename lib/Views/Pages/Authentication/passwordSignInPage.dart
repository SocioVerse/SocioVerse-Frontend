import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/passwordSingInPageProvider.dart';
import 'package:socioverse/Helper/FlutterToasts/flutterToast.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/Models/authUserModels.dart';
import 'package:socioverse/Views/Pages/Authentication/forgotPassword.dart';
import 'package:socioverse/Views/Pages/Authentication/passwordSignUpPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/MainPage.dart';
import 'package:socioverse/Services/authentication_services.dart';
import 'package:socioverse/Views/Widgets/textfield_widgets.dart';

import '../../Widgets/buttons.dart';

class PasswordSignInPage extends StatefulWidget {
  const PasswordSignInPage({super.key});

  @override
  State<PasswordSignInPage> createState() => _PasswordSignInPageState();
}

class _PasswordSignInPageState extends State<PasswordSignInPage> {
  TextEditingController userNameOrEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;

  bool isChecked = false;
  @override
  void initState() {
    setBooleanIntoCache(SharedPreferenceString.isIntroDone, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Log in your \nAccount",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(height: 1.5),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 40,
              ),
              TextField(
                controller: userNameOrEmailController,
                cursorOpacityAnimates: true,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16, color: Theme.of(context).colorScheme.surface),
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Icon(
                      Icons.mail_rounded,
                      size: 20,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  fillColor: Theme.of(context).colorScheme.secondary,
                  hintText: "Email",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  focusColor: Theme.of(context).colorScheme.primary,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<PasswordSignInPageProvider>(
                  builder: (context, provider, child) => CustomInputField(
                        controller: passwordController,
                        obscureText: provider.isObscure ? true : false,
                        prefixIcon: Icons.lock_rounded,
                        suffixIcon: InkWell(
                          onTap: () {
                            provider.isObscure = !provider.isObscure;
                          },
                          child: Icon(
                            provider.isObscure
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        hintText: "Password",
                      )),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordPage()));
                      },
                      child: Text(
                        "Forgot the password?",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              MyElevatedButton1(
                  title: "Sign in",
                  onPressed: () async {
                    if (userNameOrEmailController.text.trim().isEmpty ||
                        passwordController.text.trim().isEmpty) {
                      FlutterToast.flutterWhiteToast("Fill all details");
                      return;
                    } else {
                      context.loaderOverlay.show();
                      String? fcmToken =
                          await FirebaseMessaging.instance.getToken();
                      ApiResponse? response = await AuthServices.userLogin(
                        loginUser: LoginUser(
                            usernameAndEmail:
                                userNameOrEmailController.text.trim(),
                            password: passwordController.text.trim(),
                            fcmtoken: fcmToken!),
                      );
                      if (context.mounted) context.loaderOverlay.hide();
                      if (response!.success == true && context.mounted) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainPage()),
                            (route) => false);
                      } else {
                        FlutterToast.flutterWhiteToast(
                            response.message.toString());
                      }
                    }
                  },
                  ctx: context),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    const PasswordSignUpPage()));
                      },
                      child: Text(
                        "Sign up",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _otherMethods(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(children: [
          Expanded(
            child: Divider(color: Theme.of(context).colorScheme.onPrimary),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "OR continue with",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Divider(color: Theme.of(context).colorScheme.onPrimary),
          )
        ]),
        const SizedBox(
          height: 40,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {},
                child: const Icon(
                  Icons.facebook_rounded,
                  color: Colors.blue,
                  size: 35,
                ),
              ),
            ),
            Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {},
                child: Icon(
                  Ionicons.logo_google,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 35,
                ),
              ),
            ),
            Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {},
                child: Icon(
                  Ionicons.logo_apple,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 35,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
