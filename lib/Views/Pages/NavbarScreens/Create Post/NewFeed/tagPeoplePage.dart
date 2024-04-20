import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/postEditingProvider.dart';
import 'package:socioverse/Controllers/tagPeoplePageProvider.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/searchedUser.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Views/Widgets/textfield_widgets.dart';
import 'package:socioverse/Services/search_bar_services.dart';

class TagPeoplePage extends StatelessWidget {
  TagPeoplePage({Key? key}) : super(key: key);

  TextEditingController searchText = TextEditingController();

  void getQueryUser(var loadingProv) async {
    loadingProv.isLoading = true;
    if (searchText.text.trim().isNotEmpty) {
      loadingProv.searchedUser = await SearchBarServices()
          .fetchSearchedUser(searchQuery: searchText.text);
    } else {
      loadingProv.clearUsers();
    }
    loadingProv.isLoading = false;
  }

  Widget personListTile({
    required SearchedUser user,
  }) {
    return Consumer<PostEditProvider>(builder: (context, prov, child) {
      return ListTile(
          onTap: () {},
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40,
              width: 40,
              child: CircularNetworkImageWithSize(
                imageUrl: user.profilePic,
                height: 35,
                width: 35,
              ),
            ),
          ),
          title: Text(
            user.name,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          subtitle: Text(
            user.username,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
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
            value: prov.taggedUser
                .where((element) => element.id == user.id)
                .isNotEmpty,
            onChanged: (value) {
              if (value!) {
                prov.addTaggedUser(user);
              } else {
                prov.removeTaggedUser(user);
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
          "Tag People",
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
            child: Consumer<TagPeoplePageProvider>(
                builder: (context, loadingProv, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFieldBuilder(
                      tcontroller: searchText,
                      hintTexxt: "Search User...",
                      onChangedf: () {
                        getQueryUser(loadingProv);
                      },
                      prefixxIcon: Icon(
                        Ionicons.search,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Consumer<TagPeoplePageProvider>(
                      builder: (context, prov, child) {
                    return prov.searchedUser.isEmpty
                        ? const SizedBox.shrink()
                        : Consumer<PostEditProvider>(
                            builder: (context, prov, child) {
                            return prov.taggedUser.isEmpty
                                ? const SizedBox.shrink()
                                : SizedBox(
                                    height: 40,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: prov.taggedUser.length,
                                      itemBuilder: (context, index) {
                                        return Chip(
                                          label: Text(
                                              prov.taggedUser[index].name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontSize: 12,
                                                  )),
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          onDeleted: () {
                                            prov.removeTaggedUser(
                                                prov.taggedUser[index]);
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
                          });
                  }),
                  const SizedBox(height: 5),
                  loadingProv.isLoading
                      ? Column(
                          children: [
                            const SizedBox(height: 20),
                            Center(
                              child: SpinKit.ring,
                            ),
                          ],
                        )
                      : loadingProv.searchedUser.isEmpty
                          ? const Column(
                              children: [
                                SizedBox(height: 20),
                                Center(
                                  child: Text("No User Found"),
                                ),
                              ],
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: loadingProv.searchedUser.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Column(children: [
                                  personListTile(
                                    user: loadingProv.searchedUser[index],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ]);
                              },
                            ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
