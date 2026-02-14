import 'package:blabla_car/ui/theme/theme.dart';
import 'package:flutter/material.dart';

///
/// Icon Button rendering for the whole application
///

class BlaIconButton extends StatelessWidget {
  const BlaIconButton({super.key, required this.icon, required this.iconPressed});

  final IconData? icon;
  final VoidCallback? iconPressed;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: iconPressed,
        child: Icon(icon, size: 24, color: BlaColors.primary),
      ),
    );
  }
}
