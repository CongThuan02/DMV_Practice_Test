import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssetSvg extends StatelessWidget {
  const AssetSvg(this.path, {super.key, this.height, this.width});

  final String path;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      height: height,
      width: width,
      fit: BoxFit.contain,
      placeholderBuilder: (_) => SizedBox(height: height, width: width),
      errorBuilder: (_, _, _) => SizedBox(
        height: height,
        width: width,
        child: const Icon(Icons.image_not_supported_outlined),
      ),
    );
  }
}
