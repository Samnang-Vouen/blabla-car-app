import 'package:blabla_car/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class RideSeatPickerScreen extends StatefulWidget {
  final int initialSeats;
  final int minSeats;
  final int maxSeats;

  const RideSeatPickerScreen({
    super.key,
    required this.initialSeats,
    this.minSeats = 1,
    this.maxSeats = 8,
  });

  @override
  State<RideSeatPickerScreen> createState() => _RideSeatPickerScreenState();
}

class _RideSeatPickerScreenState extends State<RideSeatPickerScreen> {
  late int seats;

  @override
  void initState() {
    super.initState();
    seats = widget.initialSeats.clamp(widget.minSeats, widget.maxSeats);
  }

  bool get canDecrement => seats > widget.minSeats;
  bool get canIncrement => seats < widget.maxSeats;

  void decrement() {
    if (!canDecrement) return;
    setState(() => seats -= 1);
  }

  void increment() {
    if (!canIncrement) return;
    setState(() => seats += 1);
  }

  void confirm() {
    Navigator.of(context).pop<int>(seats);
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = BlaTextStyles.heading.copyWith(
      fontSize: 28,
      color: BlaColors.textNormal,
    );

    final numberStyle = BlaTextStyles.heading.copyWith(
      fontSize: 28,
      color: BlaColors.textNormal,
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(BlaSpacings.m),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
                color: BlaColors.primary,
              ),
              const SizedBox(height: BlaSpacings.m),
              Text('Number of seats to book', style: titleStyle),
              const SizedBox(height: BlaSpacings.m),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SeatCircleButton(
                    icon: Icons.remove,
                    enabled: canDecrement,
                    onPressed: decrement,
                  ),
                  Text('$seats', style: numberStyle),
                  SeatCircleButton(
                    icon: Icons.add,
                    enabled: canIncrement,
                    onPressed: increment,
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: confirm,
        backgroundColor: BlaColors.primary,
        shape: const CircleBorder(),
        child: Icon(Icons.arrow_forward, color: BlaColors.white),
      ),
    );
  }
}

class SeatCircleButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onPressed;

  const SeatCircleButton({
    super.key, 
    required this.icon,
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = enabled ? BlaColors.primary : BlaColors.greyLight;
    final iconColor = enabled ? BlaColors.primary : BlaColors.iconLight;

    return OutlinedButton(
      onPressed: enabled ? onPressed : null,
      style: OutlinedButton.styleFrom(
        shape: const CircleBorder(),
        side: BorderSide(color: borderColor, width: 2),
        padding: const EdgeInsets.all(BlaSpacings.s),
      ),
      child: Icon(icon, color: iconColor, size: 24),
    );
  }
}
