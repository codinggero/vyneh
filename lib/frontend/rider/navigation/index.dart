import 'package:flutter/material.dart';
import '/package.dart';

export 'search/index.dart';
export 'messages/index.dart';
export 'notification/index.dart';
export 'sos/index.dart';

class NavigationScreen extends StatefulWidget {
  static String route = '/NavigationScreen';

  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  TimeOfDay time = const TimeOfDay(hour: 12, minute: 00);
  DateTime date = DateTime.now();

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  Predictions? leavingFrom;
  Predictions? goingTo;
  dynamic leavingDate;
  dynamic leavingTime;
  dynamic requiredSeats;

  void onSearch() {
    api.request.searchRide(
      leavingFrom: leavingFrom?.description,
      goingTo: goingTo?.description,
      leavingDate: leavingDate,
      leavingTime: leavingTime,
      requiredSeats: requiredSeats,
      onIndicator: (response) {
        Indicator.call(response, context: context);
      },
      onSuccess: (response) {
        Navigator.pushNamed(context, Passenger.route);
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Navigation',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Notifications.route);
            },
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Messages.route);
            },
            icon: const Icon(Icons.mail),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Sos.route);
            },
            icon: const Icon(Icons.sos),
          ),
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 350,
            child: Image.asset(
              Assets.drawable.car1,
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Your pic of ride at low price',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 280,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  SearchPlaces(
                                    label: 'Leaving from',
                                    hintText: 'Leaving from',
                                    controller: controller1,
                                    initialList: const [],
                                    future: () async {
                                      String input = controller1.text;
                                      if (input.isNotEmpty) {
                                        List list = [];
                                        List collection = await api.google
                                            .autocomplete(input: input);
                                        for (var place in collection) {
                                          list.add(
                                            Predictions.fromAutocomplete(
                                              place,
                                            ),
                                          );
                                        }
                                        return list;
                                      } else {
                                        return [];
                                      }
                                    },
                                    onSelected:
                                        (Predictions? predictions) async {
                                      if (predictions != null) {
                                        dynamic details = await api.google
                                            .details(
                                                placeId: predictions.placeId);
                                        predictions = Predictions.fromDetails(
                                            predictions, details);
                                        setState(() {
                                          controller1.text =
                                              predictions!.description;
                                          leavingFrom = predictions;
                                        });
                                      } else {
                                        setState(() {
                                          leavingFrom = null;
                                        });
                                      }
                                    },
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.circle_outlined,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SearchPlaces(
                                    label: 'Going to',
                                    hintText: 'Going to',
                                    controller: controller2,
                                    initialList: const [],
                                    future: () async {
                                      String input = controller2.text;
                                      if (input.isNotEmpty) {
                                        List list = [];
                                        List collection = await api.google
                                            .autocomplete(input: input);
                                        for (var place in collection) {
                                          list.add(
                                            Predictions.fromAutocomplete(
                                              place,
                                            ),
                                          );
                                        }
                                        return list;
                                      } else {
                                        return [];
                                      }
                                    },
                                    onSelected:
                                        (Predictions? predictions) async {
                                      if (predictions != null) {
                                        dynamic details = await api.google
                                            .details(
                                                placeId: predictions.placeId);
                                        predictions = Predictions.fromDetails(
                                            predictions, details);
                                        setState(() {
                                          controller2.text =
                                              predictions!.description;
                                          goingTo = predictions;
                                        });
                                      } else {
                                        setState(() {
                                          goingTo = null;
                                        });
                                      }
                                    },
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.circle_outlined,
                                      size: 20,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Pickers.time(context).then((t) {
                                        if (t != null) {
                                          leavingTime = t.format(context);
                                          time = t;
                                          setState(() {});
                                        }
                                      });
                                    },
                                    child: SizedBox(
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 13, top: 5),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.av_timer,
                                                color: Colors.grey),
                                            const SizedBox(width: 12),
                                            Text(
                                              time.format(context),
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Divider(color: Colors.grey),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 13),
                                    child: SizedBox(
                                      height: 40,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Pickers.date(context)
                                                        .then((d) {
                                                      if (d != null) {
                                                        leavingDate =
                                                            "${d.day}-${d.month}-${d.year}";
                                                        date = d;
                                                        setState(() {});
                                                      }
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .calendar_month_outlined,
                                                        color: Colors.grey,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        "${date.day}-${date.month}-${date.year}",
                                                        style: const TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const VerticalDivider(
                                              color: Colors.grey),
                                          Expanded(
                                            flex: 1,
                                            child: Stack(
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      const Icon(
                                                        Icons.person,
                                                        color: Color.fromARGB(
                                                            255, 216, 52, 52),
                                                      ),
                                                      VxStepper(
                                                        onChange: (value) {
                                                          setState(() {
                                                            requiredSeats =
                                                                value;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: onSearch,
                              child: Container(
                                height: 45,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Search",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.more_time_sharp),
                    title: Row(
                      children: [
                        'Vienna'.text.make(),
                        const Icon(Icons.arrow_forward),
                        'Budapest'.text.make(),
                      ],
                    ),
                    subtitle: const Text('2 passengers'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: const Icon(Icons.more_time_sharp),
                    title: Row(
                      children: [
                        'Budapest'.text.make(),
                        const Icon(Icons.arrow_forward),
                        'Vienna'.text.make(),
                      ],
                    ),
                    subtitle: const Text('1 passenger'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: const Icon(Icons.more_time_sharp),
                    title: Row(
                      children: [
                        'Budapest'.text.make(),
                        const Icon(Icons.arrow_forward),
                        'Vienna'.text.make(),
                      ],
                    ),
                    subtitle: const Text('3 passengers'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
