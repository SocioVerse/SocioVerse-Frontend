import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Pages/SocioVerse/MainPage.dart';
import 'package:socioverse/Pages/NavbarScreens/feedPage.dart';

import '../../Widgets/buttons.dart';

class FillProfilePage extends StatefulWidget {
  const FillProfilePage({super.key});

  @override
  State<FillProfilePage> createState() => _FillProfilePageState();
}

class _FillProfilePageState extends State<FillProfilePage> {
  TextEditingController fullName = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController cCode = TextEditingController();
  TextEditingController occupation = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cCode.text = "+91";
  }

  TextField textFieldBuilder(
      {required TextEditingController tcontroller,
      required String hintTexxt,
      required Function onChangedf,
      Widget? suffixxIcon}) {
    return TextField(
      controller: tcontroller,
      onChanged: (value) {
        onChangedf();
      },
      cursorOpacityAnimates: true,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontSize: 16, color: Theme.of(context).colorScheme.surface),
      maxLines: 1,
      decoration: InputDecoration(
        suffixIcon: suffixxIcon,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fill Profile Details",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: 25,
              ),
        ),
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 150,
                            backgroundColor:
                                Theme.of(context).colorScheme.onBackground,
                            child: Icon(
                              Ionicons.person,
                              color: Theme.of(context).colorScheme.background,
                              size: 100,
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Theme.of(context).colorScheme.shadow,
                                size: 30,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  textFieldBuilder(
                      tcontroller: fullName,
                      hintTexxt: "Full Name",
                      onChangedf: () {}),
                  SizedBox(
                    height: 20,
                  ),
                  textFieldBuilder(
                      tcontroller: username,
                      hintTexxt: "Username",
                      onChangedf: () {}),
                  SizedBox(
                    height: 20,
                  ),
                  textFieldBuilder(
                    tcontroller: email,
                    hintTexxt: "Email",
                    onChangedf: () {},
                    suffixxIcon: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Icon(
                        Icons.email,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: textFieldBuilder(
                              tcontroller: cCode,
                              hintTexxt: "+91",
                              onChangedf: () {})),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 5,
                        child: textFieldBuilder(
                          tcontroller: phone,
                          hintTexxt: "Phone number",
                          onChangedf: () {},
                          suffixxIcon: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Icon(
                              Icons.phone,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  textFieldBuilder(
                      tcontroller: occupation,
                      hintTexxt: "Occupation",
                      onChangedf: () {}),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 10, left: 8, right: 8, top: 0),
              child: MyElevatedButton1(
                  title: "Continue",
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => MainPage(),
                      ),
                      (route) => route
                          .isFirst, // Remove all routes until the first route (initial route)
                    );
                  },
                  ctx: context),
            ),
          ),
        ],
      ),
    );
  }
}
