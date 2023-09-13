import 'package:flutter/material.dart';
import '/package.dart';

export 'invite_via_email.dart';
export 'invite_via_mobile.dart';
export 'invite_via_qr.dart';

class Invite extends StatefulWidget {
  static String route = '/Invite';

  const Invite({super.key});

  @override
  State<Invite> createState() => InviteState();
}

class InviteState extends State<Invite> {
  static final imageUrl = [
    'https://img.freepik.com/free-photo/female-hairdresser-using-hairbrush-hair-dryer_329181-1929.jpg?w=740&t=st=1683626104~exp=1683626704~hmac=29b3011170d066e6debd7e3d30fa0b87f878555a8ccb7ab2781ecebe6db220c3',
    'https://img.freepik.com/free-photo/beautiful-woman-has-cutting-hair-hairdresser_329181-1942.jpg?w=740&t=st=1683626196~exp=1683626796~hmac=b1b45ace9e98c3eb06638be44a10d7e01ad105bd508315f981ea4aa7c622cd7d',
    'https://as1.ftcdn.net/v2/jpg/00/58/83/76/1000_F_58837690_svMrpA5rsVIEOk3XZaNPsCarRiWo2Dik.jpg',
    'https://img.freepik.com/premium-photo/professional-hairdresser-tools-table_392895-297837.jpg?w=740',
    'https://img.freepik.com/free-photo/manicurist-master-makes-manicure-woman-s-hands-spa-treatment-concept_186202-7769.jpg?w=740&t=st=1683628986~exp=1683629586~hmac=6cc8a461dad2d5c7dad4deae01d4aca8c1dc61bb8d4623b79c0bf7e2390d96c4'
  ];
  int activeindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Share & Earn"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            "Earn Exciting benfit by \ninviting more friend"
                .text
                .size(18)
                .align(TextAlign.center)
                .make()
                .pOnly(
                  top: 20,
                )
                .centered(),
            carousel().pOnly(bottom: 40),
            list(
              "15% off of your next product",
            ),
            list(
              "3 free shipping",
            ),
            list(
              "7 days of premium membership",
            ).pOnly(bottom: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                box('Email', Icons.email, () {
                  Navigator.pushNamed(context, InviteViaEmail.route);
                }),
                box("Mobile", Icons.qr_code, () {
                  Navigator.pushNamed(context, InviteViaMobile.route);
                }),
                box("Code", Icons.qr_code, () {
                  Navigator.pushNamed(context, InviteViaQR.route);
                })
              ],
            ).pOnly(bottom: 30),
            "Both Parties will be recieving\nthe same offer"
                .text
                .color(Colors.grey)
                .align(TextAlign.center)
                .make()
          ]),
    );
  }

  Column box(String title, var icon, var tap) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.grey[200],
          child: Icon(
            icon,
            color: Colors.black,
          ).p(20),
        ).pOnly(bottom: 10).onTap(tap),
        title.text.make()
      ],
    );
  }

  Column carousel() {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: imageUrl.length,
          itemBuilder: (context, index, realIndex) {
            final imageUrls = imageUrl[index];
            return buildImage(imageUrls, index);
          },
          options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 1 / 4,
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(seconds: 1),
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() => activeindex = index);
              }),
        ).pOnly(top: 20),
        buildIndicator()
      ],
    );
  }

  Widget buildImage(String imageUrls, int index) {
    return CircleAvatar(
      radius: 70,
      backgroundImage: NetworkImage(imageUrls),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeindex,
        count: imageUrl.length,
        effect: const WormEffect(
            dotHeight: 8,
            dotWidth: 24,
            dotColor: Colors.grey,
            activeDotColor: Colors.black),
      );

  Padding list(String text) {
    return ListTile(
      leading: const Icon(
        Icons.check_circle,
        color: Colors.black,
      ),
      title: text.text.make(),
    ).pSymmetric(h: 70);
  }
}
