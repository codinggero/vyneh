import 'package:flutter/material.dart';
import '/package.dart';

class VehicleRegistration extends StatefulWidget {
  static String route = '/VehicleRegistration';

  const VehicleRegistration({super.key});

  @override
  State<VehicleRegistration> createState() => VehicleRegistrationState();
}

class VehicleRegistrationState extends State<VehicleRegistration> {
  dynamic arguments;

  File? image;
  Widget? child;

  DateTime dateTime = DateTime.now();

  TextEditingController carName = TextEditingController();
  TextEditingController model = TextEditingController();
  TextEditingController plateNumber = TextEditingController();
  TextEditingController insuranceCompany = TextEditingController();
  TextEditingController ploicyNumber = TextEditingController();
  TextEditingController registrationDate = TextEditingController();
  TextEditingController policyHolder = TextEditingController();
  dynamic bodyStyle = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      arguments = ModalRoute.of(context)!.settings.arguments ?? {};
      setState(() {});
    });
  }

  Future<File?> picker({bool gallery = true}) async {
    return Pickers.image(gallery: gallery).then((file) {
      if (file != null) {
        return file;
      } else {
        Snackbar.warning(context, message: "Please Choose A Profile Picture");
        return null;
      }
    });
  }

  void onPressed() async {
    if (image == null) {
      Snackbar.error(context,
          message: 'Please Upload Vehicle Registration Card.');
    } else {
      api.request.driverVehicleDetails(
        driverId: api.user.id,
        carName: carName.text,
        model: model.text,
        plateNumber: plateNumber.text,
        insuranceCompany: insuranceCompany.text,
        ploicyNumber: ploicyNumber.text,
        registrationDate: registrationDate.text,
        policyHolder: policyHolder.text,
        bodyStyle: bodyStyle,
        vehicleImage: image,
        onIndicator: (response) {
          Indicator.call(response, context: context);
        },
        onSuccess: (response) {
          Navigator.popAndPushNamed(context, Auth.route);
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //  backgroundColor: const Color.fromARGB(255, 24, 24, 24),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text('Vehicle registration'),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  File? file = await picker();
                  if (file != null) {
                    image = file;
                    child = Image.file(
                      file,
                      fit: BoxFit.contain,
                    );
                    setState(() {});
                  }
                },
                child: image == null
                    ? Container(
                        height: 320,
                        width: 320,
                        color: Colors.blue,
                        child: Image.asset(
                          Assets.drawable.registration,
                          fit: BoxFit.cover,
                        ),
                      ).centered().py(10)
                    : SizedBox(
                        height: 180,
                        width: 320,
                        // color: Colors.blue,
                        child: Image.file(
                          File(image!.path.toString()),
                          fit: BoxFit.cover,
                        ),
                      ).centered().py(10),
              ),
              ElevatedButton.icon(
                      onPressed: () async {
                        File? file = await picker(gallery: false);
                        if (file != null) {
                          image = file;
                          setState(() {});
                        }
                      },
                      icon: const Icon(
                        Icons.upload,
                        color: Colors.black87,
                      ),
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white70)),
                      label: const Text('Upload Image')
                          .text
                          .color(Colors.black87)
                          .make())
                  .centered()
                  .pOnly(bottom: 8),
              CustomTextFieldWidget(
                controller: carName,
                hintText: 'Make',
                prefixIcon: const Icon(Icons.car_rental),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter car name';
                  }
                  return null;
                },
              ),
              CustomTextFieldWidget(
                controller: model,
                hintText: 'Model',
                prefixIcon: const Icon(Icons.model_training),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter Model';
                  }
                  return null;
                },
              ),
              CustomTextFieldWidget(
                controller: plateNumber,
                hintText: 'Plate Number',
                prefixIcon: const Icon(Icons.numbers),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter car number';
                  }
                  return null;
                },
              ),
              CustomTextFieldWidget(
                controller: insuranceCompany,
                hintText: 'Insurance Company',
                prefixIcon: const Icon(Icons.compare),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please Fill Fileds';
                  }
                  return null;
                },
              ),
              CustomTextFieldWidget(
                controller: ploicyNumber,
                hintText: 'Policy Number',
                prefixIcon: const Icon(Icons.local_police),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please Fill Fileds';
                  }
                  return null;
                },
              ),
              CustomTextFieldWidget(
                controller: registrationDate,
                hintText: '${dateTime.day}-${dateTime.month}-${dateTime.year}',
                prefixIcon: IconButton(
                    onPressed: () {
                      Pickers.date(context).then((date) {
                        if (date != null) {
                          setState(() {
                            registrationDate.text =
                                "${date.day}-${date.month}-${date.year}";
                          });
                        }
                      });
                    },
                    icon: const Icon(Icons.calendar_month_rounded)),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please Fill Fileds';
                  }
                  return null;
                },
                onTap: () {
                  Pickers.date(context).then((date) {
                    if (date != null) {
                      setState(() {
                        registrationDate.text =
                            "${date.day}-${date.month}-${date.year}";
                      });
                    }
                  });
                },
              ),
              CustomTextFieldWidget(
                controller: policyHolder,
                hintText: 'Policy Holder',
                prefixIcon: const Icon(Icons.policy),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please Fill Fileds';
                  }
                  return null;
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Text('Body Style').text.size(18).bold.make(),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      radio('Sedan', 1),
                      radio('Coupe', 2),
                      radio('MiniVan/Van', 3),
                    ],
                  ),
                  Row(
                    children: [
                      radio('Truck', 4),
                      radio('SUV', 5),
                      radio('Motorcycle', 6)
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(360, 50),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 24.0,
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row radio(String title, int val) {
    return Row(
      children: [
        Radio(
          fillColor: MaterialStateColor.resolveWith(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.blue;
              }
              return Colors.black;
            },
          ),
          value: val,
          groupValue: bodyStyle,
          onChanged: (value) {
            setState(() {
              bodyStyle = value;
            });
          },
        ),
        Text(title).text.size(13).make(),
      ],
    );
  }
}
