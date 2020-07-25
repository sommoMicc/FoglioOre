import 'package:flutter/material.dart';
import 'package:foglio_ore/utils/constants.dart';

class CircleIconButton extends StatelessWidget {
  final IconData icon;

  final Color background;
  final Color iconColor;

  final VoidCallback onPressed;

  CircleIconButton({
    @required this.icon,
    @required this.onPressed,
    this.background = AppColors.circleIconButtonBackground,
    this.iconColor = AppColors.circleIconButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: kCircularButtonWidth,
        child: RawMaterialButton(
          onPressed: onPressed,
          elevation: 2.0,
          fillColor: background,
          padding: EdgeInsets.all(4.0),
          child: Theme(
            data: ThemeData(
                iconTheme: IconTheme.of(context).copyWith(color: iconColor)),
            child: Icon(this.icon),
          ),
          shape: CircleBorder(),
        ),
      ),
    );
  }
}
