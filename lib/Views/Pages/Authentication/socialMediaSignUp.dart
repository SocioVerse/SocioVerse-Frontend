import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:socioverse/Views/Pages/Authentication/passwordSignInPage.dart';
import 'package:socioverse/Views/Pages/Authentication/passwordSignUpPage.dart';
import 'package:socioverse/Views/Widgets/buttons.dart';

class SocialMediaSignUpPage extends StatelessWidget {
  const SocialMediaSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
            child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Lottie.asset('assets/lottie/login.json'),
              ),
            ),
            Text(
              "Let's you in",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 40,
            ),
            SocialMediaButton(
              icon: Icons.facebook_rounded,
              text: "Continue with Facebook",
              iconColor: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const SocialMediaSignUpPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            SocialMediaButton(
              icon: Ionicons.logo_google,
              text: "Continue with Google",
              iconColor: Theme.of(context).colorScheme.onPrimary,
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const SocialMediaSignUpPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            SocialMediaButton(
              icon: Ionicons.logo_apple,
              text: "Continue with Apple",
              iconColor: Theme.of(context).colorScheme.onPrimary,
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const SocialMediaSignUpPage(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Row(children: [
              Expanded(
                child: Divider(color: Theme.of(context).colorScheme.onPrimary),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "OR",
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const PasswordSignInPage()));
                },
                child: Text("Sign in with password",
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
            const SizedBox(
              height: 40,
            ),
          ],
        )),
      ),
    );
  }
}
