import 'package:flutter/material.dart';

import 'cached_network_image_widget.dart';

class CharacterAvatar extends StatelessWidget {
  const CharacterAvatar({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return CachedNetworkImageWidget(
      imageUrl: imageUrl,
      errorWidget: (p0, p1, p2) => Icon(
        Icons.account_circle,
        color: colorScheme.onSecondaryFixed.withOpacity(0.25),
        size: 110,
      ),
    );
  }
}
