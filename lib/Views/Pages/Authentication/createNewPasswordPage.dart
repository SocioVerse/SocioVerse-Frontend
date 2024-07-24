import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/createNewPasswordPageProvider.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/get_Routes.dart';
import 'package:socioverse/Services/user_services.dart';
import 'package:socioverse/Utils/CalculatingFunctions.dart';
import 'package:socioverse/Views/Pages/Authentication/passwordSignUpPage.dart';
import 'package:socioverse/Views/Widgets/buttons.dart';
import 'package:socioverse/Views/Widgets/textfield_widgets.dart';

class CreateNewPasswordPage extends StatefulWidget {
  CreateNewPasswordPage({super.key});

  @override
  State<CreateNewPasswordPage> createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

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
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                CustomInputField(
                  controller: newPasswordController,
                  hintText: "New Password",
                  obscureText: true,
                  prefixIcon: Icons.lock_outline_rounded,
                ),
                // confirm password

                const SizedBox(
                  height: 20,
                ),
                CustomInputField(
                  controller: confirmPasswordController,
                  hintText: "Confirm New Password",
                  obscureText: true,
                  prefixIcon: Icons.lock_outline_rounded,
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyElevatedButton1(
                  ctx: context,
                  title: "Continue",
                  onPressed: () async {
                    // validate the form

                    if (newPasswordController.text.isEmpty ||
                        confirmPasswordController.text.isEmpty) {
                      // show error message
                      return;
                    }
                    if (!CalculatingFunction.isStrongPassword(
                        newPasswordController.text)) {
                      Fluttertoast.showToast(
                          msg:
                              "Password should contain at least 8 characters, 1 uppercase, 1 lowercase, 1 number and 1 special character",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    }
                    if (newPasswordController.text !=
                        confirmPasswordController.text) {
                      Fluttertoast.showToast(
                          msg: "Passwords do not match",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    }
                    // call the api
                    ApiResponse message = await UserServices.changePassword(
                        oldPassword: null,
                        newPassword: newPasswordController.text);

                    if (message.data["success"] == true) {
                      Fluttertoast.showToast(
                          msg: message.data["message"],
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const GetInitPage()),
                          (route) => false);
                    } else {
                      Fluttertoast.showToast(
                          msg: message.data["message"],
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
