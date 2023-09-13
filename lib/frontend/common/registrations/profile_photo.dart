import 'package:flutter/material.dart';
import '/package.dart';

class ProfilePhoto extends StatefulWidget {
  static String route = '/ProfilePhoto';

  const ProfilePhoto({super.key});

  @override
  State<ProfilePhoto> createState() => ProfilePhotoState();
}

class ProfilePhotoState extends State<ProfilePhoto> {
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
    arguments?.addAll({'image': image, 'userId': api.user.id});
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
              const Text('Take your profile photo')
                  .text
                  .size(30)
                  .bold
                  .make()
                  .py24(),
              const Text(
                      'Your profile photo helps people recognize you, please note that once you submit your profile photo it cannot be changed')
                  .text
                  .justify
                  .size(20)
                  .make()
                  .py12(),
              const Text(
                      '1.Face the camera directly with your eyes and mounth clearly visible')
                  .text
                  .size(15)
                  .gray500
                  .make()
                  .pOnly(bottom: 10),
              const Text(
                      '2.Make sure the photo is well lit, free of glare, and in focus')
                  .text
                  .size(15)
                  .gray500
                  .make()
                  .pOnly(bottom: 10),
              const Text('3.No photos of a photo, filters, or alterations')
                  .text
                  .size(15)
                  .gray500
                  .make()
                  .pOnly(bottom: 10),
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
                child: Center(
                  child: image == null
                      ? Container(
                          height: 320,
                          width: 320,
                          color: Colors.blue,
                          child: Image.asset(
                            Assets.drawable.profile,
                            fit: BoxFit.cover,
                          ),
                        ).centered().py(30)
                      : SizedBox(
                          height: 320,
                          width: 320,
                          child: Image.file(
                            File(image!.path.toString()),
                            fit: BoxFit.cover,
                          ),
                        ).centered().py(30),
                ),
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
