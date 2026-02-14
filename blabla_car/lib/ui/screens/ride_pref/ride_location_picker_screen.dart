import 'package:blabla_car/model/ride/locations.dart';
import 'package:blabla_car/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class RideLocationPickerScreen extends StatefulWidget {
  final List<Location> locations;

  const RideLocationPickerScreen({
    super.key,
    required this.locations,
  });

  @override
  State<RideLocationPickerScreen> createState() =>
      _RideLocationPickerScreenState();
}

class _RideLocationPickerScreenState extends State<RideLocationPickerScreen> {
  final TextEditingController _controller = TextEditingController();

  String get _query => _controller.text.trim().toLowerCase();

  List<Location> get _filteredLocations {
    final query = _query;
    if (query.length < 2) return [];

    return widget.locations
        .where(
          (location) =>
              location.name.toLowerCase().contains(query) ||
              location.country.name.toLowerCase().contains(query),
        )
        .toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locations = _filteredLocations;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(BlaSpacings.m),
              child: TextField(
                controller: _controller,
                autofocus: true,
                onChanged: (value) => setState(() {}),
                decoration: InputDecoration(
                  hintText: "Station Road or The Bridge Cafe",
                  hintStyle: TextStyle(color: BlaColors.textLight),
                  filled: true,
                  fillColor: BlaColors.backgroundAccent,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: BlaSpacings.m,
                    vertical: BlaSpacings.s,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(BlaSpacings.radius),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.chevron_left),
                    color: BlaColors.iconLight,
                  ),
                  suffixIcon: _controller.text.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            _controller.clear();
                            setState(() {});
                          },
                          icon: const Icon(Icons.close),
                          color: BlaColors.iconLight,
                        ),
                ),
              ),
            ),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(
                        right: BlaSpacings.m, left: BlaSpacings.m),
                    child: ListView.separated(
                      itemCount: locations.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: BlaColors.greyLight,
                      ),
                      itemBuilder: (context, index) {
                        final location = locations[index];
                        return ListTile(
                          onTap: () => Navigator.of(context).pop(location),
                          title: Text(
                            location.name,
                            style: BlaTextStyles.button.copyWith(
                              fontSize: 16,
                              color: BlaColors.textNormal,
                            ),
                          ),
                          subtitle: Text(
                            location.country.name,
                            style: BlaTextStyles.label.copyWith(
                              color: BlaColors.textLight,
                            ),
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: BlaColors.iconLight,
                          ),
                        );
                      },
                    )
                )
            ),
          ],
        ),
      ),
    );
  }
}
