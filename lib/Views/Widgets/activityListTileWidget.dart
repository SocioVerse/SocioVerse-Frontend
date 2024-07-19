import 'package:flutter/material.dart';
import 'package:socioverse/Utils/CalculatingFunctions.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Comment/commentPage.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';

class ActivityListTile extends StatelessWidget {
  final String profilePicUrl;
  final String username;
  final DateTime createdAt;
  final String? postImageUrl;
  final String subtitle;
  final Function? onTap;

  const ActivityListTile({
    Key? key,
    required this.profilePicUrl,
    required this.username,
    required this.createdAt,
    this.postImageUrl,
    required this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircularNetworkImageWithSize(
        imageUrl: profilePicUrl,
        height: 50,
        width: 50,
      ),
      title: Row(
        children: [
          Text(
            "$username  ",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          Text(
            CalculatingFunction.getTimeDiff(createdAt),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: SizedBox(
        width: 50,
        child: postImageUrl == null
            ? Container()
            : RoundedNetworkImageWithLoading(
                imageUrl: postImageUrl!,
                borderRadius: 10,
              ),
      ),
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
    );
  }
}
