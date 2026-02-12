import 'package:blabla_car/ui/widgets/display/bla_divider.dart';
import 'package:blabla_car/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [ 
          RidePrefButton(
                icon: Icons.circle_outlined,
                text: departure?.name ?? 'Leaving from',
                onPressed: () {
                  
                },
              ),
              const BlaDivider(),
              RidePrefButton(
                icon: Icons.circle_outlined,
                text: arrival?.name ?? 'Going to',
                onPressed: () {
                  
                },
              ),
              const BlaDivider(),
              RidePrefButton(
                icon: Icons.calendar_month,
                text: DateTimeUtils.formatDateTime(departureDate),
                onPressed: () {
                  
                },
              ),
              const BlaDivider(),
              RidePrefButton(
                icon: Icons.people_alt,
                text: '$requestedSeats',
                onPressed: () {
                  
                },
              ),
        ]);
  }
}

class RidePrefButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onPressed;

  const RidePrefButton({
    super.key,
    required this.icon,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () {},
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}