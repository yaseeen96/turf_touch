import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';
import 'package:turf_touch/src/features/authentication/login/services/login_service.dart';
import 'package:turf_touch/src/shared/exceptions/exceptions.dart';
import 'package:turf_touch/src/shared/validators/validators.dart';
import 'package:turf_touch/src/shared/widgets/app_bar.dart';
import 'package:turf_touch/src/shared/widgets/make_input.dart';
import 'package:turf_touch/src/shared/widgets/top_snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? pass;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  void onSignupPress() {
    context.go("/signup");
  }

  void onLoginPress() async {
    if (formKey.currentState == null) {
      return;
    }
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      // after saving form operations
      try {
        setState(() {
          isLoading = true;
        });
        final response = await loginService(email!, pass!);
        const storage = FlutterSecureStorage();
        storage.write(key: "token", value: response.token);
        storage.write(key: "name", value: response.user!.firstName);
        if (!context.mounted) {
          return;
        }
        context.go("/home");
      } on TurfTouchException catch (err) {
        if (!context.mounted) {
          return;
        }
        getSnackBar(
            context: context, message: err.message, type: SNACKBARTYPE.error);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CTheme.of(context).theme.backgroundColor,
      appBar: const TurfTouchAppBar(),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: FadeInUp(
                duration: const Duration(milliseconds: 1200),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/background.png'),
                    fit: BoxFit.cover,
                  )),
                )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          FadeInUp(
                              duration: const Duration(milliseconds: 1000),
                              child: Text(
                                "Login",
                                style: CTheme.of(context).theme.heading,
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          FadeInUp(
                              duration: const Duration(milliseconds: 1200),
                              child: Text(
                                "Login to your account",
                                style: CTheme.of(context).theme.label,
                              )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
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
                                  duration: const Duration(milliseconds: 1300),
                                  child: MakeInput(
                                    label: "Password",
                                    obscureText: true,
                                    validator: (value) {
                                      // TODO - Add passwordValidator
                                      // return passwordValidator(value);
                                      return null;
                                    },
                                    onSaved: (value) {
                                      pass = value;
                                    },
                                  )),
                            ],
                          ),
                        ),
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1400),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: MaterialButton(
                                minWidth: double.infinity,
                                height: 60,
                                onPressed: isLoading ? () {} : onLoginPress,
                                color: CTheme.of(context).theme.primaryColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                child: (isLoading)
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        "Login",
                                        style:
                                            CTheme.of(context).theme.subheading,
                                      ),
                              ),
                            ),
                          )),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1500),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: CTheme.of(context).theme.label,
                              ),
                              const Gap(5),
                              InkWell(
                                onTap: onSignupPress,
                                child: Text("Sign up",
                                    style: CTheme.of(context).theme.bodyText),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                FadeInUp(
                    duration: const Duration(milliseconds: 1200),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3.2,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
