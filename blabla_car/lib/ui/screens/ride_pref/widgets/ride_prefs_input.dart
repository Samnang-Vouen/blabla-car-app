import 'package:blabla_car/ui/theme/theme.dart';
import 'package:blabla_car/ui/widgets/actions/bla_icon_button.dart';
import 'package:flutter/material.dart';

///
/// Input field for the whole application
///

class RidePrefInput extends StatelessWidget {
  final IconData leftIcon;
  final IconData? rightIcon;
  final String text;
  final VoidCallback onPressed;
  final VoidCallback? onPressedRightIcon;

  final bool isPlaceHolder;

  const RidePrefInput(
      {super.key,
      required this.leftIcon,
      required this.text,
      this.rightIcon,
      required this.onPressed,
      this.onPressedRightIcon,
      this.isPlaceHolder = false});

  @override
  Widget build(BuildContext context) {
    Color textColor =
        isPlaceHolder ? BlaColors.textLight : BlaColors.textNormal;
    return ListTile(
      onTap: onPressed,
      title: Text(text,
          style: BlaTextStyles.button.copyWith(fontSize: 14, color: textColor)),
      leading: Icon(
        leftIcon,
        size: 24,
        color: BlaColors.iconLight,
      ),
      trailing: rightIcon != null
          ? BlaIconButton(icon: rightIcon, iconPressed: onPressedRightIcon)
          : null,
    );
  }
}
