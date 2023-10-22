import 'package:socioverse/Utils/CountryList.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../Widgets/buttons.dart';

class SelectCountryPage extends StatefulWidget {
  const SelectCountryPage({super.key});

  @override
  State<SelectCountryPage> createState() => _SelectCountryPageState();
}

class _SelectCountryPageState extends State<SelectCountryPage> {
  TextEditingController searchCountry = TextEditingController();
  int selectCountry = 0;
  late List<MapEntry<String, String>> CountryList;
  @override
  void initState() {
    super.initState();
    selectCountry = 0;
    CountryList = Country.entries.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 0),
        child: MyElevatedButton1(
            title: "Continue", onPressed: () {}, ctx: context),
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
            TextField(
              controller: searchCountry,
              onChanged: (value) {
                setState(() {
                  CountryList = Country.entries
                      .where((element) => element.value
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
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
            ),
            SizedBox(
              height: 20,
            ),
            CountryList.length != 0
                ? Expanded(
                    child: ListView.builder(
                      itemCount: CountryList.length,
                      itemBuilder: (context, index) {
                        String path =
                            "assets/Country_flag/${CountryList[index].key.toLowerCase()}.png";
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListTile(
                            onTap: () => {
                              setState(() {
                                selectCountry = index;
                              })
                            },
                            shape: RoundedRectangleBorder(
                              //<-- SEE HERE
                              side: selectCountry == index
                                  ? BorderSide(
                                      width: 2,
                                      color:
                                          Theme.of(context).colorScheme.primary)
                                  : BorderSide(width: 0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            contentPadding: EdgeInsets.all(20),
                            tileColor: Theme.of(context).colorScheme.secondary,
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
                                  CountryList[index].key,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 16,
                                      ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  CountryList[index].value,
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
                  ),
          ],
        ),
      ),
    );
  }
}

class Ionicon {}
