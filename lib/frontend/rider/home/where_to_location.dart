import 'package:flutter/material.dart';
import '/package.dart';

class WhereToLocation extends StatefulWidget {
  static String route = '/WhereToLocation';

  const WhereToLocation({Key? key}) : super(key: key);

  @override
  State<WhereToLocation> createState() => WhereToLocationState();
}

const kGoogleApiKey = "";

class WhereToLocationState extends State<WhereToLocation> {
  late GoogleMapController controller;

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  Predictions? pickup;
  Predictions? dropoff;

  String markerId = 'target';

  Map<String, Marker> markers = <String, Marker>{
    'target': const Marker(
      markerId: MarkerId('target'),
      visible: true,
    ),
    'pickup': const Marker(
      markerId: MarkerId('pickup'),
      visible: true,
    ),
    'dropoff': const Marker(
      markerId: MarkerId('dropoff'),
      visible: false,
    ),
  };

  Set<Polyline> polylines = {};

  MarkerId? selectedMarker;
  LatLng? markerPosition;

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
    if (pickup == null) {
    } else if (dropoff == null) {
    } else {
      Pickup.lat = pickup?.lat;
      Pickup.lng = pickup?.lng;

      Dropoff.lat = dropoff?.lat;
      Dropoff.lng = dropoff?.lng;

      Pickup.address = await api.google.geocoding(
        pickup!.lat,
        pickup!.lng,
      );

      Dropoff.address = await api.google.geocoding(
        dropoff!.lat,
        dropoff!.lng,
      );

      Pickup.city = await api.google.geocoding(
        pickup!.lat,
        pickup!.lng,
      );

      Dropoff.city = await api.google.geocoding(
        dropoff!.lat,
        dropoff!.lng,
      );

      Dropoff.lng = await api.google.geocoding(
        dropoff!.lat,
        dropoff!.lng,
      );

      City.long =
          api.google.distanceBetween(pickup!.location!, dropoff!.location!);

      if (context.mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        SearchPlaces(
                          label: 'Pickup Point',
                          hintText: 'Pickup Point',
                          controller: controller1,
                          initialList: const [],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(33),
                          ),
                          future: () async {
                            String input = controller1.text;
                            if (input.isNotEmpty) {
                              List list = [];
                              List docs =
                                  await api.google.autocomplete(input: input);
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
                              dynamic details = await api.google
                                  .details(placeId: place.placeId);
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
                          child: const Icon(Icons.circle_outlined, size: 20),
                        ),
                        const SizedBox(height: 10),
                        SearchPlaces(
                          controller: controller2,
                          label: 'Drop off Point',
                          hintText: 'Drop off Point',
                          initialList: const [],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(33),
                          ),
                          future: () async {
                            String input = controller2.text;
                            if (input.isNotEmpty) {
                              List list = [];
                              List docs =
                                  await api.google.autocomplete(input: input);
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
                              dynamic details = await api.google
                                  .details(placeId: place.placeId);
                              place = Predictions.fromDetails(place, details);
                              await api.google.cameraUpdate(
                                controller,
                                place.location,
                                onIndicator: (res) {},
                              );
                              setState(() {
                                markerId = 'dropoff';
                                controller2.text = place!.description;
                                dropoff = place;
                              });
                            } else {
                              setState(() {
                                markerId = 'dropoff';
                                dropoff = null;
                              });
                            }
                          },
                          child: const Icon(
                            Icons.circle_outlined,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.all(10),
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
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
    );
  }
}
