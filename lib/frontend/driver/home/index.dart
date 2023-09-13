import 'package:flutter/material.dart';
import '/package.dart';

export './pickup/index.dart';

class DriverHome extends StatefulWidget {
  static String route = '/DriverHome';

  const DriverHome({super.key});

  @override
  State<DriverHome> createState() => DriverHomeState();
}

class DriverHomeState extends State<DriverHome> {
  bool isSignatures = false;
  bool isTrackingNumber = false;
  dynamic packageSize = 0;

  dynamic date = DateTime.now();
  dynamic time = const TimeOfDay(hour: 24, minute: 60);

  void onGoLive() {
    api.request.packageDelivery(
      cityLong: City.long,
      description: Package.description ?? '',
      dropoffAddress: Dropoff.address,
      dropoffCity: Dropoff.city,
      dropoffLat: Dropoff.lat,
      dropoffLng: Dropoff.lng,
      isSignatures: Package.signatures,
      isTrackingNumber: Package.trackingNumber,
      packageSize: Package.size,
      pickupAddress: Pickup.address,
      pickupCity: Pickup.city,
      pickupLat: Pickup.lat,
      pickupLng: Pickup.lng,
      quantity: Package.quantity,
      receiverNamber: Package.receiverNamber,
      receiverName: Package.receiverName ?? api.user.firstName,
      scheduleDate: Schedule.date,
      scheduleTime: Schedule.time,
      type: Package.type,
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
            'Provide Services',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
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
                        'Post Ride',
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
            //Start 1st screen
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Text('Request',style: TextStyle(fontSize: 18),).pOnly(bottom: 10),
                    TextFormField(
                      onTap: () {
                        Navigator.pushNamed(context, Pickups.route);
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
                            fontSize: 22, color: Colors.black87),
                        suffixIcon: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, NowTime.route);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
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
                              shape: BoxShape.circle, color: Colors.grey[300]),
                          child: const Icon(Icons.work)),
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
                              shape: BoxShape.circle, color: Colors.grey[300]),
                          child: const Icon(Icons.home)),
                      title: const Text(
                        "Home",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text(
                        "1455 Market St",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
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
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'See all',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ).py16(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        category('Ride', Assets.drawable.hatchback, () {}),
                        category('Package', Assets.drawable.box, () {}),
                        category('Reserve', Assets.drawable.reservation, () {}),
                        category('Rider Mode', Assets.drawable.driver, () {
                          Navigator.popAndPushNamed(context, Rider.route);
                        }),
                      ],
                    ).pOnly(bottom: 25),
                    const Text("Way to plan with Vyneh",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold))
                        .py12(),

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

            //Start 2nd Screen
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
                              borderSide: BorderSide.none),
                          hintText: 'Where to?',
                          // label:Text("Where to?"),
                          hintStyle: const TextStyle(
                              fontSize: 22, color: Colors.black87),
                          suffixIcon: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, NowTime.route);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              width: 100,
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.timelapse),
                                  Text("Now"),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ).py(4).px(15),
                          ),
                          //  suffixIcon: Icon(Icons.face)
                        ),
                      ),
                    ),
                    //Date Picker
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Pickers.date(context).then((value) {
                              if (value != null) {
                                setState(() {
                                  Schedule.date =
                                      '${value.day}-${value.month}-${value.year}';
                                  date = value;
                                });
                              }
                            });
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${date.day}-${date.month}-${date.year}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ).pOnly(right: 20),
                        InkWell(
                          onTap: () {
                            Pickers.time(context).then((value) {
                              if (value != null) {
                                setState(() {
                                  Schedule.time = value.format(context);
                                  time = value;
                                });
                              }
                            });
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${time.hour}:${time.minute.toString().padLeft(2, '0')}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).py20(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.contact_mail).pOnly(right: 20),
                        const Text(
                          'Choose Packages Size',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
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
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: onGoLive,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 15),
                        textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                      ),
                      child: const Text("Go Live"),
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
