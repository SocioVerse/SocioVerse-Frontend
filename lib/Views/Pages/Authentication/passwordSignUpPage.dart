// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Views/Pages/AccountSetup/fillProfileDetails.dart';
import 'package:socioverse/Views/Pages/Authentication/passwordSignInPage.dart';
import 'package:socioverse/services/authentication_services.dart';

class PasswordSignUpPage extends StatefulWidget {
  const PasswordSignUpPage({super.key});

  @override
  State<PasswordSignUpPage> createState() => _PasswordSignUpPageState();
}

class _PasswordSignUpPageState extends State<PasswordSignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isChecked = false;
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
              TextField(
                controller: emailController,
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
              TextField(
                controller: passwordController,
                cursorOpacityAnimates: true,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16, color: Theme.of(context).colorScheme.surface),
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Icon(
                      Icons.lock_rounded,
                      size: 20,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  fillColor: Theme.of(context).colorScheme.secondary,
                  hintText: "Password",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Icon(
                      Icons.visibility_rounded,
                    ),
                  ),
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
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      value: isChecked,
                      activeColor: Theme.of(context).colorScheme.primary,
                      checkColor: Theme.of(context).colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                          print(value);
                        });
                      }),
                  Text(
                    "Remember me",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    bool isExists = await AuthServices()
                        .isEmailExists(email: emailController.text.trim());
                    if (!isExists) {
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => FillProfilePage(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  )));
                    } else {
                      Fluttertoast.showToast(
                          msg: "Email already exists",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
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
              Row(children: [
                Expanded(
                  child:
                      Divider(color: Theme.of(context).colorScheme.onPrimary),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "OR continue with",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child:
                      Divider(color: Theme.of(context).colorScheme.onPrimary),
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
                        padding: EdgeInsets.symmetric(vertical: 15),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {},
                      child: Icon(
                        Icons.facebook_rounded,
                        color: Colors.blue,
                        size: 35,
                      ),
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {},
                      child: Icon(
                        Ionicons.logo_google,
                        size: 35,
                      ),
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {},
                      child: Icon(
                        Ionicons.logo_apple,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
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
                                builder: (context) => PasswordSignInPage()));
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
