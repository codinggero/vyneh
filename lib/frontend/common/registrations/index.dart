import 'package:flutter/material.dart';
import '/package.dart';

export 'cnic_back.dart';
export 'cnic_front.dart';
export 'driver_license.dart';
export 'profile_photo.dart';
export 'terms_condition.dart';
export 'vehicle_registration.dart';

class DriverRegistration extends StatefulWidget {
  static String route = '/DriverRegistration';

  const DriverRegistration({super.key});

  @override
  State<DriverRegistration> createState() => DriverRegistrationState();
}

class DriverRegistrationState extends State<DriverRegistration> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text('Vyneh'),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Welcome,H')
                  .text
                  .size(40)
                  .bold
                  .make()
                  .pOnly(left: 20, top: 20, bottom: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Required steps')
                        .text
                        .size(22)
                        .bold
                        .make()
                        .py12(),
                    Text(
                      "Here's what you need to do to set up your account",
                      style: TextStyle(fontSize: 20, color: Colors.grey[500]),
                    ),
                    list('CNIC Back Side', () {
                      Navigator.pushNamed(context, CnicBack.route);
                    }),
                    const Divider(),
                    list('CNIC Front Side', () {
                      Navigator.pushNamed(context, CnicFront.route);
                    }),
                    const Divider(),
                    list('Profile Photo', () {
                      Navigator.pushNamed(context, ProfilePhoto.route);
                    }),
                    const Divider(),
                    list('Driving License Front Side', () {
                      Navigator.pushNamed(context, DriverLicense.route);
                    }),
                    const Divider(),
                    list('Vehicle Registration', () {
                      Navigator.pushNamed(context, VehicleRegistration.route);
                    }),
                    const Divider(),
                    OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, TermsConditions.route);
                            },
                            child: const Text('Terms and Conditions')
                                .text
                                .size(20)
                                .black
                                .make())
                        .centered()
                    //   Text('Completed').text.size(20).bold.make(),
                    //  ListTile(
                    //   onTap: (){
                    //   },
                    //   leading: Icon(Icons.check_circle,color: Colors.green,),
                    //   title: Text('Terms and Conditions').text.size(20).bold.make(),
                    //   subtitle: Text('Completed'),
                    //   trailing: Icon(Icons.arrow_forward_ios),
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding list(String title, var tap) {
    return ListTile(
      onTap: tap,
      leading: const Icon(
        Icons.note_add_sharp,
        size: 30,
        color: Colors.black,
      ),
      title: Text(title).text.size(20).bold.make(),
      subtitle: const Text('Get Started'),
      trailing: const Icon(Icons.arrow_forward_ios),
    ).py(8);
  }
}
