import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../const/const.dart';

class CachedNetworkImageCirclePhoto extends StatelessWidget {
  const CachedNetworkImageCirclePhoto(
      {super.key,
      required this.photoUrl,
      required this.photoRadius,
      this.border});
  final String photoUrl;
  final double photoRadius;
  final double? border;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: photoRadius,
      height: photoRadius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: border ?? 0,
        ),
      ),
      child: CachedNetworkImage(
        imageBuilder: (context, imageProvider) => Container(
          width: photoRadius,
          height: photoRadius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        imageUrl: photoUrl,
        errorWidget: (context, url, error) => Container(
          width: photoRadius,
          height: photoRadius,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(AssetsPath.noImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
