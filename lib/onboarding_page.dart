import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preference_ornek/pageview_content.dart';
import 'package:shared_preference_ornek/pageview_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key, this.preferences}) : super(key: key);
  final SharedPreferences? preferences;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentPage = 0;
  final int numPages = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5B16D0),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Center(
                child: Text(
                  "Onboarding",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 300,
                child: PageView.builder(
                  onPageChanged: (int value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: numPages,
                  itemBuilder: (context, index) => PageviewScreen(
                    image: pageviewItem[index]["image"],
                    text: pageviewItem[index]["text"],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pageviewItem.length,
                      (index) => _buildDot(index: index, currentPage: currentPage),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [_buildNextButton(currentPage: currentPage)],
                ),
              ),
              const SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }

  Visibility _buildNextButton ({currentPage}) {
    return Visibility(
      maintainState: true,
      maintainAnimation: true,
      maintainSize: true,
      visible: currentPage == pageviewItem.length - 1 ? true : false,
      child: GestureDetector(
        onTap: () {
          setState(() {
            this.widget.preferences?.setBool("didOnboardingDone", true);
          });
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.orange,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(children: const [
              Text('Next',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 10.0,),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 24.0,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  AnimatedContainer _buildDot({index, currentPage}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      height: 5,
      width: index == currentPage ? 20 : 5,
      decoration: BoxDecoration(
        color: index == currentPage ? Colors.amber : Colors.white,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}



