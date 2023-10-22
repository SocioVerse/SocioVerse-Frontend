
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Views/Pages/Authentication/forgotPassword.dart';
import 'package:socioverse/Views/Pages/Authentication/passwordSignUpPage.dart';

import '../../Widgets/buttons.dart';

class PasswordSignInPage extends StatefulWidget {
  const PasswordSignInPage({super.key});

  @override
  State<PasswordSignInPage> createState() => _PasswordSignInPageState();
}

class _PasswordSignInPageState extends State<PasswordSignInPage> {
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
              MyElevatedButton1(
                  title: "Sign in",
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => PasswordSignUpPage()));
                  },
                  ctx: context),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => ForgotPasswordPage()));
                      },
                      child: Text(
                        "Forgot the password?",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
              SizedBox(
                height: 20,
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
                    "Don't have an account?",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => PasswordSignUpPage()));
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
}
