import '/package.dart';

class Predictions {
  String label;
  dynamic value;

  String description;
  String placeId;
  String reference;

  LatLng? location;
  dynamic lat;
  dynamic lng;

  dynamic viewport;
  LatLng? northeast;
  LatLng? southwest;

  Predictions({
    required this.label,
    required this.value,
    required this.description,
    required this.placeId,
    required this.reference,
    this.location,
    this.lat,
    this.lng,
    this.viewport,
    this.northeast,
    this.southwest,
  });

  factory Predictions.fromAutocomplete(Map<String, dynamic> json) {
    return Predictions(
      label: json['description'],
      value: json,
      description: json['description'],
      placeId: json['place_id'],
      reference: json['reference'],
    );
  }

  factory Predictions.fromDetails(
      Predictions predictions, Map<String, dynamic> json) {
    return Predictions(
      label: predictions.label,
      value: predictions.value,
      description: predictions.description,
      placeId: predictions.placeId,
      reference: predictions.reference,
      location: LatLng(json['location']['lat'], json['location']['lng']),
      lat: json['location']['lat'],
      lng: json['location']['lng'],
      viewport: json['viewport'],
      northeast: LatLng(json['viewport']['northeast']['lat'],
          json['viewport']['northeast']['lng']),
      southwest: LatLng(json['viewport']['southwest']['lat'],
          json['viewport']['southwest']['lng']),
    );
  }
}

class Cities {
  static List<Country> countries = [
    const Country(
      name: 'United States',
      code: 'US',
      dialCode: '1',
      nameTranslations: {
        "en": "United States",
      },
      flag: "🇺🇸",
      minLength: 10,
      maxLength: 10,
    ),
    //for canada
    const Country(
      name: 'Canada',
      code: 'CA',
      dialCode: '1',
      nameTranslations: {
        "en": "Canada",
      },
      flag: "🇨🇦",
      minLength: 10,
      maxLength: 10,
    ),
  ];

  static List<String> cities = [
    "Badin",
    "Bhirkan",
    "Rajo Khanani",
    "Chak",
    "Dadu",
    "Digri",
    "Diplo",
    "Dokri",
    "Ghotki",
    "Haala",
    "Hyderabad",
    "Islamkot",
    "Jacobabad",
    "Jamshoro",
    "Jungshahi",
    "Kandhkot",
    "Kandiaro",
    "Karachi",
    "Kashmore",
    "Keti Bandar",
    "Khairpur",
    "Kotri",
    "Larkana",
    "Matiari",
    "Mehar",
    "Mirpur Khas",
    "Mithani",
    "Mithi",
    "Mehrabpur",
    "Moro",
    "Nagarparkar",
    "Naudero",
    "Naushahro Feroze",
    "Naushara",
    "Nawabshah",
    "Nazimabad",
    "Qambar",
    "Qasimabad",
    "Ranipur",
    "Ratodero",
    "Rohri",
    "Sakrand",
    "Sanghar",
    "Shahbandar",
    "Shahdadkot",
    "Shahdadpur",
    "Shahpur Chakar",
    "Shikarpaur",
    "Sukkur",
    "Tangwani",
    "Tando Adam Khan",
    "Tando Allahyar",
    "Tando Muhammad Khan",
    "Thatta",
    "Umerkot",
    "Warah"
  ];
}

class PostRide {
  static dynamic allowInstantBooking = '0';
  static dynamic availableSeats = '0';
  static dynamic isMiddleSeatEmpty = '0';
  static dynamic isPhoneNumberVerified = '0';
  static dynamic isReturnTrip = '0';
  static dynamic perSeatCharges = '20';
  static dynamic phoneNumber;
  static dynamic route;
  static dynamic status = "pending";
  static dynamic stops;
  static dynamic takenNumberOfPassengers = '0';
  static dynamic totalSeats = '5';
}

class Package {
  static dynamic description = '';
  static dynamic quantity = 0;
  static dynamic receiverNamber = '';
  static dynamic receiverName = '';
  static dynamic signatures = 0;
  static dynamic size = 0;
  static dynamic trackingNumber = 0;
  static dynamic type = 0;

  static String toPrint() {
    dynamic json = {
      'size': size,
      'quantity': quantity,
      'type': type,
      'receiver_namber': receiverNamber,
      'signatures': signatures,
      'tracking_number': trackingNumber,
      'description': description,
      'receiver_name': receiverName,
    };
    log("Package@ $json");
    return json.toString();
  }
}

class Schedule {
  static dynamic date;
  static dynamic time;
  static String toPrint() {
    dynamic json = {
      'date': date,
      'time': time,
    };
    log("Schedule@ $json");
    return json.toString();
  }
}

class Pickup {
  static dynamic address;
  static dynamic city;
  static dynamic lat;
  static dynamic lng;
  static LatLng location = LatLng(lat, lng);

  static String toPrint() {
    dynamic json = {
      'address': address,
      'city': city,
      'lat': lat,
      'lng': lng,
    };
    log("Pickup@ $json");
    return json.toString();
  }
}

class Dropoff {
  static dynamic address;
  static dynamic city;
  static dynamic lat;
  static dynamic lng;
  static LatLng location = LatLng(lat, lng);

  static String toPrint() {
    dynamic json = {
      'address': address,
      'city': city,
      'lat': lat,
      'lng': lng,
    };
    log("Dropof@ $json");
    return json.toString();
  }
}

class City {
  static dynamic long;
  static String toPrint() {
    dynamic json = {
      'long': long,
    };
    log("City@ $json");
    return json.toString();
  }
}
