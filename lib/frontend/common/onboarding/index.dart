import 'package:flutter/material.dart';
import '/package.dart';

class Onboarding extends StatefulWidget {
  static String route = '/Onboarding';

  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => OnboardingState();
}

class OnboardingState extends State<Onboarding> {
  var activeindex = 0;

  static List<String> thumbnail = [
    Assets.drawable.car1,
    Assets.drawable.car3,
    Assets.drawable.car6,
  ];

  static List<String> title = [
    'Every mile on your VyNeh contributes to the World. You enjoy the ride we curb the carbon footprints for our future generations',
    'Rent & Hire a Car with ease. We have wide range of cars at affordable prices,',
    'Share a Ride, ask for delivery or be the pilot of the wheels today. We got you.',
    'Not Sure about plan yet? Schedule a trip or delivery and get connected with pilots on route.',
    'Short on cash? Talk to your pilot and strike that deal your way!',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Search for the best available taxi',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  'Effortlessly book the best available taxi near you, ensuring a convenient and reliable transportation experience.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ),
              carousel().pOnly(bottom: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () => Navigator.pushNamed(context, Auth.route),
                    child: const SizedBox(
                      width: 200,
                      height: 60,
                      child: Center(
                        child: Text(
                          'Next',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20), // Increase the font size
                        ),
                      ),
                    ),
                  )
                ],
              ).pSymmetric(h: 20)
            ]),
      ),
    );
  }

  Column carousel() {
    return Column(
      children: [
        Center(
          child: CarouselSlider.builder(
            itemCount: thumbnail.length,
            itemBuilder: (context, index, realIndex) {
              final imageUrls = thumbnail[index];
              return buildImage(imageUrls, index);
            },
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height / 2,
              autoPlay: true,
              enlargeCenterPage: true,
              autoPlayAnimationDuration: const Duration(seconds: 1),
              onPageChanged: (index, reason) {
                setState(() => activeindex = index);
              },
            ),
          ).pOnly(bottom: 20),
        ),
        buildIndicator(),
      ],
    );
  }

  Widget buildImage(String imageUrls, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 5,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      width: MediaQuery.of(context).size.width / 1.3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          imageUrls,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeindex,
        count: thumbnail.length,
        effect: const WormEffect(
          dotHeight: 5,
          dotWidth: 20,
          dotColor: Colors.grey,
          activeDotColor: Colors.black,
        ),
      );
}
