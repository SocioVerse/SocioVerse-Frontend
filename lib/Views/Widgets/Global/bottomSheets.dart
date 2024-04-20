import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socioverse/Services/report_services.dart';

class ReportBottomSheet {
  String reportType;
  BuildContext context;
  String userId;
  String? feedId;
  String? threadId;
  String? storyId;

  // Report Story
  List<String> reportStoryOptions = [
    "Inappropriate Content",
    "Misleading Information",
    "Violates Community Guidelines",
    "Spam or Scam",
  ];

// Report Thread
  List<String> reportThreadOptions = [
    "Offensive Comments",
    "Bullying or Harassment",
    "Inappropriate Topic",
    "Thread Hijacking",
  ];

// Report Post
  List<String> reportPostOptions = [
    "Hate Speech or Discrimination",
    "Violent or Graphic Content",
    "Copyright Infringement",
    "Fake News",
  ];

// Report User
  List<String> reportUserOptions = [
    "Impersonation or Fake Account",
    "Abusive Behavior",
    "Inappropriate Profile Content",
    "Suspicious Activity",
  ];
  List<String> getList() {
    switch (reportType) {
      case "Story":
        return reportStoryOptions;
      case "Thread":
        return reportThreadOptions;
      case "Feed":
        return reportPostOptions;
      case "User":
        return reportUserOptions;
      default:
        return [];
    }
  }

  showReportBottomSheet() {
    List<String> reportOptions = getList();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.horizontal_rule_rounded,
              size: 50,
              color: Theme.of(context).colorScheme.secondary,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: reportOptions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    reportOptions[index],
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 16,
                        ),
                  ),
                  onTap: () async {
                    await ReportServices()
                        .createReport(
                          reportType: reportType,
                          reason: reportOptions[index],
                          userId: userId,
                          feedId: feedId,
                          threadId: threadId,
                          storyId: storyId,
                        )
                        .then((value) => Fluttertoast.showToast(
                              msg: "Reported Successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              fontSize: 16.0,
                            ));
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  ReportBottomSheet(
      {required this.reportType,
      required this.context,
      required this.userId,
      this.feedId,
      this.threadId,
      this.storyId});
}
