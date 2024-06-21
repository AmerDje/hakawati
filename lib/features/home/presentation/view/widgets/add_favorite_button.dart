import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/extensions/media_query.dart';

class AddFavoriteButton extends StatefulWidget {
  const AddFavoriteButton({
    super.key,
    required this.onAddFav,
    required this.onRemoveFav,
  });
  final VoidCallback onAddFav;
  final VoidCallback onRemoveFav;

  @override
  State<AddFavoriteButton> createState() => _AddFavoriteButtonState();
}

class _AddFavoriteButtonState extends State<AddFavoriteButton> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      end: 20,
      top: context.height * 0.5,
      child: IconButton(
        icon: Icon(
          Icons.favorite,
          size: 35,
          color: isTapped ? Colors.red : null,
        ),
        onPressed: () {
          if (isTapped) {
            widget.onAddFav();
          } else {
            widget.onRemoveFav();
          }
          setState(() {
            isTapped = !isTapped;
          });
        },
      ),
    );
  }
}
