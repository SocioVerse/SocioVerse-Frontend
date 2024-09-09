import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/hashtagPostEditProvider.dart';
import 'package:socioverse/Controllers/postEditingProvider.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Utils/CalculatingFunctions.dart';
import 'package:socioverse/Models/hashtagModels.dart';
import 'package:socioverse/Services/hashtags_services.dart';
import 'package:socioverse/Views/Pages/SocioVerse/hashtagProfilePage.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Views/Widgets/textfield_widgets.dart';
import 'package:socioverse/Services/search_bar_services.dart';

class SearchHashtagPage extends StatefulWidget {
  final List<HashtagsSearchModel>? hashtagList;
  const SearchHashtagPage({Key? key, this.hashtagList}) : super(key: key);

  @override
  State<SearchHashtagPage> createState() => _SearchHashtagPageState();
}

class _SearchHashtagPageState extends State<SearchHashtagPage> {
  TextEditingController searchText = TextEditingController();
  void getQueryhashtag(var loadingProv) async {
    loadingProv.isLoading = true;
    if (searchText.text.trim().isNotEmpty) {
      loadingProv.searchedHashtags =
          await HashtagsServices.getHashtags(hashtag: searchText.text);
    } else {
      loadingProv.clearHashtags();
    }

    if (loadingProv.searchedHashtags
            .where((element) => element.hashtag == searchText.text.trim())
            .isEmpty &&
        searchText.text.trim().isNotEmpty) {
      loadingProv.insertHashtag(searchText.text.trim());
    }
    loadingProv.isLoading = false;
  }

  Widget hashtagsTile({required HashtagsSearchModel hashtag}) {
    return Consumer<PostEditProvider>(builder: (context, prov, child) {
      return ListTile(
          onTap: () {},
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
            value: prov.hashtagList
                .where((element) => element.hashtag == hashtag.hashtag)
                .isNotEmpty,
            onChanged: (value) {
              if (value!) {
                prov.addHashtag(hashtag);
              } else {
                prov.removeHashtag(hashtag);
              }
            },
          ));
    });
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
              Navigator.pop(context);
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
                      getQueryhashtag(Provider.of<HashtagPageProvider>(context,
                          listen: false));
                    },
                    prefixxIcon: Icon(
                      Ionicons.search,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Consumer<PostEditProvider>(builder: (context, prov, child) {
                  return prov.hashtagList.isEmpty
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 40,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: prov.hashtagList.length,
                            itemBuilder: (context, index) {
                              return Chip(
                                label: Text(prov.hashtagList[index].hashtag,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize: 12,
                                        )),
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                deleteIconColor: Colors.white,
                                onDeleted: () {
                                  prov.removeHashtag(prov.hashtagList[index]);
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 10,
                              );
                            },
                          ),
                        );
                }),
                const SizedBox(height: 5),
                Consumer<HashtagPageProvider>(
                    builder: (context, loadingProv, child) {
                  return loadingProv.isLoading
                      ? Column(
                          children: [
                            const SizedBox(height: 20),
                            Center(
                              child: SpinKit.ring,
                            ),
                          ],
                        )
                      : loadingProv.searchedHashtags.isEmpty
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
                              itemCount: loadingProv.searchedHashtags.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Column(children: [
                                  hashtagsTile(
                                    hashtag:
                                        loadingProv.searchedHashtags[index],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ]);
                              },
                            );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
