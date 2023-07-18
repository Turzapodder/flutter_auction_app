import 'package:auctionapp/screens/login_page.dart';
import 'package:auctionapp/screens/onboarding_Screen.dart';
import 'package:auctionapp/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home:  SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/onboarding': (BuildContext context) => const OnboardingScreen(),
        '/signup': (BuildContext context) => const LoginPage()
      },
    );
  }
}


