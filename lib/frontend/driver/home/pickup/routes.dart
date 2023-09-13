import 'package:flutter/material.dart';
import '/package.dart';

class Routes extends StatefulWidget {
  static String route = '/Routes';

  const Routes({super.key});

  @override
  State<Routes> createState() => RoutesState();
}

class RoutesState extends State<Routes> {
  List routes = [];
  LatLngBounds? bounds;

  int selected = 0;
  late GoogleMapController controller;
  Set<Polyline> polylines = {};
  dynamic encoded;

  Map<String, Marker> markers = <String, Marker>{
    'pickup': const Marker(
      markerId: MarkerId('pickup'),
      visible: true,
    ),
    'dropoff': const Marker(
      markerId: MarkerId('dropoff'),
      visible: true,
    ),
  };

  double zoom = 17.0;

  LatLng target = const LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      findRoutes();
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
    setState(() {});
  }

  void onCameraIdle() {}

  Future findRoutes() {
    return api.google
        .direction(
            origin: LatLng(Pickup.lat, Pickup.lng),
            destination: LatLng(Dropoff.lat, Dropoff.lng))
        .then((value) {
      routes = value['routes'];
      bounded();
      setState(() {});
    });
  }

  convert(encodedString) {
    List<PointLatLng> points = PolylinePoints().decodePolyline(encodedString);
    polylines.add(Polyline(
      polylineId: const PolylineId('direction_polyline'),
      width: 5,
      points: points.map((e) => LatLng(e.latitude, e.longitude)).toList(),
    ));
  }

  bounded() {
    dynamic bound = routes[selected]['bounds'];
    LatLng northeast = LatLng(
      bound['northeast']['lat'],
      bound['northeast']['lng'],
    );
    LatLng southwest = LatLng(
      bound['southwest']['lat'],
      bound['southwest']['lng'],
    );

    bounds = LatLngBounds(northeast: northeast, southwest: southwest);

    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds!, 100));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
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
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: 'What is your route?'
                  .text
                  .size(35)
                  .bold
                  .gray800
                  .make()
                  .px12()
                  .py24(),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: routes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text("${routes[index]['summary']}")
                            .text
                            .size(20)
                            .bold
                            .gray800
                            .make(),
                        subtitle: Text(
                          "Distance: ${routes[index]['legs'][0]['distance']['text']}\nDuration: ${routes[index]['legs'][0]['duration']['text']}",
                        ).text.size(16).make().py8(),
                        trailing: Radio(
                          value: index,
                          groupValue: selected,
                          onChanged: (value) {
                            setState(() {
                              selected = value!;
                            });
                          },
                        ),
                      ).py16();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  PostRide.route = routes[selected];
                  Navigator.pushNamed(context, Stopovers.route);
                });
              },
              child: const Icon(Icons.arrow_forward),
            )
          ],
        ),
      ),
    );
  }
}
