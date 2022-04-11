import 'package:flutter/material.dart';
import 'package:shop_app/data/model/on_boarding_model.dart';
import 'package:shop_app/presentation/modules/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/local/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModel> onBoarding = [
    OnBoardingModel(
      image: "assets/images/onboarding_6.jpg",
      title: 'title',
      describe: 'describe',
    ),
    OnBoardingModel(
      image: "assets/images/onboarding_5.png",
      title: 'title',
      describe: 'describe',
    ),
    OnBoardingModel(
      image: "assets/images/onboarding_3.jpg",
      title: 'title',
      describe: 'describe',
    ),
  ];
  final controller = PageController();
  int currentIndex = 0 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemBuilder: (context, index) => buildOnBoarding(onBoarding[index]),
                    itemCount: onBoarding.length,
                    physics: const BouncingScrollPhysics(),
                    controller: controller,
                    onPageChanged: (int index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                ),
                SmoothPageIndicator(
                  controller: controller,
                  count: onBoarding.length,
                  effect: const WormEffect(
                    dotColor: Colors.pinkAccent,
                    activeDotColor: Colors.blue,
                    spacing: 12,
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextButton(
                          onPressed: () {
                            SharedPreferencesData.saveData(key: "onBoarding", value: true) ;
                            Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context)=>  const LoginScreen(),));
                          },
                          child: const Text('Skip',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ),
                    const Spacer(),
                    Container(
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextButton(
                          onPressed: () {
                            if (currentIndex == onBoarding.length-1) {
                              SharedPreferencesData.saveData(key: "onBoarding", value: true) ;
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context)=>  const LoginScreen(),));
                            }
                            else {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeIn);
                            }
                          },
                          child: const Text('Next',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget buildOnBoarding(OnBoardingModel onBoardingModel) {
    return Column(
      children: [
        Expanded(
          child: Image(
            image: AssetImage(onBoardingModel.image),
          ),
        ),
        Text(
          onBoardingModel.title,
          style: const TextStyle(
              fontFamily: "LibreBaskerville",
              fontSize: 30,
              color: Colors.pinkAccent,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          onBoardingModel.describe,
          style: const TextStyle(fontFamily: "LibreBaskerville", fontSize: 30),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
