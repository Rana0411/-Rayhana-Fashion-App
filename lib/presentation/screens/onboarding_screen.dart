import 'package:fashion_app/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/models/onboarding_model.dart';
import '../../generated/assets.dart'; 
 

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
  static const routeName ='onboardingScreen';
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0); 
  int _currentPage = 0;

  final List<OnboardingItemModel> onboardingPages = [
    OnboardingItemModel(
      imagePath: Assets.imagesImagePageview2, 
      title: 'Choose Products',
      description: 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
    OnboardingItemModel(
      imagePath: Assets.imagesImagePageview2, 
      title: 'Make Payment',
      description: 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
    OnboardingItemModel(
      imagePath: Assets.imagesImagePageview3,
      title: 'Get Your Order',
      description: 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose(); /
    super.dispose();
  }


  Widget _buildPageIndicator(int index) {
    return Container(
      width: _currentPage == index ? 24 : 8, 
      height: 8,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.black : Colors.grey[300], 
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  
  Widget _buildOnboardingPage(OnboardingItemModel item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          SvgPicture.asset(
            Assets.imagesImagePageview2 
            
          ),
          SizedBox(height: 40), 
          Text(
            item.title, 
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center, 
          ),
          SizedBox(height: 16),
          Text(
            item.description, 
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, 
      statusBarIconBrightness: Brightness.dark, 
    ));

    return Scaffold(
      body: Stack( 
        children: [
         
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingPages.length, 
            onPageChanged: (int page) { 
              setState(() {
                _currentPage = page; 
              });
            },
            itemBuilder: (context, index) {
              return _buildOnboardingPage(onboardingPages[index]);

            },
          ),
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_currentPage + 1}/${onboardingPages.length}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {


                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                            fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                _currentPage > 0
                    ? GestureDetector(
                  onTap: () {
                    _pageController.previousPage(

                      duration: Duration(milliseconds: 300),

                      curve: Curves.easeIn,

                    );
                  },
                  child: Text(
                    'previous',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    : SizedBox(width: 50),

                Row(
                  children: List.generate(
                    onboardingPages.length,
                        (index) => _buildPageIndicator(index),
                  ),
                ),


                _currentPage == onboardingPages.length - 1
                    ? GestureDetector(
                  onTap: () {

                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text( "Get Started"
                    ,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    : GestureDetector(
                  onTap: () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Text(
                    'next',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
