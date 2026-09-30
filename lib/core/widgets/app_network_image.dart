import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// Network image with a grey placeholder when the url is missing or broken.
class AppNetworkImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final double radius;

  const AppNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.radius = 0,
  });

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      width: width,
      height: height,
      color: AppColors.cardFill,
      child: const Icon(Icons.newspaper, color: AppColors.textLightGrey),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: (url == null || url!.isEmpty)
          ? placeholder
          : Image.network(
              url!,
              width: width,
              height: height,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => placeholder,
            ),
    );
  }
}
