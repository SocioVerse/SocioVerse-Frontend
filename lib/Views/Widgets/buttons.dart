import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socioverse/Services/follow_unfollow_services.dart';
import '../Pages/Authentication/passwordSignUpPage.dart';

Widget MyElevatedButton1(
    {required String title,
    required Function onPressed,
    required BuildContext ctx}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () async {
        onPressed();
      },
      child: Text(title,
          style: GoogleFonts.openSans(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Theme.of(ctx).colorScheme.onPrimary),
          textAlign: TextAlign.center),
    ),
  );
}

class CustomOutlineButton extends StatefulWidget {
  String? title;
  Function? onPressed;
  BuildContext? ctx;
  Widget? iconButton1;
  double? width1;
  double? fontSize;
  CustomOutlineButton(
      {this.title,
      this.onPressed,
      this.ctx,
      this.iconButton1,
      this.width1,
      this.fontSize});

  @override
  State<CustomOutlineButton> createState() => _CustomOutlineButtonState();
}

class _CustomOutlineButtonState extends State<CustomOutlineButton> {
  String? rtitle;
  Widget? riconButton;
  @override
  void initState() {
    super.initState();
    rtitle = widget.title;
    riconButton = widget.iconButton1;
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width1 ?? 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
        ),
        onPressed: () {
          widget.onPressed!();
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              riconButton ?? const SizedBox(),
              Text("${rtitle}",
                  style: GoogleFonts.openSans(
                      fontSize: widget.fontSize ?? 15,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(widget.ctx!).colorScheme.primary),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

class MyEleButtonsmall extends StatefulWidget {
  String? title;
  String? title2;
  Function? onPressed;

  BuildContext? ctx;
  IconButton? iconButton1;
  IconButton? iconButton2;
  double? width1;
  double? width2;
  bool? ispressed;
  double? fontSize;
  MyEleButtonsmall(
      {this.title,
      this.onPressed,
      this.ctx,
      this.title2,
      this.iconButton1,
      this.iconButton2,
      this.width1,
      this.width2,
      this.ispressed,
      this.fontSize});

  @override
  State<MyEleButtonsmall> createState() => _MyEleButtonsmallState();
}

class _MyEleButtonsmallState extends State<MyEleButtonsmall> {
  bool _ispressed = false;

  String? rtitle;
  IconButton? riconButton;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rtitle = widget.title;
    riconButton = widget.iconButton1;
    _ispressed = widget.ispressed ?? false;
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _ispressed ? widget.width1 ?? 100 : widget.width2 ?? 80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: !_ispressed
              ? Theme.of(widget.ctx!).colorScheme.primary
              : Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: riconButton == null ? 5 : 0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: Theme.of(widget.ctx!).colorScheme.primary,
                width: 2,
              )),
        ),
        onPressed: () {
          _ispressed = !_ispressed;
          if (rtitle == widget.title) {
            rtitle = widget.title2;
            riconButton = widget.iconButton2;
          } else {
            rtitle = widget.title;
            riconButton = widget.iconButton1;
          }
          setState(() {});
          widget.onPressed!();
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              riconButton ?? const SizedBox(),
              Text("$rtitle",
                  style: GoogleFonts.openSans(
                      fontSize: widget.fontSize ?? 15,
                      fontWeight: FontWeight.w600,
                      color: _ispressed
                          ? Theme.of(widget.ctx!).colorScheme.primary
                          : Theme.of(widget.ctx!).colorScheme.onPrimary),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final VoidCallback onPressed;

  const SocialMediaButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 10),
            Text(
              text,
              style: GoogleFonts.openSans(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ToggleFollowButton extends StatefulWidget {
  final int state;
  final String userId;

  const ToggleFollowButton(
      {super.key, required this.state, required this.userId});

  @override
  _ToggleFollowButtonState createState() => _ToggleFollowButtonState();
}

class _ToggleFollowButtonState extends State<ToggleFollowButton> {
  int state = 0;
  @override
  void initState() {
    state = widget.state;
    super.initState();
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    String ttl1;
    String ttl2;
    bool isPressed;

    if (state == 0) {
      ttl1 = "Follow";
      ttl2 = "Requested";
      isPressed = false;
    } else if (state == 2) {
      ttl1 = "Following";
      ttl2 = "Follow";
      isPressed = true;
    } else {
      ttl1 = "Requested";
      ttl2 = "Follow";
      isPressed = true;
    }
    log("state: $state");

    return _isLoading
        ? SizedBox(
            width: 30,
            height: 10,
            child: Center(
              child: SpinKitThreeBounce(
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
            ),
          )
        : MyEleButtonsmall(
            title2: ttl2,
            title: ttl1,
            ctx: context,
            ispressed: isPressed,
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              if (state == 2) {
                await FollowUnfollowServices.unFollow(
                  userId: widget.userId,
                );
                state = 0;
              } else {
                await FollowUnfollowServices.toggleFollow(
                  userId: widget.userId,
                );
                state = state == 1 ? 0 : 1;
              }
              setState(() {
                _isLoading = false;
              });
            },
          );
  }
}
