import 'package:flutter/material.dart';
import '/package.dart';

class PickupLocation extends StatefulWidget {
  static String route = '/PickupLocation';

  const PickupLocation({Key? key}) : super(key: key);

  @override
  State<PickupLocation> createState() => PickupLocationState();
}

class PickupLocationState extends State<PickupLocation> {
  late GoogleMapController controller;
  TextEditingController controller1 = TextEditingController();
  Predictions? pickup;
  String markerId = 'pickup';

  Map<String, Marker> markers = <String, Marker>{
    'pickup': const Marker(
      markerId: MarkerId('pickup'),
      visible: true,
    ),
  };

  Set<Polyline> polylines = {};

  double zoom = 17.0;

  LatLng target = const LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      target = await api.google.currentLatLng();
      await api.google.cameraUpdate(
        controller,
        target,
        onIndicator: (res) {},
      );
      markers[markerId] = api.google.marker(
        markerId: markerId,
        position: target,
        visible: true,
      );
      setState(() {});
    });
  }

  void onMapCreated(GoogleMapController c) {
    controller = c;
  }

  void onCameraMoveStarted() {
    setState(() {});
  }

  void onCameraMove(CameraPosition pos) {
    target = pos.target;
    markers[markerId] = api.google.marker(
      markerId: markerId,
      position: target,
      visible: true,
    );
    setState(() {});
  }

  void onCameraIdle() {}

  Future<void> onPressed() async {
    Pickup.lat = target.latitude;
    Pickup.lng = target.longitude;
    Pickup.address = await api.google.geocoding(
      target.latitude,
      target.longitude,
    );
    Pickup.city = await api.google.geocoding(
      target.latitude,
      target.longitude,
    );
    if (context.mounted) Navigator.pushNamed(context, DropOff.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SearchPlaces(
                controller: controller1,
                label: 'Pickup Point',
                hintText: 'Pickup Point',
                initialList: const [],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(33),
                ),
                future: () async {
                  String input = controller1.text;
                  if (input.isNotEmpty) {
                    List list = [];
                    List docs = await api.google.autocomplete(input: input);
                    for (var place in docs) {
                      list.add(Predictions.fromAutocomplete(place));
                    }
                    return list;
                  } else {
                    return [];
                  }
                },
                onSelected: (Predictions? place) async {
                  if (place != null) {
                    dynamic details = await api.google.details(placeId:place.placeId);
                    place = Predictions.fromDetails(place, details);
                    await api.google.cameraUpdate(
                      controller,
                      place.location,
                      onIndicator: (res) {},
                    );
                    setState(() {
                      markerId = 'pickup';
                      controller1.text = place!.description;
                      pickup = place;
                    });
                  } else {
                    setState(() {
                      markerId = 'pickup';
                      pickup = null;
                    });
                  }
                },
                child: const Icon(
                  Icons.circle_outlined,
                  size: 20,
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: GoogleMap(
                myLocationEnabled: true,
                trafficEnabled: true,
                zoomControlsEnabled: false,
                markers: Set<Marker>.of(markers.values),
                polylines: polylines,
                initialCameraPosition: CameraPosition(
                  target: target,
                  zoom: zoom,
                ),
                onCameraMove: onCameraMove,
                onCameraMoveStarted: onCameraMoveStarted,
                onMapCreated: onMapCreated,
                onCameraIdle: onCameraIdle,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onPressed,
        child: const Icon(Icons.arrow_forward),
      ).px(40),
    );
  }
}
