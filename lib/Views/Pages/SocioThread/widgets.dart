import 'package:flutter/material.dart';
import 'package:socioverse/Models/threadModel.dart';

class UserProfileImageStackOf2 extends StatelessWidget {
  List<CommentUser>? commentUserProfilePic;

  final bool isShowIcon;

  UserProfileImageStackOf2({
    this.commentUserProfilePic,
    required this.isShowIcon,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      height: 20,
      width: 41,
      child: Stack(
        children: [
          ReplyUserProfileImage(
            rightPadding: 10.5,
            userProfileImagePath: commentUserProfilePic![0].profilePic,
          ),
          ReplyUserProfileImage(
            rightPadding: 0.5,
            userProfileImagePath: commentUserProfilePic![1].profilePic,
          ),
          isShowIcon
              ? Positioned(
                  right: 0,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: Colors.black87,
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                      size: 18.5,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

class ReplyUserProfileImage extends StatelessWidget {
  const ReplyUserProfileImage({
    required this.userProfileImagePath,
    required this.rightPadding,
    super.key,
  });

  final double rightPadding;
  final String userProfileImagePath;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: rightPadding,
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black87,
            width: 2,
          ),
        ),
        child: ClipOval(
          child: Image.network(
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            userProfileImagePath,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
