import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Pages/Authentication/passwordSignUpPage.dart';

Widget MyElevatedButton1(
    {required String title,
    required Function onPressed,
    required BuildContext ctx}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15),
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
  IconButton? iconButton1;
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
  IconButton? riconButton;
  @override
  void initState() {
    super.initState();
    rtitle = widget.title;
    riconButton = widget.iconButton1;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width1 ?? 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.all(2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
        ),
        onPressed: () {},
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              riconButton ?? SizedBox(),
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
          setState(() {
            _ispressed = !_ispressed;
            if (rtitle == widget.title) {
              rtitle = widget.title2;
              riconButton = widget.iconButton2;
            } else {
              rtitle = widget.title;
              riconButton = widget.iconButton1;
            }
          });
          widget.onPressed!();
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              riconButton ?? SizedBox(),
              Text("${rtitle}",
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
