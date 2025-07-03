import 'package:fashion_app/presentation/screens/onboarding_screen.dart';
import 'package:fashion_app/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import '../presentation/screens/login_screen.dart';


Route? generateRoute(RouteSettings setting){
  switch(setting.name){
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (context)=>SplashScreen());
    case OnboardingScreen.routeName:
      return MaterialPageRoute(builder: (context)=>OnboardingScreen());
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context)=>LoginScreen());

  }
}