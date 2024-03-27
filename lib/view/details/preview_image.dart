import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PreviewImage extends StatelessWidget {
  final String image;
  const PreviewImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InteractiveViewer(
          child: CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
