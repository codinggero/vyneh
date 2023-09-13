import 'dart:ui';

import '/package.dart';
import 'package:location/location.dart' as loc;

class Google {
  static String key = '';
  static String base = "https://maps.googleapis.com/maps/api";

  static late GoogleMapController mapController;

  static Google get instance {
    return Google();
  }

  Future permissionStatus(
    Permission permission, {
    void Function(bool, Permission)? isGranted,
    void Function(PermissionStatus, Permission)? isDenied,
    void Function(bool, Permission)? isPermanentlyDenied,
  }) async {
    try {
      PermissionStatus status = await permission.status;
      if (status.isGranted) {
        if (isGranted != null) isGranted(status.isGranted, permission);
        return status.isGranted;
      } else {
        if (status.isPermanentlyDenied) {
          if (isPermanentlyDenied != null) {
            isPermanentlyDenied(status.isGranted, permission);
          }
          return status.isPermanentlyDenied;
        } else {
          if (isDenied != null) isDenied(status, permission);
          return false;
        }
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  Future permissionRequest(
    Permission permission, {
    void Function(bool, Permission)? isGranted,
    void Function(PermissionStatus, Permission)? isDenied,
    void Function(bool, Permission)? isPermanentlyDenied,
  }) async {
    try {
      PermissionStatus status = await permission.request();
      if (status.isGranted) {
        if (isGranted != null) isGranted(status.isGranted, permission);
        return status.isGranted;
      } else {
        if (status.isPermanentlyDenied) {
          if (isPermanentlyDenied != null) {
            isPermanentlyDenied(status.isGranted, permission);
          }
          return status.isPermanentlyDenied;
        } else {
          if (isDenied != null) isDenied(status, permission);
          return false;
        }
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  Future permissionServiceStatus(
    PermissionWithService permission, {
    void Function(bool, PermissionWithService)? isEnabled,
    void Function(bool, PermissionWithService)? isDisabled,
    void Function(bool, PermissionWithService)? isNotApplicable,
  }) async {
    try {
      ServiceStatus serviceStatus = await permission.serviceStatus;
      if (serviceStatus.isEnabled) {
        if (isEnabled != null) isEnabled(serviceStatus.isEnabled, permission);
        return serviceStatus.isEnabled;
      } else {
        if (serviceStatus.isDisabled) {
          if (isDisabled != null) {
            isDisabled(serviceStatus.isDisabled, permission);
          }
          return serviceStatus.isDisabled;
        }

        if (serviceStatus.isNotApplicable) {
          if (isNotApplicable != null) {
            isNotApplicable(serviceStatus.isNotApplicable, permission);
          }
          return serviceStatus.isNotApplicable;
        }
        return false;
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<Response<dynamic>> request(
    String path, {
    Object? data,
    Map<String, dynamic> query = const {},
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = "https://maps.googleapis.com/maps/api";
      dio.options.responseType = ResponseType.json;
      query.addAll({'key': 'AIzaSyApnzkwaerr_weswj3yVvzbXG26wN1dPKA'});
      Response response = await dio.get(
        path,
        data: data,
        queryParameters: query,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        log('log: ${e.response?.data}');
        log('log: ${e.response?.headers}');
        log('log: ${e.response?.requestOptions}');
      } else {
        log('log: ${e.requestOptions}');
        log('log: ${e.message}');
      }
      return Future.error(e);
    } catch (e) {
      log('log: $e');
      return Future.error(e);
    }
  }

  void googleMapController(GoogleMapController controller) {
    mapController = controller;
  }

  Future checkPermissionAndServices() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return true;
  }

  Future currentLocation({void Function(bool)? onIndicator}) async {
    if (onIndicator != null) onIndicator(true);
    return checkPermissionAndServices().then((value) async {
      bool enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) {
        enabled = await loc.Location().requestService();
      } else {
        return Geolocator.getCurrentPosition().then((pos) {
          if (onIndicator != null) onIndicator(false);
          return pos;
        }, onError: (err) {
          if (onIndicator != null) onIndicator(false);
          return Future.error(err.toString());
        });
      }
    }, onError: (err) {
      if (onIndicator != null) onIndicator(false);
      return Future.error(err.toString());
    });
  }

  Future<LatLng> currentLatLng({void Function(bool)? onIndicator}) async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      return LatLng(position.latitude, position.longitude);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future geocoding(double latitude, double longitude,
      {String localeIdentifier = "en",
      void Function(bool)? onIndicator}) async {
    if (onIndicator != null) onIndicator(true);
    return checkPermissionAndServices().then((value) {
      return placemarkFromCoordinates(latitude, longitude,
              localeIdentifier: localeIdentifier)
          .then((place) {
        if (onIndicator != null) onIndicator(false);

        if (place.isNotEmpty) {
          return "${place.first.name} ${place.first.street} ${place.first.locality} ${place.first.country}";
        }
      }, onError: (err) {
        if (onIndicator != null) onIndicator(false);

        return Future.error(err.toString());
      });
    }, onError: (err) {
      if (onIndicator != null) onIndicator(false);

      return Future.error(err.toString());
    });
  }

  Future<dynamic> autocomplete({
    required String input,
    void Function(bool)? onIndicator,
    void Function(dynamic)? callback,
    String language = 'en',
    String components = "country:pak",
  }) async {
    if (onIndicator != null) onIndicator(true);
    Response response = await request('/place/autocomplete/json', query: {
      'input': input,
    });
    if (response.statusCode == 200) {
      if (onIndicator != null) onIndicator(false);
      if (callback != null) callback(response.data['predictions']);
      return response.data['predictions'];
    } else {
      if (onIndicator != null) onIndicator(false);
      if (callback != null) callback([]);
      return [];
    }
  }

  Future direction({
    required LatLng origin,
    required LatLng destination,
    DirectionsMode mode = DirectionsMode.driving,
    bool alternatives = true,
    String region = 'pk',
    void Function(bool)? onIndicator,
    void Function(dynamic)? callback,
  }) async {
    if (onIndicator != null) onIndicator(true);
    Response response = await request('/directions/json', query: {
      'origin': '${origin.latitude},${origin.longitude}',
      'destination': '${destination.latitude},${destination.longitude}',
      'alternatives': alternatives,
      'region': region,
    });
    if (response.statusCode == 200) {
      if (onIndicator != null) onIndicator(false);
      if (callback != null) callback(response.data);
      return response.data;
    } else {
      if (onIndicator != null) onIndicator(false);
      if (callback != null) callback([]);
      return [];
    }
  }

  Future<dynamic> details({
    required String placeId,
    void Function(bool)? onIndicator,
    void Function(dynamic)? callback,
  }) async {
    if (onIndicator != null) onIndicator(true);
    Response response = await request('/place/details/json', query: {
      'place_id': placeId,
    });

    if (response.statusCode == 200) {
      if (onIndicator != null) onIndicator(false);
      if (callback != null) callback(response.data['result']['geometry']);
      return response.data['result']['geometry'];
    } else {
      if (onIndicator != null) onIndicator(false);
      if (callback != null) callback([]);
      return [];
    }
  }

  Map<String, Marker> addMarker({
    String markerId = "target",
    double alpha = 1.0,
    Offset anchor = const Offset(0.5, 1.0),
    bool consumeTapEvents = false,
    bool draggable = false,
    bool flat = false,
    BitmapDescriptor icon = BitmapDescriptor.defaultMarker,
    InfoWindow infoWindow = InfoWindow.noText,
    LatLng position = const LatLng(0.0, 0.0),
    double rotation = 0.0,
    bool visible = true,
    double zIndex = 0.0,
    void Function()? onTap,
    void Function(LatLng)? onDrag,
    void Function(LatLng)? onDragStart,
    void Function(LatLng)? onDragEnd,
    void Function(Map<String, Marker>)? callback,
    void Function(bool)? onIndicator,
    required Map<String, Marker> markers,
  }) {
    if (markers.containsKey(markerId)) {
      Marker marker = Marker(
        markerId: MarkerId(markerId),
        onTap: () {},
        position: position,
        icon: icon,
        infoWindow: infoWindow,
      );
      markers[markerId] = marker;
    } else {
      Marker marker = Marker(
        markerId: MarkerId(markerId),
        onTap: () {},
        position: position,
        icon: icon,
        infoWindow: infoWindow,
      );
      markers[markerId] = marker;
    }

    if (callback != null) {
      callback(markers);
    }

    return markers;
  }

  Marker marker({
    String markerId = "target",
    double alpha = 1.0,
    Offset anchor = const Offset(0.5, 1.0),
    bool consumeTapEvents = false,
    bool draggable = false,
    bool flat = false,
    BitmapDescriptor icon = BitmapDescriptor.defaultMarker,
    InfoWindow infoWindow = InfoWindow.noText,
    LatLng position = const LatLng(0.0, 0.0),
    double rotation = 0.0,
    bool visible = false,
    double zIndex = 0.0,
    void Function()? onTap,
    void Function(LatLng)? onDrag,
    void Function(LatLng)? onDragStart,
    void Function(LatLng)? onDragEnd,
  }) {
    return Marker(
      markerId: MarkerId(markerId),
      alpha: alpha,
      anchor: anchor,
      consumeTapEvents: consumeTapEvents,
      draggable: draggable,
      flat: flat,
      icon: icon,
      infoWindow: infoWindow,
      position: position,
      rotation: rotation,
      visible: visible,
      zIndex: zIndex,
      onTap: onTap,
      onDrag: onDrag,
      onDragStart: onDragStart,
      onDragEnd: onDragEnd,
    );
  }

  Future cameraUpdate(
    GoogleMapController controller,
    position, {
    double bearing = 0.0,
    double tilt = 0.0,
    double zoom = 17.0,
    void Function(bool)? onIndicator,
  }) async {
    if (onIndicator != null) onIndicator(true);
    LatLng target = const LatLng(0, 0);
    if (position.runtimeType == LatLng) {
      target = position;
    } else if (position.runtimeType == Position) {
      target = LatLng(position.latitude, position.longitude);
    }

    return controller
        .animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: bearing,
          target: target,
          tilt: tilt,
          zoom: zoom,
        ),
      ),
    )
        .then((value) {
      if (onIndicator != null) onIndicator(false);
    }).onError((error, stackTrace) {
      if (onIndicator != null) onIndicator(false);
    });
  }

  double bearingBetween(LatLng start, LatLng end,
      {void Function(bool)? onIndicator}) {
    return Geolocator.bearingBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
  }

  bounds(List<LatLng> points) {
    // LatLng? southwest;
    // LatLng? northeast;
    assert(points.isNotEmpty);
    var firstLatLng = points.first;
    var s = firstLatLng.latitude,
        n = firstLatLng.latitude,
        w = firstLatLng.longitude,
        e = firstLatLng.longitude;
    for (var i = 1; i < points.length; i++) {
      var latlng = points[i];
      s = min(s, latlng.latitude);
      n = max(n, latlng.latitude);
      w = min(w, latlng.longitude);
      e = max(e, latlng.longitude);
    }
    return LatLngBounds(southwest: LatLng(s, w), northeast: LatLng(n, e));
  }

  double distanceBetween(LatLng start, LatLng end) {
    return Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
  }
}
