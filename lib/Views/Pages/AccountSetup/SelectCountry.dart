import 'dart:developer';

import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/countryListPageProvider.dart';
import 'package:socioverse/Models/authUserModels.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Views/Pages/AccountSetup/fillProfileDetails.dart';

import '../../Widgets/buttons.dart';

class SelectCountryPage extends StatefulWidget {
  final SignupUser signupUser;
  SelectCountryPage({super.key, required this.signupUser});

  @override
  State<SelectCountryPage> createState() => _SelectCountryPageState();
}

class _SelectCountryPageState extends State<SelectCountryPage> {
  TextEditingController searchCountry = TextEditingController();
  int selectCountry = 0;
  @override
  void initState() {
    super.initState();
    selectCountry = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 0),
        child: Consumer<CountryListProvider>(builder: (context, prov, child) {
          return MyElevatedButton1(
              title: "Continue",
              onPressed: () {
                widget.signupUser.country =
                    prov.countryList[selectCountry].value;

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FillProfilePage(
                              signupUser: widget.signupUser,
                            )));
              },
              ctx: context);
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text(
          "Select Your Country",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: 25,
              ),
        ),
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Consumer<CountryListProvider>(builder: (context, prov, child) {
              return TextField(
                controller: searchCountry,
                onChanged: (value) {
                  prov.onChangedDSearch(value);
                },
                cursorOpacityAnimates: true,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16, color: Theme.of(context).colorScheme.surface),
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Icon(
                      Ionicons.search,
                      size: 20,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  fillColor: Theme.of(context).colorScheme.secondary,
                  hintText: "Search",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16),
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
            }),
            const SizedBox(
              height: 20,
            ),
            Consumer<CountryListProvider>(builder: (context, prov, child) {
              return prov.countryList.length != 0
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: prov.countryList.length,
                        itemBuilder: (context, index) {
                          String path =
                              "assets/Country_flag/${prov.countryList[index].key.toLowerCase()}.png";
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListTile(
                              onTap: () => {
                                setState(() {
                                  selectCountry = index;
                                })
                              },
                              shape: RoundedRectangleBorder(
                                side: selectCountry == index
                                    ? BorderSide(
                                        width: 2,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)
                                    : const BorderSide(width: 0),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              contentPadding: const EdgeInsets.all(20),
                              tileColor:
                                  Theme.of(context).colorScheme.secondary,
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor:
                                    Theme.of(context).colorScheme.background,
                                backgroundImage: AssetImage(
                                  path,
                                ),
                              ),
                              title: Wrap(
                                children: [
                                  Text(
                                    prov.countryList[index].key,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 16,
                                        ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    prov.countryList[index].value,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                  ),
                                ],
                              ),
                              trailing: Radio(
                                  value: index,
                                  activeColor:
                                      Theme.of(context).colorScheme.primary,
                                  groupValue: selectCountry,
                                  onChanged: (value) {
                                    setState(() {
                                      selectCountry = value!;
                                    });
                                  }),
                            ),
                          );
                        },
                      ),
                    )
                  : Text(
                      "No Country Found",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
