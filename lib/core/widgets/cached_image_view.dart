import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/assets.dart';

class CachedImageView extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? backgroundColor;
  final Widget? errorWidget;

  const CachedImageView({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.backgroundColor,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: backgroundColor ?? Theme.of(context).dividerColor,
      child: image == ''
          ? errorWidget ?? const ImageErrorView()
          : CachedNetworkImage(
              imageUrl: image,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: fit,
                  ),
                ),
              ),
              placeholder: (context, url) => const CupertinoActivityIndicator(),
              errorWidget: (context, url, error) {
                return errorWidget ?? const ImageErrorView();
              },
            ),
    );
  }
}

class ImageErrorView extends StatelessWidget {
  const ImageErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        double width = constraints.maxWidth != double.infinity ? constraints.maxWidth : 100;
        double height = constraints.maxHeight != double.infinity ? constraints.maxHeight : 100;
        return NoImage(width: width, height: height);
      },
    );
  }
}

class NoImage extends StatelessWidget {
  final double width;
  final double height;

  const NoImage({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Theme.of(context).colorScheme.surface,
      alignment: Alignment.center,
      child: Image.asset(
        Assets.avatar,
        width: width,
        height: height,
      ),
    );
  }
}
