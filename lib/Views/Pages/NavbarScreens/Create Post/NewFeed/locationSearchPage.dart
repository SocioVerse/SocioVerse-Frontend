import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/locationSearchPageProvider.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/locationModel.dart';
import 'package:socioverse/Services/location_services.dart';
import 'package:socioverse/Views/Widgets/textfield_widgets.dart';

class LocationSearchPage extends StatelessWidget {
  const LocationSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<LocationSearchProvider>(context, listen: false);
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
                  tcontroller: prov.searchText,
                  hintTexxt: "Search Location...",
                  onChangedf: () {
                    prov.getQueryLocation();
                  },
                  prefixxIcon: Icon(
                    Ionicons.search,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Consumer<LocationSearchProvider>(builder: (context, prov, child) {
                return prov.isSearching
                    ? Center(
                        child: SpinKit.ring,
                      )
                    : prov.searchedLocation.isEmpty
                        ? const Center(
                            child: Text("No Location Found"),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: prov.searchedLocation.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  Navigator.pop(
                                      context, prov.searchedLocation[index]);
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
                                  prov.searchedLocation[index].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 16),
                                ),
                                subtitle: Text(
                                  "${prov.searchedLocation[index].state} ${prov.searchedLocation[index].country}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 16),
                                ),
                              );
                            },
                          );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
