import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Utils/calculatingFunctions.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/Hashtag/hashtagModels.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/Hashtag/hashtagsServices.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Views/Widgets/textfield_widgets.dart';
import 'package:socioverse/services/search_bar_services.dart';

class SearchHashtagPage extends StatefulWidget {
  final List<HashtagsSearchModel>? hashtagList;
  const SearchHashtagPage({Key? key, this.hashtagList}) : super(key: key);

  @override
  State<SearchHashtagPage> createState() => _SearchHashtagPageState();
}

class _SearchHashtagPageState extends State<SearchHashtagPage> {
  List<HashtagsSearchModel> searchedHashtags = [];
  List<HashtagsSearchModel> selectedHashtags = [];
  TextEditingController searchText = TextEditingController();
  bool isSearching = false;
  @override
  void initState() {
    if (widget.hashtagList != null) {
      selectedHashtags = widget.hashtagList!;
    }
    super.initState();
  }

  void getQueryhashtag() async {
    setState(() {
      isSearching = true;
    });
    if (searchText.text.trim().isNotEmpty) {
      searchedHashtags =
          await HashtagsServices().getHashtags(hashtag: searchText.text);
    } else {
      searchedHashtags.clear();
    }

    if (searchedHashtags
            .where((element) => element.hashtag == searchText.text.trim())
            .isEmpty &&
        searchText.text.trim().isNotEmpty) {
      searchedHashtags.insert(
        0,
        HashtagsSearchModel(
          id: UniqueKey().toString(),
          hashtag: searchText.text.trim(),
          postCount: 0,
        ),
      );
    }
    setState(() {
      isSearching = false;
    });
  }

  ListTile hashtagsTile({required HashtagsSearchModel hashtag}) {
    return ListTile(
        leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Icon(
              Icons.tag,
              color: Theme.of(context).colorScheme.onPrimary,
            )),
        title: Text(
          hashtag.hashtag,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            hashtag.postCount < 100
                ? hashtag.postCount <= 1
                    ? "${hashtag.postCount} Post"
                    : "${hashtag.postCount} Posts"
                : "${CalculatingFunction.numberToMkConverter(hashtag.postCount.toDouble())} Posts",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 14,
                ),
          ),
        ),
        trailing: Checkbox(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
          side: MaterialStateBorderSide.resolveWith((states) => BorderSide(
                width: 1.0,
                color: Theme.of(context).colorScheme.tertiary,
              )),
          value: selectedHashtags
              .where((element) => element.hashtag == hashtag.hashtag)
              .isNotEmpty,
          onChanged: (value) {
            setState(() {
              if (value!) {
                selectedHashtags.add(hashtag);
              } else {
                selectedHashtags.removeWhere(
                    (element) => element.hashtag == hashtag.hashtag);
              }
            });
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Hashtags",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
        ),
        toolbarHeight: 50,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, selectedHashtags);
            },
            child: Text(
              "Done",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFieldBuilder(
                    tcontroller: searchText,
                    hintTexxt: "Search Hashtags...",
                    onChangedf: () {
                      getQueryhashtag();
                    },
                    prefixxIcon: Icon(
                      Ionicons.search,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                selectedHashtags.isEmpty
                    ? const SizedBox.shrink()
                    : SizedBox(
                        height: 40,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedHashtags.length,
                          itemBuilder: (context, index) {
                            return Chip(
                              label: Text(selectedHashtags[index].hashtag,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: 12,
                                      )),
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              onDeleted: () {
                                setState(() {
                                  selectedHashtags.removeWhere((element) =>
                                      element.id == selectedHashtags[index].id);
                                });
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                        ),
                      ),
                const SizedBox(height: 5),
                isSearching
                    ? Column(
                        children: [
                          const SizedBox(height: 20),
                          Center(
                            child: SpinKitRing(
                              color: Theme.of(context).colorScheme.tertiary,
                              lineWidth: 1,
                              duration: const Duration(seconds: 1),
                            ),
                          ),
                        ],
                      )
                    : searchedHashtags.isEmpty
                        ? const Column(
                            children: [
                              SizedBox(height: 20),
                              Center(
                                child: Text("No hashtag Found"),
                              ),
                            ],
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: searchedHashtags.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(children: [
                                hashtagsTile(
                                  hashtag: searchedHashtags[index],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ]);
                            },
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
