import 'package:flutter/material.dart';
import '/package.dart';

export 'now_time.dart';
export 'where_to_location.dart';

class RiderHome extends StatefulWidget {
  static String route = '/RiderHome';

  const RiderHome({super.key});

  @override
  State<RiderHome> createState() => RiderHomeState();
}

class RiderHomeState extends State<RiderHome> {
  bool isSignatures = false;
  bool isTrackingNumber = false;
  dynamic packageSize = 0;

  void onConfirmBooking() {
    api.request.packageDelivery(
      pickupAddress: Pickup.address,
      pickupLat: Pickup.lat,
      pickupLng: Pickup.lng,
      pickupCity: Pickup.city,
      dropoffAddress: Dropoff.address,
      dropoffLat: Dropoff.lat,
      dropoffLng: Dropoff.lng,
      dropoffCity: Dropoff.city,
      scheduleDate: Schedule.date,
      scheduleTime: Schedule.time,
      cityLong: City.long,
      packageSize: Package.size,
      quantity: Package.quantity,
      type: Package.type,
      receiverNamber: Package.receiverNamber,
      isSignatures: Package.signatures,
      isTrackingNumber: Package.trackingNumber,
      description: Package.description,
      receiverName: Package.receiverName,
      onIndicator: (response) {
        Indicator.call(response, context: context);
      },
      onSuccess: (response) {
        Snackbar.success(context, message: response.message);
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          elevation: 5,
          centerTitle: true,
          title: const Text(
            'Request Services',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              fontSize: 20,
            ),
          ),
          bottom: TabBar(
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              labelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.white,
              unselectedLabelColor: Colors.black45,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage(Assets.drawable.carWash)).p(5),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'Rides',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ).pOnly(bottom: 12),
                Tab(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage(Assets.drawable.vegetables)).p(5),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'Delivery',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )
                  ],
                ))
              ]),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const Text('Request',style: TextStyle(fontSize: 18),).pOnly(bottom: 10),
                    TextFormField(
                      onTap: () {
                        Navigator.pushNamed(context, WhereToLocation.route);
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFE4E9E4),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.black87,
                        ).p(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60),
                            borderSide: BorderSide.none),
                        hintText: 'Where to?',
                        // label:Text("Where to?"),
                        hintStyle: const TextStyle(
                          fontSize: 22,
                          color: Colors.black87,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, NowTime.route);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            width: 100,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.timelapse),
                                Text("Now"),
                                Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          ).py(6).px(15),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Container(
                        height: 100,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                        child: const Icon(Icons.work),
                      ),
                      title: const Text(
                        "Work",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text(
                        "1455 Market St",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ).pOnly(top: 12),
                    const Divider(),
                    ListTile(
                      leading: Container(
                          height: 100,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                          child: const Icon(Icons.home)),
                      title: const Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text(
                        "1455 Market St",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 8,
                    ).py12(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Suggestions',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'See all',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ).py16(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        category('Ride', Assets.drawable.hatchback, () {}),
                        category('Package', Assets.drawable.box, () {}),
                        category('Reserve', Assets.drawable.reservation, () {}),
                        category('Driver Mode', Assets.drawable.driver, () {
                          Navigator.popAndPushNamed(context, Driver.route);
                        })
                      ],
                    ).pOnly(bottom: 25),
                    const Text(
                      "Way to plan with Vyneh",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ).py12(),
                    carousel(context, items: [
                      Assets.drawable.a3,
                      Assets.drawable.a1,
                      Assets.drawable.a5,
                      Assets.drawable.a2,
                      Assets.drawable.a4,
                    ]),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                      child: TextFormField(
                        onTap: () {
                          Navigator.pushNamed(context, WhereToLocation.route);
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFE4E9E4),
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 25,
                            color: Colors.black87,
                          ).p(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Where to?',
                          hintStyle: const TextStyle(
                            fontSize: 22,
                            color: Colors.black87,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, NowTime.route);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              width: 100,
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.timelapse),
                                  Text("Now"),
                                  Icon(
                                    Icons.arrow_drop_down,
                                  )
                                ],
                              ),
                            ).py(4).px(15),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.contact_mail).pOnly(right: 20),
                        const Text(
                          'Choose Packages Size',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        radio(
                          title: "Small",
                          value: 1,
                          groupValue: packageSize,
                          onChanged: (value) {
                            setState(() {
                              packageSize = value;
                              Package.quantity = 0;
                              Package.size = value;
                            });
                          },
                        ),
                        radio(
                          title: "Medium",
                          value: 2,
                          groupValue: packageSize,
                          onChanged: (value) {
                            setState(() {
                              packageSize = value;
                              Package.quantity = 0;
                              Package.size = value;
                            });
                          },
                        ),
                        radio(
                          title: 'Large',
                          value: 3,
                          groupValue: packageSize,
                          onChanged: (value) {
                            setState(() {
                              Package.quantity = 0;
                              packageSize = value;
                              Package.size = value;
                            });
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        qty(
                          quantity: Package.quantity,
                          readOnly: packageSize == 1 ? false : true,
                          onChanged: (value) {
                            setState(() {
                              Package.quantity = value;
                            });
                          },
                        ),
                        qty(
                          quantity: Package.quantity,
                          readOnly: packageSize == 2 ? false : true,
                          onChanged: (value) {
                            setState(() {
                              Package.quantity = value;
                            });
                          },
                        ),
                        qty(
                          quantity: Package.quantity,
                          readOnly: packageSize == 3 ? false : true,
                          onChanged: (value) {
                            setState(() {
                              Package.quantity = value;
                            });
                          },
                        )
                      ],
                    ),
                    DropDownTextField(
                      textFieldDecoration: InputDecoration(
                        hintText: "Choose Type",
                        hintStyle: const TextStyle(fontSize: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        // Add any other desired styling properties
                      ),
                      dropDownList: const [
                        DropDownValueModel(name: 'Documents', value: '1'),
                        DropDownValueModel(name: 'Electronic', value: '2'),
                        DropDownValueModel(name: 'Flowers', value: '3'),
                        DropDownValueModel(name: 'Food', value: '4'),
                        DropDownValueModel(name: 'Grocery', value: '5'),
                        DropDownValueModel(name: 'Glass', value: '6'),
                        DropDownValueModel(name: 'Laundry', value: '7'),
                        DropDownValueModel(name: 'Medicines', value: '8'),
                        DropDownValueModel(name: 'Metal', value: '9'),
                      ],
                      onChanged: (value) {
                        setState(() {
                          Package.type = value.value;
                        });
                      },
                    ).py20(),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Requirements",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: Package.signatures == 0 ? false : true,
                          onChanged: (bool? value) {
                            setState(() {
                              Package.signatures = value == true ? 1 : 0;
                            });
                          },
                        ),
                        const Text('Signatures')
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: Package.trackingNumber == 0 ? false : true,
                          onChanged: (bool? value) {
                            setState(() {
                              Package.trackingNumber = value == true ? 1 : 0;
                            });
                          },
                        ),
                        const Text('Tracking Number'),
                      ],
                    ),
                    TextFormField(
                      maxLines: 8,
                      decoration: InputDecoration(
                        hintText: 'Write your message here',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                      ),
                      onChanged: (value) {
                        setState(() {
                          Package.description = value;
                        });
                      },
                    ).py12(),
                    SizedBox(
                      width: double.infinity,
                      child: const Text(
                        "Receiver's Name",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ).py20(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      onChanged: (value) {
                        setState(() {
                          Package.receiverName = value;
                        });
                      },
                    ).pOnly(bottom: 20),
                    SizedBox(
                      width: double.infinity,
                      child: const Text(
                        "Receiver's Phone Number",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ).py20(),
                    ),
                    IntlPhoneField(
                      countries: Cities.countries,
                      initialCountryCode: 'US',
                      pickerDialogStyle: PickerDialogStyle(
                        mainAxisSize: MainAxisSize.min,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.grey[500],
                        ),
                      ),
                      onChanged: (phone) {
                        setState(() {
                          Package.receiverNamber = phone.completeNumber;
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: onConfirmBooking,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 15),
                        textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                      ),
                      child: const Text("Confirm Booking"),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
