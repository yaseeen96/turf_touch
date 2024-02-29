import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';
import 'package:turf_touch/src/shared/validators/validators.dart';
import 'package:turf_touch/src/shared/widgets/app_bar.dart';
import 'package:turf_touch/src/shared/widgets/make_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  String? email;
  String? fName;
  String? lName;

  String? mobileNumber;
  String? pass;
  String? confirmPass;
  void onLoginPress() {
    context.go("/login");
  }

  void onSignupPress() {
    if (formKey.currentState == null) {
      return;
    }
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: CTheme.of(context).theme.backgroundColor,
      appBar: const TurfTouchAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: Text(
                        "Sign up",
                        style: CTheme.of(context).theme.heading,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1200),
                      child: Text(
                        "Create an account, It's free",
                        style: CTheme.of(context).theme.bodyText,
                      )),
                ],
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: MakeInput(
                          label: "First Name",
                          validator: (value) {
                            return nameValidator(value);
                          },
                          onSaved: (value) {
                            fName = value;
                          },
                        )),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: MakeInput(
                          label: "Last Name",
                          validator: (value) {
                            return nameValidator(value);
                          },
                          onSaved: (value) {
                            lName = value;
                          },
                        )),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: MakeInput(
                          label: "Email",
                          validator: (value) {
                            return emailValidator(value);
                          },
                          onSaved: (value) {
                            email = value;
                          },
                        )),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: MakeInput(
                          label: "Mobile Number",
                          validator: (value) {
                            return mobileNumberValidator(value);
                          },
                          onSaved: (value) {
                            mobileNumber = value;
                          },
                        )),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1300),
                        child: MakeInput(
                          label: "Password",
                          onChanged: (value) {
                            pass = value;
                          },
                          obscureText: true,
                          validator: (value) {
                            return passwordValidator(value);
                          },
                          onSaved: (value) {
                            email = value;
                          },
                        )),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1400),
                      child: MakeInput(
                        label: "Confirm Password",
                        obscureText: true,
                        validator: (value) {
                          if (value != pass) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          email = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              FadeInUp(
                  duration: const Duration(milliseconds: 1500),
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
                      child: Text(
                        "Sign up",
                        style: CTheme.of(context).theme.subheading,
                      ),
                    ),
                  )),
              FadeInUp(
                duration: const Duration(milliseconds: 1600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: CTheme.of(context).theme.label,
                    ),
                    InkWell(
                      onTap: onLoginPress,
                      child: Text(
                        " Login",
                        style: CTheme.of(context).theme.bodyText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
