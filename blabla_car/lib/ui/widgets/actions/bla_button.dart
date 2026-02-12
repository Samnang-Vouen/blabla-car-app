import 'package:blabla_car/ui/theme/theme.dart';
import 'package:flutter/material.dart';

///
/// The BlaButton widget is a reusable button component used 
/// throughout the application.
///
/// It allows:
/// - Displaying primary and secondary styled buttons
/// - Showing an optional icon alongside the text
/// - Customizing text color, background color, and icon color
/// - Handling user tap actions via the onPressed callback
///

class BlaButton extends StatelessWidget {
  const BlaButton(
      {super.key,
      required this.text,
      required this.textColor,
      required this.buttonBackgroundColor,
      required this.icon,
      required this.iconColor,
      required this.onPressed});

  final String text;
  final Color textColor;
  final Color buttonBackgroundColor;
  final IconData? icon;
  final Color iconColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
     return ElevatedButton(
      onPressed: onPressed ?? () {}, 
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonBackgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: iconColor, size: 20),
            SizedBox(width: 8),
          ],
          Text(
            text, 
            style: BlaTextStyles.button.copyWith(color: textColor)
          ),
        ],
      ),
    );
  }
}
