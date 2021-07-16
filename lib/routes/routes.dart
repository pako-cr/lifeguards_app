import 'package:flutter/material.dart';

import '../pages/Auth/Splash/splash_page.dart';
import '../pages/Auth/SignIn/signin_page.dart';
import '../pages/Auth/SignUp/signup_page.dart';
import '../pages/Home/Home/home_page.dart';
import '../pages/Home/Reports/reports_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'signin': (_) => SignInPage(),
  'signup': (_) => SignUpPage(),
  'splash': (_) => SplashPage(),
  'home': (_) => HomePage(),
  'reports': (_) => ReportsPage(),
};
