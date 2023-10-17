import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
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
              ListTile(
                leading: Icon(
                  Ionicons.person_outline,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                title: Text(
                  "Account",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                trailing: Icon(
                  Ionicons.chevron_forward_outline,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(
                  Ionicons.chatbubble_ellipses_outline,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                title: Text(
                  "Chats",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                trailing: Icon(
                  Ionicons.chevron_forward_outline,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(
                  Ionicons.notifications_outline,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                title: Text(
                  "Notifications",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                trailing: Icon(
                  Ionicons.chevron_forward_outline,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(
                  Ionicons.lock_closed_outline,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                title: Text(
                  "Privacy",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                trailing: Icon(
                  Ionicons.chevron_forward_outline,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(
                  Ionicons.help_outline,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                title: Text(
                  "Help",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                trailing: Icon(
                  Ionicons.chevron_forward_outline,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
