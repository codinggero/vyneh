class Assets {
  static Animations animations = Animations(path: 'assets/animations');
  static Configuration configuration = Configuration(path: 'configuration');
  static Drawable drawable = Drawable(path: 'assets/drawable');
  static Fonts fonts = Fonts(path: 'assets/fonts');
}

class Configuration {
  final String path;
  Configuration({required this.path});
  String get applePay => '$path/applePay.json';
  String get googlePay => '$path/googlePay.json';
}

class Animations {
  final String path;
  Animations({required this.path});
  String get hello => '$path/hello.json';
  String get password => '$path/password.json';
  String get onboarding => '$path/onboarding.json';
  String get email => '$path/email.json';
  String get phone => '$path/phone.json';
}

class Fonts {
  final String path;
  Fonts({required this.path});

  String get poppinsBlack => '$path/Poppins-Black.ttf';
  String get poppinsBold => '$path/Poppins-Bold.ttf';
  String get poppinsExtraBold => '$path/Poppins-ExtraBold.ttf';
  String get poppinsItalic => '$path/Poppins-Italic.ttf';
  String get poppinsLight => '$path/Poppins-Light.ttf';
  String get poppinsMedium => '$path/Poppins-Medium.ttf';
  String get poppinsRegular => '$path/Poppins-Regular.ttf';
}

class Drawable {
  final String path;
  Drawable({required this.path});

  String get a1 => '$path/a1.jpg';
  String get a2 => '$path/a2.jpg';
  String get a3 => '$path/a3.jpg';
  String get a4 => '$path/a4.jpg';
  String get a5 => '$path/a5.jpg';
  String get apple => '$path/apple.png';
  String get box => '$path/box.png';
  String get camera => '$path/camera.png';
  String get car1 => '$path/car1.jpg';
  String get car3 => '$path/car3.jpg';
  String get car6 => '$path/car6.jpg';
  String get car8 => '$path/car8.jpg';
  String get carWash => '$path/carWash.png';
  String get cash => '$path/cash.png';
  String get cnicBack => '$path/cnicBack.jpg';
  String get cnicFront => '$path/cnicFront.jpg';
  String get contacts => '$path/contacts.png';
  String get credit => '$path/credit.png';
  String get dollar => '$path/dollar.png';
  String get driver => '$path/driver.png';
  String get drivingLicense => '$path/drivingLicense.jpg';
  String get error => '$path/error.jpg';
  String get googlepay => '$path/googlepay.png';
  String get gps => '$path/gps.jpg';
  String get hatchback => '$path/hatchback.png';
  String get location => '$path/location.png';
  String get logo => '$path/logo.jpg';
  String get minimize => '$path/minimize.png';
  String get otp => '$path/otp.jpg';
  String get paypal => '$path/paypal.png';
  String get paypal1 => '$path/paypal1.png';
  String get pic => '$path/pic.jpg';
  String get placeholder => '$path/placeholder.gif';
  String get profile => '$path/profile.jpg';
  String get profile2 => '$path/profile2.jpg';
  String get registration => '$path/registration.png';
  String get reservation => '$path/reservation.png';
  String get social => '$path/social.png';
  String get storage => '$path/storage.png';
  String get vegetables => '$path/vegetables.png';
}
