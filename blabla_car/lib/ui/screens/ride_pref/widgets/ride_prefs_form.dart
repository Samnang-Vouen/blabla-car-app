import 'package:blabla_car/ui/screens/ride_pref/widgets/ride_prefs_input.dart';
import 'package:blabla_car/ui/screens/ride_pref/ride_location_picker_screen.dart';
import 'package:blabla_car/ui/screens/ride_pref/ride_seat_picker_screen.dart';
import 'package:blabla_car/ui/theme/theme.dart';
import 'package:blabla_car/ui/widgets/actions/bla_button.dart';
import 'package:blabla_car/ui/widgets/display/bla_divider.dart';
import 'package:blabla_car/utils/animations_util.dart';
import 'package:blabla_car/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

import '../../../../data/dummy_data.dart';
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
    //TODO
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      // If no given preferences, we select default ones :
      departure = null; // User shall select the departure
      departureDate = DateTime.now(); // Now  by default
      arrival = null; // User shall select the arrival
      requestedSeats = 1; // 1 seat book by default
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void onDeparturePressed() async {
    final selectedLocation = await Navigator.of(context).push<Location?>(
      AnimationsUtil.createBottomToTopRoute<Location?>(
        RideLocationPickerScreen(
          locations: fakeLocations,
        ),
      ),
    );

    if (selectedLocation == null) return;

    setState(() {
      departure = selectedLocation;
    });
  }

  void onArrivalPressed() async {
    final selectedLocation = await Navigator.of(context).push<Location?>(
      AnimationsUtil.createBottomToTopRoute<Location?>(
        RideLocationPickerScreen(
          locations: fakeLocations,
        ),
      ),
    );

    if (selectedLocation == null) return;

    setState(() {
      arrival = selectedLocation;
    });
  }

  void onSwappingLocationPressed() {
    setState(() {
      if (departure != null || arrival != null) {
        setState(() {
          final temp = departure;
          departure = arrival;
          arrival = temp;
        });
      }
    });
  }

  void onSeatsPressed() async {
    final selectedSeats = await Navigator.of(context).push<int?>(
      AnimationsUtil.createBottomToTopRoute<int?>(
        RideSeatPickerScreen(initialSeats: requestedSeats),
      ),
    );

    if (selectedSeats == null) return;

    setState(() {
      requestedSeats = selectedSeats;
    });
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  String get departureLabel =>
      departure != null ? departure!.name : "Leaving from";
  String get arrivalLabel => arrival != null ? arrival!.name : "Going to";

  bool get showDeparturePlaceHolder => departure == null;
  bool get showArrivalPlaceHolder => arrival == null;

  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get numberLabel => requestedSeats.toString();

  bool get switchIconVisible => arrival != null || departure != null;
  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(BlaSpacings.m),
          child: Column(
            children: [
              RidePrefInput(
                isPlaceHolder: showDeparturePlaceHolder,
                leftIcon: Icons.circle_outlined,
                text: departureLabel,
                onPressed: onDeparturePressed,
                rightIcon: switchIconVisible ? Icons.swap_vert : null,
                onPressedRightIcon:
                    switchIconVisible ? onSwappingLocationPressed : null,
              ),
              const BlaDivider(),
              RidePrefInput(
                isPlaceHolder: showArrivalPlaceHolder,
                leftIcon: Icons.circle_outlined,
                text: arrivalLabel,
                onPressed: onArrivalPressed,
              ),
              const BlaDivider(),
              RidePrefInput(
                leftIcon: Icons.calendar_month,
                text: dateLabel,
                onPressed: () {},
              ),
              const BlaDivider(),
              RidePrefInput(
                leftIcon: Icons.person_2_outlined,
                text: numberLabel,
                onPressed: onSeatsPressed,
              ),
            ],
          ),
        ),
        BlaButton(
          text: "Search",
          onPressed: () {},
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(BlaSpacings.radius),
            bottomRight: Radius.circular(BlaSpacings.radius),
          ),
        )
      ],
    );
  }
}
