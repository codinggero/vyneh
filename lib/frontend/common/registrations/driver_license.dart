import 'package:flutter/material.dart';
import '/package.dart';

class DriverLicense extends StatefulWidget {
  static String route = '/DriverLicense';

  const DriverLicense({super.key});

  @override
  State<DriverLicense> createState() => DriverLicenseState();
}

class DriverLicenseState extends State<DriverLicense> {
  dynamic arguments;

  File? image;
  Widget? child;

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

  void callback(arguments, ok) {
    if (ok) {
      api.request.becomeDriverDetails(
        userId: arguments['userId'],
        cnicFront: arguments['cnicFront'],
        cnicBack: arguments['cnicBack'],
        image: arguments['image'],
        drivingLinence: arguments['drivingLinence'],
        onIndicator: (response) {
          Indicator.call(response, context: context);
        },
        onSuccess: (response) {
          Navigator.pushNamed(context, VehicleRegistration.route);
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

  void registration() {
    arguments?.addAll({'drivingLinence': image});
    api.request.registration(
      arguments: arguments,
      indicator: (response) {
        Indicator.call(response, context: context);
      },
      navigator: (route, arg) {
        Navigator.pushNamed(context, route, arguments: arg);
      },
      callback: callback,
    );
  }

  void onTakePhoto() async {
    if (image != null) {
      registration();
    } else {
      File? file = await picker(gallery: false);
      if (file != null) {
        image = file;
        child = Image.file(
          file,
          fit: BoxFit.contain,
        );
        registration();
        setState(() {});
      } else {
        if (context.mounted) {
          Snackbar.error(context, message: "Please Choose A Profile Picture");
        }
      }
    }
  }

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
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Take a Photo of your Driving License Front Side')
                  .text
                  .size(30)
                  .bold
                  .make()
                  .py24(),
              const Text(
                      'Take a picture of the front side of your Driving Licence'
                      '(include all xorner). 1 Make sure that picture is clear'
                      'and all word are easily readable. 2 All of the '
                      'information like your name,driving licence number,'
                      'documents issue date, expiration date, license type, and'
                      'CNIC(where available) should be clearly visible. 3 Ensure'
                      'to upload the right type/ category of license for the'
                      'product you want to drive on. for example. D/L category'
                      'product you want to drive on.for car product(vyneh flow).'
                      'M/Cycle for motorcycle products(SUV/Flow).etc 4'
                      'Renewal Receipt should be accepeted till the validity date'
                      'mentioned on the receipt, 5.if any of the information is'
                      'blurry or too shiny(from camera flash). card will be'
                      'rejected, 6.Make sure that you have uploaded your'
                      'CNIC in the relevant documents slot, as it will be cross'
                      'refernced to approve your driving license.')
                  .text
                  .justify
                  .size(20)
                  .make(),
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
                        height: 180,
                        width: 320,
                        color: Colors.blue,
                        child: Image.asset(
                          Assets.drawable.drivingLicense,
                          fit: BoxFit.cover,
                        ),
                      ).centered().py(30)
                    : SizedBox(
                        height: 180,
                        width: 320,
                        // color: Colors.blue,
                        child: Image.file(
                          File(image!.path.toString()),
                          fit: BoxFit.cover,
                        ),
                      ).centered().py(30),
              ),
            ],
          ),
        )),
        bottomSheet: InkWell(
          onTap: onTakePhoto,
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black),
            child:
                const Text('Take Photo').text.white.size(18).make().centered(),
          ).py16().px16(),
        ),
      ),
    );
  }
}
