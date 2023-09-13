import 'package:flutter/material.dart';
import '/package.dart';

class CnicFront extends StatefulWidget {
  static String route = '/CnicFront';

  const CnicFront({super.key});

  @override
  State<CnicFront> createState() => CnicFrontState();
}

class CnicFrontState extends State<CnicFront> {
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
    arguments?.addAll({'cnicFront': image});
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
              const Text('Take a Photo of your CNIC Front Side')
                  .text
                  .size(30)
                  .bold
                  .make()
                  .py24(),
              const Text(
                      'Take a picture of the front side of your national ID card'
                      '(include all xorner). 1 Make sure that picture is clear'
                      'and all word are easily readable. 2 All of the '
                      'information like your name,date of brith, gender, the'
                      'expiration date etc. should be clearly visible. 3 if any of'
                      'the information is blurry od too shiny(from camera'
                      'flash), card will be rejected. 4 Missing information or'
                      'tempering with information or the photo will also lead to rejection')
                  .text
                  .justify
                  .size(20)
                  .make(),
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(
                        color: Colors.blue, shape: BoxShape.circle),
                    child: const Text('!').text.white.make().centered(),
                  ),
                  const Text('What is this?')
                      .text
                      .color(Colors.blue)
                      .size(18)
                      .make()
                      .px12()
                ],
              ).py24(),
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
                          Assets.drawable.cnicFront,
                          fit: BoxFit.cover,
                        ),
                      ).centered().py(30)
                    : SizedBox(
                        height: 320,
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
