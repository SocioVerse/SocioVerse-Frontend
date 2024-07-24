import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:socioverse/Models/authUserModels.dart';
import 'package:socioverse/Services/authentication_services.dart';
import 'package:socioverse/Utils/CalculatingFunctions.dart';
import 'package:socioverse/Views/Pages/Authentication/forgotPasswordOtpPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/StoryPage/storyPageWidgets.dart';
import 'package:socioverse/Views/Widgets/buttons.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
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
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Enter your email address to reset your password",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w100,
                        fontSize: 15,
                      ),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: _emailController,
                  hintText: "Email",
                  onChanged: (value) {}),
              const SizedBox(
                height: 20,
              ),
              MyElevatedButton1(
                  title: "Continue",
                  onPressed: () {
                    if (_emailController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Please enter your email address",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    }
                    if (!CalculatingFunction.isEmailValid(
                        _emailController.text)) return;
                    context.loaderOverlay.show();
                    AuthServices.isEmailExists(
                            email: _emailController.text.trim())
                        .then((value) {
                      if (!value.success) {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => ForgotPasswordOtpPage(
                                    isSignup: false,
                                    signupUser: SignupUser(
                                        email: _emailController.text.trim()))));
                      } else {
                        Fluttertoast.showToast(
                            msg: "Email not found",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    }).whenComplete(() => context.loaderOverlay.hide());
                  },
                  ctx: context),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
