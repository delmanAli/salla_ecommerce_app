import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:sala_shop_app/modules/login/login_screen.dart';
import 'package:sala_shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModal {
  final String image;
  final String title;
  final String body;

  OnBoardingModal({
    @required this.image,
    @required this.title,
    @required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  static const String routeName = 'onBoarding';
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  final List<OnBoardingModal> boarding = [
    OnBoardingModal(
      image: 'assets/images/shop.png',
      title: 'Shop Now',
      body: 'best product and qulity',
    ),
    OnBoardingModal(
      image: 'assets/images/address.png',
      title: 'Delivery Home',
      body: 'Free delivere to your home stay save',
    ),
    OnBoardingModal(
      image: 'assets/images/trans.png',
      title: 'Big Sale',
      body: 'Big sale',
    ),
  ];

  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                LoginScreen.routeName,
                (Route<dynamic> route) => false,
              );
            },
            child: Text('Skip'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildOnBoardingItem(boarding[index]),
                itemCount: boarding.length,
                controller: boardController,
                onPageChanged: (int value) {
                  if (value == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5,
                    activeDotColor: defultColors,
                  ),
                ),
                Spacer(),
                FloatingActionButton.extended(
                  isExtended: true,
                  icon: Icon(Icons.arrow_forward_rounded),
                  label: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '  Next..',
                        speed: Duration(milliseconds: 350),
                      ),
                    ],
                    onTap: () {
                      if (isLast) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          LoginScreen.routeName,
                          (Route<dynamic> route) => false,
                        );
                      } else {
                        boardController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                  ),

                  onPressed: () {
                    if (isLast) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        LoginScreen.routeName,
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  // child: Icon(Icons.arrow_forward_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column buildOnBoardingItem(OnBoardingModal modal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${modal.image}'),
          ),
        ),
        SizedBox(height: 30),
        Text(
          '${modal.title}',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        SizedBox(height: 15),
        Text(
          '${modal.body}',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
