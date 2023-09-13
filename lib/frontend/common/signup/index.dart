import 'package:flutter/material.dart';
import '/package.dart';

class Signup extends StatefulWidget {
  static String route = '/Signup';

  const Signup({super.key});

  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
  String? contact;
  String? dob;
  String? email;
  String? firstName;
  String? lastName;
  String? password;

  DateTime dateTime = DateTime.now();
  bool obscureText = false;

  //Date Picker Function
  void _showDatePicker() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
    );

    if (selectedDate != null) {
      setState(() {
        dateTime = selectedDate;
        dob = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
      });
    }
  }

  onSignup() {
    api.request.signup(
      contact: contact,
      dob: dob,
      email: email,
      firstName: firstName,
      lastName: lastName,
      password: password,
      onIndicator: (response) {
        Indicator.call(response, context: context);
      },
      onSuccess: (response) {
        Navigator.pushNamed(
          context,
          Otp.route,
          arguments: {
            'route': Signup.route,
            'email': email,
          },
        );
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Lottie.asset(
                  Assets.animations.hello,
                  fit: BoxFit.cover,
                  height: 300,
                ),
              ),
              CustomTextFieldWidget(
                hintText: 'First Name',
                prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      firstName = value;
                    });
                  } else {
                    setState(() {
                      firstName = null;
                    });
                  }
                },
              ),
              CustomTextFieldWidget(
                hintText: 'Last Name',
                prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter your Last name';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      lastName = value;
                    });
                  } else {
                    setState(() {
                      lastName = null;
                    });
                  }
                },
              ),
              CustomTextFieldWidget(
                hintText: 'Email Address',
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      email = value;
                    });
                  } else {
                    setState(() {
                      email = null;
                    });
                  }
                },
              ),
              IntlPhoneField(
                countries: Cities.countries,
                initialCountryCode: 'US',
                keyboardType: TextInputType.phone,
                pickerDialogStyle: PickerDialogStyle(
                  mainAxisSize: MainAxisSize.min,
                ),
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  errorStyle: const TextStyle(color: Colors.black),
                ),
                onChanged: (phone) {
                  setState(() {
                    contact = phone.completeNumber;
                  });
                },
              ),
              CustomTextFieldWidget(
                hintText: '${dateTime.day}-${dateTime.month}-${dateTime.year}',
                prefixIcon: IconButton(
                  onPressed: () {
                    _showDatePicker();
                  },
                  icon: const Icon(
                    Icons.calendar_month_rounded,
                    color: Colors.black,
                  ),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter your birth date';
                  }
                  return null;
                },
                onTap: () {
                  Pickers.date(context).then((date) {
                    if (date != null) {
                      setState(() {
                        dob = '${date.day}-${date.month}-${date.year}';
                      });
                    } else {
                      setState(() {
                        dob = null;
                      });
                    }
                  });
                },
              ),
              CustomTextFieldWidget(
                hintText: 'Password',
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (obscureText) {
                        obscureText = false;
                      } else {
                        obscureText = true;
                      }
                    });
                  },
                  child: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
                obscureText: obscureText,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Password';
                  }
                  if (value.length < 2) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      password = value;
                    });
                  } else {
                    setState(() {
                      password = null;
                    });
                  }
                },
              ),
              BtnWidget(
                title: 'Register',
                btnTxtClr: Colors.white,
                btnBgClr: Colors.black,
                onTap: onSignup,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Signin.route);
                  },
                  child: const Text(
                    'Register Already? Login',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: 'Poppins',
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
}
