
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBarLeadingButton extends StatelessWidget {
  const AppBarLeadingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey.shade600.withOpacity(.5),
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Transform.flip(
              transformHitTests: false,
              flipY: true,
              child: const RotatedBox(
                  quarterTurns: 2,
                  child: Icon(
                    FontAwesomeIcons.share,
                    color: Colors.white,
                    size: 25,
                  )),
            )),
      ),
    );
  }
}