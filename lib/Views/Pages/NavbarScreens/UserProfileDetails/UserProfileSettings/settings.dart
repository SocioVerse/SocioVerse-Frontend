import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/UserProfileSettings/changePasswordPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/UserProfileSettings/deleteAccountPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/UserProfileSettings/helpSuppoertPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/UserProfileSettings/storyHideSettingsPage.dart';
import 'package:socioverse/Views/Widgets/Global/alertBoxes.dart';
import 'package:socioverse/Views/Widgets/textfield_widgets.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  bool isSwitched = false;
  TextEditingController currentPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
        ),
        toolbarHeight: 60,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),

              // Notification Switch
              _customSettingTile(
                context,
                title: "Notifications",
                icon: Icons.notifications_outlined,
                onTap: () {
                  setState(() {
                    isSwitched = !isSwitched;
                  });
                },
                trailing: Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              // Hide Story Settings
              _customSettingTile(
                context,
                title: "Story Hide Settings",
                icon: Icons.visibility_off_outlined,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return StoryHideSettingsPage();
                  }));
                },
              ),
              //change password
              _customSettingTile(
                context,
                title: "Change Password",
                icon: Icons.lock_outline,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ChangePasswordPage();
                  }));
                },
              ),

              //delete account
              _customSettingTile(
                context,
                title: "Delete Account",
                icon: Icons.delete_outline,
                onTap: () {
                  AlertBoxes.acceptRejectAlertBox(
                    onReject: () {},
                    context: context,
                    title: "Delete Account",
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Are you sure you want to delete your account? This action cannot be undone",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),

                        // current password

                        const SizedBox(
                          height: 20,
                        ),

                        CustomInputField(
                          controller: currentPasswordController,
                          hintText: "Current Password",
                          obscureText: true,
                          prefixIcon: Icons.lock_outline_rounded,
                        )
                      ],
                    ),
                    onAccept: () {},
                  );
                },
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _customSettingTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Function onTap,
    Color? color,
    Widget? trailing,
  }) {
    return ListTile(
      onTap: () {
        onTap();
      },
      leading: Icon(
        icon,
        color: color ?? Theme.of(context).colorScheme.onPrimary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 17,
              color: color ?? Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      trailing: trailing ??
          Icon(
            Ionicons.chevron_forward_outline,
            color: color ?? Theme.of(context).colorScheme.onPrimary,
          ),
    );
  }
}
