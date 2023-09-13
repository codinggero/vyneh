import 'package:flutter/material.dart';
import '/package.dart';

class TermsConditions extends StatefulWidget {
  static String route = '/TermsConditions';

  const TermsConditions({super.key});

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  dynamic arguments;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      arguments = ModalRoute.of(context)!.settings.arguments ?? {};
      setState(() {});
    });
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
              const Text('Tarms and Conditions')
                  .text
                  .size(30)
                  .bold
                  .make()
                  .py24(),
              const Text('Please review and agree to the documents below')
                  .text
                  .size(18)
                  .make()
                  .py12(),
              ListTile(
                title: const Text('Subscription Pass Terms and Conditions')
                    .text
                    .size(20)
                    .bold
                    .make(),
                trailing: const Icon(Icons.arrow_forward_ios),
              ).py32(),
              ListTile(
                title: const Text('Vyneh BV Driver Agreement October 2022')
                    .text
                    .size(20)
                    .bold
                    .make(),
                trailing: const Icon(Icons.arrow_forward_ios),
              )
            ],
          ),
        )),
        bottomSheet: InkWell(
          onTap: () {
            showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 310,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        const Text('Confirm that you agree')
                            .text
                            .size(23)
                            .bold
                            .make()
                            .pOnly(top: 40, bottom: 15),
                        const Divider(),
                        const Text(
                                'I have reviewed and agreed to all documents')
                            .text
                            .size(23)
                            .bold
                            .make()
                            .pOnly(left: 16)
                            .py16(),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black),
                          child: const Text('Confirm')
                              .text
                              .white
                              .size(18)
                              .make()
                              .centered(),
                        ).py4().px16().onTap(() {
                          Navigator.pop(context);
                        }),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: const Text('Back')
                              .text
                              .bold
                              .size(18)
                              .make()
                              .centered(),
                        ).px16().onTap(() {
                          Navigator.pop(context);
                        }),
                      ]),
                    ),
                  );
                });
          },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black),
            child: const Text('Yes, I agree')
                .text
                .white
                .size(18)
                .make()
                .centered(),
          ).py16().px16(),
        ),
      ),
    );
  }
}
