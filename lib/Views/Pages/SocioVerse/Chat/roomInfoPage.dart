import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Models/chatModels.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfilePage.dart';
import 'package:socioverse/Models/inboxModel.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';

class RoomInfoPage extends StatefulWidget {
  final List<Message> inboxModelList;
  final User user;

  const RoomInfoPage(
      {super.key, required this.user, required this.inboxModelList});

  @override
  State<RoomInfoPage> createState() => _RoomInfoPageState();
}

class _RoomInfoPageState extends State<RoomInfoPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _outlineBox(
      {required String text,
      required IconData icon,
      Color? color,
      Function()? onTap}) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: color ?? Theme.of(context).colorScheme.tertiary,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color ?? Theme.of(context).colorScheme.onPrimary,
              size: 25,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w200,
                    fontSize: 15,
                    color: color ?? Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Align(
            alignment: Alignment.topCenter,
            child: AppBar(
              title: Text(
                widget.user.username,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 23,
                    ),
              ),
              toolbarHeight: 70,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: CircleAvatar(
              radius: 75,
              backgroundColor: Theme.of(context).colorScheme.onBackground,
              child: CircularNetworkImageWithoutSize(
                imageUrl: widget.user.profilePic,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.user.name,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 26,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.user.occupation,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfilePage(
                              userId: widget.user.id,
                            )));
              },
              child: Text(
                "View Profile",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary),
              )),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Divider(
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
            ),
          ),

          //Media

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  Ionicons.images_outline,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 25,
                ),
              ),
              Text(
                "Media",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 20,
            ),
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: widget.inboxModelList.length,
                itemBuilder: (context, index) {
                  return widget.inboxModelList[index].image != null
                      ? RoundedNetworkImageWithLoading(
                          imageUrl: widget.inboxModelList[index].image ?? "",
                          borderRadius: 5,
                        )
                      : const SizedBox();
                }),
          )
        ]),
      ),
    );
  }
}
