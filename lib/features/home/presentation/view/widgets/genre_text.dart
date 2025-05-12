import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/styles.dart';

class GenreText extends StatelessWidget {
  const GenreText({
    super.key,
    required this.genre,
  });
  final String genre;
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      text: 'Genre: ',
      style: Styles.fontStyle14(context),
      children: [
        TextSpan(
          text: genre,
          style: Styles.fontStyle14(context).copyWith(
            color: Theme.of(context).secondaryHeaderColor,
          ),
        ),
      ],
    ));
  }
}
