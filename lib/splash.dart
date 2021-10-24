import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';
import 'onboarding_page.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);


  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  SharedPreferences? preferences;

  void initState () {
    super.initState();
    initializePreference().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> initializePreference() async {
    this.preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    if (preferences == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (this.preferences?.getBool("didOnboardingDone") ?? false) {
      return LoginPage(preferences: preferences);
    }else {
      return OnboardingPage(preferences: preferences);
    }
  }
}
