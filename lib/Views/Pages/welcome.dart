import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/welcomePageProvider.dart';
import 'package:socioverse/Views/Pages/Authentication/socialMediaSignUp.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  final List<String> title = [
    'The Best Social Media App of The Century',
    'Lets Connect with Everyone',
    'Everything You Can Do in One App',
  ];

  final List<String> description = [
    'Introducing SocioVerse! Connect, share, and stay updated with a vibrant community. Join the buzz and download today!',
    'The ultimate platform to forge connections and engage with a diverse community. Join us today!',
    'Unlock endless possibilities with this app, empowering you to explore, create, connect, and more. Discover it now!'
  ];

  final CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Lottie.asset('assets/lottie/welcome.json'),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                  top: 0, left: 20, right: 20, bottom: 20),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurface,
                  border: Border.all(color: const Color(0xff2A2B39)),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).colorScheme.background,
                        blurRadius: 10,
                        offset: const Offset(0, 10))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.horizontal_rule_rounded,
                    size: 50,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  Consumer<WelcomePageProvider>(
                    builder: (context, value, child) => CarouselSlider(
                      disableGesture: false,
                      carouselController: buttonCarouselController,
                      options: CarouselOptions(
                        initialPage: value.currentPage,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                        viewportFraction: 1,
                        pauseAutoPlayOnTouch: true,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) {
                          value.currentPage = index;
                        },
                      ),
                      items: title.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(i,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                    textAlign: TextAlign.center),
                                const SizedBox(height: 20),
                                Text(description[title.indexOf(i)],
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    textAlign: TextAlign.center),
                              ],
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Consumer<WelcomePageProvider>(
                    builder: (context, value, child) => SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          if (value.currentPage >= 2) {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const SocialMediaSignUpPage()));
                          }
                          value.currentPage = value.currentPage + 1;
                          buttonCarouselController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear);
                        },
                        child: Text("Next",
                            style: GoogleFonts.openSans(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onPrimary),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    const SocialMediaSignUpPage()));
                      },
                      child: Text("Skip",
                          style: GoogleFonts.openSans(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimary),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
