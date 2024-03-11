import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Views/Pages/Authentication/passwordSignUpPage.dart';
import 'package:socioverse/Views/Widgets/buttons.dart';

class CreateNewPasswordPage extends StatefulWidget {
  const CreateNewPasswordPage({super.key});

  @override
  State<CreateNewPasswordPage> createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  var isChecked = false;
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Create New Password",
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
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: Container()),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Create Your New Password",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 15),
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 40,
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
                    Ionicons.lock_closed,
                    size: 20,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                fillColor: Theme.of(context).colorScheme.secondary,
                hintText: "Confirm Password",
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
            const SizedBox(
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
              ctx: context,
              title: "Continue",
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => PasswordSignUpPage()));
              },
            ),
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       padding: EdgeInsets.symmetric(vertical: 15),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //     ),
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           CupertinoPageRoute(
            //               builder: (context) => PasswordSignUpPage()));
            //     },
            //     child: Text("Continue",
            //         style: GoogleFonts.openSans(
            //             fontSize: 15,
            //             fontWeight: FontWeight.bold,
            //             color: Theme.of(context).colorScheme.onPrimary),
            //         textAlign: TextAlign.center),
            //   ),
            // ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
