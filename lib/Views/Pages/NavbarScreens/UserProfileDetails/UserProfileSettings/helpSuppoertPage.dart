import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Help & Support",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
        ),
        toolbarHeight: 60,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Expanded(
        child: Stack(
          children: [
            SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "FAQs",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    subtitle: Text(
                      "Frequently Asked Questions",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                          ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Contact Us",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    subtitle: Text(
                      "Get in touch with us",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                          ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Report a Problem",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    subtitle: Text(
                      "Report a problem with the app",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                          ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Privacy Policy",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    subtitle: Text(
                      "Read our Privacy Policy",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                          ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Terms of Service",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    subtitle: Text(
                      "Read our Terms of Service",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                          ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
