import 'package:flutter_test/flutter_test.dart';
import 'package:blabla_car/services/rides_service.dart';
import 'package:blabla_car/data/dummy_data.dart';

void main() {
  group('RidesService Filter Tests', () {
  
    setUp(() {
      RidesService.availableRides = fakeRides;
    });

    test('filterByDeparture returns rides from Dijon', () {
      final dijon = fakeLocations.firstWhere(
        (location) => location.name == 'Dijon',
      );

      final result = RidesService.filterByDeparture(dijon);

      expect(result.every((ride) => ride.departureLocation == dijon), true);
    });

    test('filterBySeatRequested returns rides with >= 2 seats', () {
      final result = RidesService.filterBySeatRequested(2);

      expect(result.every((ride) => ride.availableSeats >= 2), true);
    });

    test('filterBy with departure Dijon and seatsRequested 2', () {
      final dijon = fakeLocations.firstWhere(
        (loc) => loc.name == 'Dijon',
      );

      final result = RidesService.filterBy(
        departure: dijon,
        seatRequested: 2,
      );

      expect(result.every((ride) =>
        ride.departureLocation == dijon &&
        ride.availableSeats >= 2
      ), true);
    });

    test('filterBy with no parameters returns all rides', () {
      final result = RidesService.filterBy();

      expect(result.length, RidesService.availableRides.length);
    });

  });
}