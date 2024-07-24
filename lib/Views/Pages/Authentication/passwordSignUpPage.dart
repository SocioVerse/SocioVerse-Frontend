// ignore_for_file: use_build_context_synchronously

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/passwordSignUpPageProvider.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/Models/authUserModels.dart';
import 'package:socioverse/Utils/CalculatingFunctions.dart';
import 'package:socioverse/Utils/Validators.dart';
import 'package:socioverse/Views/Pages/AccountSetup/SelectCountry.dart';
import 'package:socioverse/Views/Pages/AccountSetup/fillProfileDetails.dart';
import 'package:socioverse/Views/Pages/Authentication/forgotPasswordOtpPage.dart';
import 'package:socioverse/Views/Pages/Authentication/passwordSignInPage.dart';
import 'package:socioverse/Services/authentication_services.dart';
import 'package:socioverse/Views/Widgets/textfield_widgets.dart';

class PasswordSignUpPage extends StatefulWidget {
  const PasswordSignUpPage({super.key});

  @override
  State<PasswordSignUpPage> createState() => _PasswordSignUpPageState();
}

class _PasswordSignUpPageState extends State<PasswordSignUpPage> {
  TextEditingController emailController = TextEditingController();
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
                "Create your \nAccount",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(height: 1.5),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 40,
              ),
              CustomInputField(
                controller: emailController,
                prefixIcon: Icons.mail_rounded,
                hintText: "Email",
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<PasswordSignUpPageProvider>(
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
                height: 40,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    context.loaderOverlay.show();
                    bool isValid = ValidationHelper.validateEmailAndPassword(
                        context,
                        emailController.text.trim(),
                        passwordController.text.trim());
                    if (!isValid) return;
                    ApiResponse response = await AuthServices.isEmailExists(
                        email: emailController.text.trim());
                    if (response.success == true) {
                      String? fcmToken =
                          await FirebaseMessaging.instance.getToken();
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => ForgotPasswordOtpPage(
                                    isSignup: true,
                                    signupUser: SignupUser(
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                        fcmtoken: fcmToken!),
                                  )));
                    } else {
                      Fluttertoast.showToast(
                          msg: response.message!,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                    context.loaderOverlay.hide();
                  },
                  child: Text("Sign up",
                      style: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary),
                      textAlign: TextAlign.center),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    const PasswordSignInPage()));
                      },
                      child: Text(
                        "Sign in",
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
}
