import 'package:flutter/material.dart';
import 'package:neph_care_user/constants/routes.dart';
import 'package:neph_care_user/screens/auth_screens/choose_login_signup.dart';
import 'package:neph_care_user/screens/auth_screens/login.dart';
import 'package:neph_care_user/screens/auth_screens/signup.dart';
import 'package:neph_care_user/screens/auth_screens/splashscreen.dart';
import 'package:neph_care_user/screens/bottom_navigation_bar/bottom_navigation/bottom_navigation_bar.dart';
import 'package:neph_care_user/screens/bottom_navigation_bar/navigation_pages/Profile/edit_profile.dart';
import 'package:neph_care_user/screens/bottom_navigation_bar/navigation_pages/Profile/my_wallet.dart';
import 'package:neph_care_user/screens/bottom_navigation_bar/navigation_pages/Profile/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        // theme: ThemeData(
        //   // primarySwatch: Colors.blue,
        // ),
        home: const SplashScreen(),
        onGenerateRoute: (RouteSettings settings) {
          // Choose Login SignUp Route
          if (settings.name == chooseloginsignuproute) {
            return MaterialPageRoute(
                builder: (context) => const ChooseLoginSignupPage());
          }

          // Choose Login SignUp Route
          if (settings.name == bottomnavigationroute) {
            return MaterialPageRoute(
                builder: (context) => const MyNavigationBar());
          }

          // Login Route
          if (settings.name == loginroute) {
            return MaterialPageRoute(builder: (context) => const Login());
          }

          // signup Route
          if (settings.name == signuproute) {
            return MaterialPageRoute(builder: (context) => const SignUp());
          }
          if (settings.name == mywalletroute) {
            return MaterialPageRoute(builder: (context) =>  MyWallet());
          }
          if (settings.name == editprofileroute) {
            return MaterialPageRoute(builder: (context) =>  Editprofile());
          }
          if (settings.name == profileroute) {
            return MaterialPageRoute(builder: (context) =>  ProfilePage());
          }
        });
  }
}
