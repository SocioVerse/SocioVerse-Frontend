import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Models/searchedUser.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Views/Widgets/textfield_widgets.dart';
import 'package:socioverse/Services/search_bar_services.dart';

class TagPeoplePage extends StatefulWidget {
  final List<SearchedUser>? taggedUser;
  const TagPeoplePage({Key? key, this.taggedUser}) : super(key: key);

  @override
  State<TagPeoplePage> createState() => _TagPeoplePageState();
}

class _TagPeoplePageState extends State<TagPeoplePage> {
  List<SearchedUser> searchedUser = [];
  List<SearchedUser> selectedUser = [];
  TextEditingController searchText = TextEditingController();
  bool isSearching = false;
  @override
  void initState() {
    if (widget.taggedUser != null) {
      selectedUser = widget.taggedUser!;
    }
    super.initState();
  }

  void getQueryUser() async {
    setState(() {
      isSearching = true;
    });
    if (searchText.text.trim().isNotEmpty) {
      searchedUser = await SearchBarServices()
          .fetchSearchedUser(searchQuery: searchText.text);
    }
    setState(() {
      isSearching = false;
    });
  }

  ListTile personListTile({
    required SearchedUser user,
  }) {
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
          value:
              selectedUser.where((element) => element.id == user.id).isNotEmpty,
          onChanged: (value) {
            setState(() {
              if (value!) {
                selectedUser.add(user);
              } else {
                selectedUser.removeWhere((element) => element.id == user.id);
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
              Navigator.pop(context, selectedUser);
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
                    hintTexxt: "Search User...",
                    onChangedf: () {
                      getQueryUser();
                    },
                    prefixxIcon: Icon(
                      Ionicons.search,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                selectedUser.isEmpty
                    ? const SizedBox.shrink()
                    : SizedBox(
                        height: 40,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedUser.length,
                          itemBuilder: (context, index) {
                            return Chip(
                              label: Text(selectedUser[index].name,
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
                                  selectedUser.removeWhere((element) =>
                                      element.id == selectedUser[index].id);
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
                    : searchedUser.isEmpty
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
                            itemCount: searchedUser.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(children: [
                                personListTile(
                                  user: searchedUser[index],
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
