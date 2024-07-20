import 'package:flutter/material.dart';

class ImageUploadItem extends StatelessWidget {
  final Widget image;
  final GestureTapCallback onRemove;

  const ImageUploadItem({
    super.key,
    required this.image,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        image,
        PositionedDirectional(
          top: 0,
          end: -3,
          child: InkResponse(
            onTap: onRemove,
            child: Container(
              width: 20,
              height: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: theme.colorScheme.error, shape: BoxShape.circle),
              child: const Icon(Icons.close, size: 13, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
