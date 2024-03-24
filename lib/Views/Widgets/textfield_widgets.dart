import 'package:flutter/material.dart';

class TextFieldBuilder extends StatelessWidget {
  TextEditingController tcontroller;
  String hintTexxt;
  Function onChangedf;
  Widget? prefixxIcon;
  Widget? suffixIcon;
  TextFieldBuilder({
    required this.tcontroller,
    required this.hintTexxt,
    required this.onChangedf,
    this.prefixxIcon,
    this.suffixIcon,
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
        suffixIcon: suffixIcon,
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
  int? maxLines; // Add this property for controlling maxLines

  TextFieldBuilder2({
    required this.tcontroller,
    required this.hintTexxt,
    required this.onChangedf,
    this.prefixxIcon,
    this.maxLines, // Default maxLines to 1
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: 5,
      maxLines: maxLines,
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

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorOpacityAnimates: true,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 16,
            color: Theme.of(context).colorScheme.surface,
          ),
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Icon(
            prefixIcon,
            size: 20,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                padding: const EdgeInsets.only(right: 20),
                onPressed: () {
                  if (suffixIcon != null && onChanged != null) {
                    onChanged!('');
                  }
                },
                icon: suffixIcon!,
              )
            : null,
        fillColor: Theme.of(context).colorScheme.secondary,
        hintText: hintText,
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
