import 'dart:io' show Platform;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show CircularProgressIndicator;

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    Key? key,
    required this.imageUrl,
    this.borderRadius,
    this.placeholder,
    this.height,
    this.width,
    this.fit,
  }) : super(key: key);

  final String imageUrl;
  final double? borderRadius;
  final Widget? placeholder;
  final double? height;
  final double? width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    final _platformPlaceholder = Platform.isIOS
        ? const CupertinoActivityIndicator()
        : const CircularProgressIndicator();

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => placeholder ?? _platformPlaceholder,
        height: height,
        width: width,
        fit: fit,
      ),
    );
  }
}
