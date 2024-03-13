import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/locationModel.dart';
import 'package:socioverse/Services/location_services.dart';
import 'package:socioverse/Views/Widgets/textfield_widgets.dart';

class LocationSearchPage extends StatefulWidget {
  const LocationSearchPage({super.key});

  @override
  State<LocationSearchPage> createState() => _LocationSearchPageState();
}

class _LocationSearchPageState extends State<LocationSearchPage> {
  List<LocationSearchModel> searchedLocation = [];
  TextEditingController searchText = TextEditingController();
  bool isSearching = false;
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void getQueryLocation() async {
    setState(() {
      isSearching = true;
    });
    if (searchText.text.trim().isNotEmpty) {
      searchedLocation =
          await LocationServices().getLocation(location: searchText.text);
    }
    setState(() {
      isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: TextFieldBuilder(
                  tcontroller: searchText,
                  hintTexxt: "Search Location...",
                  onChangedf: () {
                    getQueryLocation();
                  },
                  prefixxIcon: Icon(
                    Ionicons.search,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              isSearching
                  ? Center(
                      child: SpinKit.ring,
                    )
                  : searchedLocation.isEmpty
                      ? const Center(
                          child: Text("No Location Found"),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: searchedLocation.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                Navigator.pop(context, searchedLocation[index]);
                              },
                              leading: CircleAvatar(
                                radius: 40,
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                child: const Center(
                                  child: Icon(
                                    Ionicons.location,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              title: Text(
                                searchedLocation[index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 16),
                              ),
                              subtitle: Text(
                                "${searchedLocation[index].state} ${searchedLocation[index].country}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 16),
                              ),
                            );
                          },
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
