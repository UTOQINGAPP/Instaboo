import 'dart:io';
import 'package:flutter/material.dart';

// ImageComponentShared is a reusable widget that displays an image from either a local asset or a file.
// It adapts to different image sources dynamically and provides default styling such as width, height, and fit.
// If the provided image source is invalid or unsupported, it shows a placeholder with a "not supported" icon.


class ImageComponentShared extends StatelessWidget {
  final dynamic imageSource; // Puede ser String (asset) o File (local)
  final double width;
  final double height;
  final BoxFit fit;

  const ImageComponentShared({
    super.key,
    required this.imageSource,
    this.width = 140,
    this.height = 140,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (imageSource is String) {
      return Image.asset(
        imageSource,
        width: width,
        height: height,
        fit: fit,
      );
    } else if (imageSource is File) {
      return Image.file(
        imageSource,
        width: width,
        height: height,
        fit: fit,
      );
    } else {
      return Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: const Center(child: Icon(Icons.image_not_supported)),
      );
    }
  }
}
