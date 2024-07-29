import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../loading/shimmer_container.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  final Widget Function(BuildContext, String)? placeholder;
  final double? height;
  final Map<String, String>? headers;

  const CachedNetworkImageWidget(
      {super.key, required this.imageUrl, this.fit, this.errorWidget, this.placeholder, this.height, this.headers});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      cacheManager: CacheManager(Config('image-cache-key')),
      placeholder: placeholder,
      errorWidget: errorWidget,
      progressIndicatorBuilder: (context, url, progress) => ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 100, maxWidth: 100),
        child: const ShimmerContainer(),
      ),
      height: height,
      httpHeaders: headers,
    );
  }
}
