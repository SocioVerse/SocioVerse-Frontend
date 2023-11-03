import 'package:flutter/material.dart';

class UserProfileImageStackOf2 extends StatelessWidget {
  const UserProfileImageStackOf2({
    required this.isShowIcon,
    super.key,
  });
  final bool isShowIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 41,
      child: Stack(
        children: [
          ReplyUserProfileImage(
            rightPadding: 20.5,
            userProfileImagePath: 'assets/Country_flag/ad.png',
          ),
          ReplyUserProfileImage(
            rightPadding: 10.5,
            userProfileImagePath: 'assets/Country_flag/ad.png',
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
          child: Image.asset(
            userProfileImagePath,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
