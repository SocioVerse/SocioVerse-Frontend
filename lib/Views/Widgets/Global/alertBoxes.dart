import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AlertBoxes {
  static void acceptRejectAlertBox({
    required BuildContext context,
    required String title,
    required Function onAccept,
    required Function onReject,
    required Widget content,
    String? acceptTitle,
    String? rejectTitle,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: AlertDialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              actionsPadding: EdgeInsets.all(20),
              surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
              title: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(title,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 20,
                              )),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Ionicons.close,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ],
              ),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            side: BorderSide(
                                width: 1,
                                color: Theme.of(context).colorScheme.primary,
                                style: BorderStyle.solid),
                          ),
                          onPressed: () {
                            onAccept();
                          },
                          child: Text(
                            acceptTitle ?? 'Yes',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            onReject();
                          },
                          child: Text(rejectTitle ?? 'No',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              content: content,
            ),
          );
        });
  }
 

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  static void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
