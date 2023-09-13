import 'package:flutter/material.dart';
import '/package.dart';

class ProfileUpdate extends StatefulWidget {
  static String route = '/ProfileUpdate';

  const ProfileUpdate({Key? key}) : super(key: key);

  @override
  State<ProfileUpdate> createState() => ProfileUpdateState();
}

class ProfileUpdateState extends State<ProfileUpdate> {
  File? image;
  dynamic avatar;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController username = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      avatar = api.user.image;
      firstName.text = api.user.firstName;
      lastName.text = api.user.lastName;
      dob.text = api.user.dob;
      email.text = api.user.email;
      contact.text = api.user.contact;
      username.text = '${api.user.firstName} ${api.user.lastName}';
      setState(() {});
    });
  }

  void onPressed() {
    api.request.profileUpdate(
      id: api.user.id,
      contact: contact.text,
      dob: dob.text,
      email: email.text,
      firstName: firstName.text,
      lastName: lastName.text,
      username: '${firstName.text} ${lastName.text}',
      image: image,
      onIndicator: (response) {
        Indicator.call(response, context: context);
      },
      onSuccess: (response) {
        Navigator.pop(context);
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
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 5,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Pick Image"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                              onPressed: () {
                                Pickers.image().then((file) {
                                  if (file != null) {
                                    image = file;
                                    Navigator.pop(context);
                                    setState(() {});
                                  }
                                });
                              },
                              child: const Text("Upload Image from Gallery"),
                            ),
                            TextButton(
                              onPressed: () {
                                Pickers.image(gallery: false).then((file) {
                                  if (file != null) {
                                    image = file;
                                    Navigator.pop(context);
                                    setState(() {});
                                  }
                                });
                              },
                              child: const Text("Capture Image from Camera"),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.black,
                  backgroundImage:
                      image != null ? FileImage(File(image!.path)) : null,
                  child: image == null
                      ? const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 60,
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "${firstName.text} ${lastName.text}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Minnesota, USA',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  field(
                    "First Name",
                    'Enter First Name',
                    firstName,
                    (value) {
                      setState(() {});
                    },
                  ),
                  const Divider(),
                  field(
                    "Last Name",
                    'Enter Last Name',
                    lastName,
                    (value) {
                      setState(() {});
                    },
                  ),
                  const Divider(),
                  field(
                    "Email",
                    'Enter Email Address',
                    email,
                    (value) {
                      setState(() {});
                    },
                  ),
                  const Divider(),
                  field(
                    "Mobile Number",
                    'Enter Mobile Number',
                    contact,
                    (value) {
                      setState(() {});
                    },
                  ),
                  const Divider(),
                  field(
                    "Birth Date",
                    'Enter Birth Date',
                    dob,
                    (value) {
                      setState(() {});
                    },
                  ),
                  const Divider(),
                ],
              ),
              const SizedBox(height: 50),
              FilledButton(
                onPressed: onPressed,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget field(
    String title,
    String hint,
    TextEditingController? controller,
    void Function(String)? onChanged,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 180,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class FilledButtons extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const FilledButtons({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: child,
    );
  }
}
