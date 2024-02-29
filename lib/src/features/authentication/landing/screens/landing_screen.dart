import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';
import 'package:turf_touch/src/shared/widgets/app_bar.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  void onLoginPress() {
    context.push("/login");
  }

  void onSignupPress() {
    context.push("/signup");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CTheme.of(context).theme.backgroundColor,
      appBar: const TurfTouchAppBar(),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: Text(
                        "Welcome",
                        style: CTheme.of(context).theme.heading,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1200),
                      child: Text(
                        "🏆 Quick & Easy Turf Booking! Secure Your Ideal Sports Venue Instantly! ⚽🎾",
                        textAlign: TextAlign.center,
                        style: CTheme.of(context).theme.label,
                      )),
                ],
              ),
              FadeInUp(
                  duration: const Duration(milliseconds: 1400),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/Illustration.png'))),
                  )),
              Column(
                children: [
                  FadeInUp(
                      duration: const Duration(milliseconds: 1500),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: onLoginPress,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color:
                                    CTheme.of(context).theme.backgroundInverse),
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          "Login",
                          style: CTheme.of(context).theme.subheading,
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1600),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: onSignupPress,
                        color: CTheme.of(context).theme.primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: Text("Sign up",
                            style: CTheme.of(context).theme.subheading),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
