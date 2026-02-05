import '../data/dummy_data.dart';
import '../model/ride/locations.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  static List<Ride> availableRides = fakeRides; // TODO for now fake data

  static List<Ride> filterByDeparture(Location departure) {
    return availableRides
        .where((e) => e.departureLocation == departure)
        .toList();
  }

  static List<Ride> filterBySeatRequested(int seatRequested) {
    return availableRides
        .where((e) => e.availableSeats == seatRequested)
        .toList();
  }

  static bool filterBy({Location? departure, int? seatRequested}) {
    final matchingDeparture = availableRides.where(
      (e) => e.departureLocation == departure,
    ).toList();

    final matchingSeatRequested = availableRides.where(
      (e) => e.availableSeats >= seatRequested!,
    ).toList();
    return matchingDeparture && matchingSeatRequested;
  }
}
