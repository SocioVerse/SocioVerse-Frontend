import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CircularNetworkImageWithoutSize extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;

  const CircularNetworkImageWithoutSize({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}

class CircularNetworkImageWithLoading extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;

  const CircularNetworkImageWithLoading({
    Key? key,
    required this.imageUrl,
    this.height = 8.5,
    this.width = 8.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}

class RoundedNetworkImageWithLoading extends StatelessWidget {
  final String imageUrl;
  final double borderRadius;
  final BoxFit fit;

  const RoundedNetworkImageWithLoading({
    Key? key,
    required this.imageUrl,
    this.borderRadius = 5,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
