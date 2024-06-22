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
        radius: 25,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        child: CircleAvatar(
          radius: 23,
          backgroundColor: Colors.deepPurple,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Transform.flip(
                transformHitTests: false,
                flipY: true,
                child: RotatedBox(
                    quarterTurns: 2,
                    child: Icon(
                      FontAwesomeIcons.share,
                      color: Theme.of(context).secondaryHeaderColor,
                      size: 25,
                    )),
              )),
        ),
      ),
    );
  }
}
