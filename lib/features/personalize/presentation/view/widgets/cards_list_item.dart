import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/utils.dart';

class CardsListItem extends StatelessWidget {
  const CardsListItem({
    super.key,
    required this.choice,
    required this.isSelected,
    required this.cardsArrangementOnRow,
  });

  final String choice;
  final bool isSelected;
  final bool cardsArrangementOnRow;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      width: getItemWidth(context),
      decoration: ShapeDecoration(
          shape: StadiumBorder(
            side: isSelected ? BorderSide(width: 2, color: Theme.of(context).secondaryHeaderColor) : BorderSide.none,
          ),
          color: const Color(0xFF3D2F51)),
      child: Text(
        choice,
        style: Styles.fontStyle20(context).copyWith(
          color: isSelected ? Theme.of(context).secondaryHeaderColor : null,
        ),
      ),
    );
  }

  double getItemWidth(BuildContext context) {
    late double itemWidth;
    if (cardsArrangementOnRow) {
      itemWidth = context.width;
    } else {
      itemWidth = (context.width * .5) - 30;
    }
    return itemWidth;
  }
}
