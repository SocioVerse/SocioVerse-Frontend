import 'package:flutter/material.dart';

class TextFieldBuilder extends StatelessWidget {
  TextEditingController tcontroller;
  String hintTexxt;
  Function onChangedf;
  Widget? prefixxIcon;
  TextFieldBuilder({
    required this.tcontroller,
    required this.hintTexxt,
    required this.onChangedf,
    this.prefixxIcon,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: tcontroller,
      onChanged: (value) {
        onChangedf();
        print(tcontroller.text);
      },
      cursorOpacityAnimates: true,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontSize: 16, color: Theme.of(context).colorScheme.surface),
      maxLines: 1,
      decoration: InputDecoration(
        prefixIcon: prefixxIcon,
        contentPadding: EdgeInsets.all(20),
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        hintText: hintTexxt,
        hintStyle:
            Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        focusColor: Theme.of(context).colorScheme.primary,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

class TextFieldBuilder2 extends StatelessWidget {
  TextEditingController tcontroller;
  String hintTexxt;
  Function onChangedf;
  Widget? prefixxIcon;
  int maxLines; // Add this property for controlling maxLines

  TextFieldBuilder2({
    required this.tcontroller,
    required this.hintTexxt,
    required this.onChangedf,
    this.prefixxIcon,
    this.maxLines = 1, // Default maxLines to 1
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: null,
      controller: tcontroller,
      onChanged: (value) {
        onChangedf();
        print(tcontroller.text);
      },
      cursorOpacityAnimates: true,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontSize: 16, color: Theme.of(context).colorScheme.surface),
      // Allow the widget to expand vertically
      decoration: InputDecoration(
        prefixIcon: prefixxIcon,
        contentPadding: EdgeInsets.all(20),
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        hintText: hintTexxt,
        hintStyle:
            Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        focusColor: Theme.of(context).colorScheme.primary,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
