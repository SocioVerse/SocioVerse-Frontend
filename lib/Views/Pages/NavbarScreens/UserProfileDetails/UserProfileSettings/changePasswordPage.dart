import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Services/user_services.dart';
import 'package:socioverse/Utils/CalculatingFunctions.dart';
import 'package:socioverse/Utils/Validators.dart';
import 'package:socioverse/Views/Widgets/buttons.dart';
import 'package:socioverse/Views/Widgets/textfield_widgets.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Change Password",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
          ),
          toolbarHeight: 60,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  CustomInputField(
                    controller: currentPasswordController,
                    hintText: "Current Password",
                    obscureText: true,
                    prefixIcon: Icons.lock_outline_rounded,
                  ),

                  // new password

                  const SizedBox(
                    height: 20,
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
                ],
              ),
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: MyElevatedButton1(
                    title: "Change Password",
                    onPressed: () async {
                      // validate the form

                      if (currentPasswordController.text.isEmpty ||
                          newPasswordController.text.isEmpty ||
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
                          oldPassword: currentPasswordController.text,
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
                        Navigator.pop(context);
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
                    ctx: context),
              ),
            )
          ],
        ));
  }
}
