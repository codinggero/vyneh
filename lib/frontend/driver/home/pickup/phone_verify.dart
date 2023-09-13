import 'package:flutter/material.dart';
import '/package.dart';

class PhoneVerify extends StatefulWidget {
  static String route = '/PhoneVerify';

  const PhoneVerify({super.key});

  @override
  State<PhoneVerify> createState() => PhoneVerifyState();
}

class PhoneVerifyState extends State<PhoneVerify> {
  void onPressed() {
    api.request.driverPostRide(
      pickupAddress: Pickup.address,
      pickupLat: Pickup.lat,
      pickupLng: Pickup.lng,
      pickupCity: Pickup.city,
      dropoffAddress: Dropoff.address,
      dropoffLat: Dropoff.lat,
      dropoffLng: Dropoff.lng,
      dropoffCity: Dropoff.city,
      route: PostRide.route,
      stops: PostRide.stops,
      scheduleDate: Schedule.date,
      scheduleTime: Schedule.time,
      totalSeats: PostRide.totalSeats,
      isMiddleSeatEmpty: PostRide.isMiddleSeatEmpty,
      takenNumberOfPassengers: PostRide.takenNumberOfPassengers,
      availableSeats: PostRide.availableSeats,
      allowInstantBooking: PostRide.allowInstantBooking,
      perSeatCharges: PostRide.perSeatCharges,
      phoneNumber: PostRide.phoneNumber,
      isPhoneNumberVerified: PostRide.isPhoneNumberVerified,
      isReturnTrip: PostRide.isReturnTrip,
      status: PostRide.status,
      onIndicator: (response) {
        Indicator.call(response, context: context);
      },
      onSuccess: (response) {
        Snackbar.success(context, message: response.message);
        Navigator.popAndPushNamed(context, Driver.route);
      },
      onError: (err) {
        if (err.runtimeType == Res) {
          Snackbar.error(context, message: err.message);
        } else {
          Snackbar.error(context, message: err);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.blue,
              size: 30,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Please verify your mobile number".text.size(40).bold.make(),
            const SizedBox(
              height: 20,
            ),
            IntlPhoneField(
              countries: Cities.countries,
              initialCountryCode: 'US',
              pickerDialogStyle: PickerDialogStyle(
                mainAxisSize: MainAxisSize.min,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 25),
                filled: true,
                fillColor: const Color(0xFFE4E9E4),
                hintText: "Phone Number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (phone) {
                setState(() {
                  PostRide.isPhoneNumberVerified = '1';
                  PostRide.phoneNumber = phone.completeNumber;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onPressed,
        child: const Icon(Icons.arrow_forward),
      ).px12(),
    );
  }
}
