import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';
import 'package:turf_touch/src/features/profile/widgets/image_picker.dart';
import 'package:turf_touch/src/shared/validators/validators.dart';
import 'package:turf_touch/src/shared/widgets/make_input.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final formKey = GlobalKey<FormState>();
  File? _pickedImage;
  String? fname;
  String? lname;
  String? email;
  String? mobileNumber;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: CTheme.of(context).theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  color: CTheme.of(context).theme.backgroundInverse),
              child: TurfTouchImagePicker(
                onImagePicked: (File? image) {
                  setState(() {
                    _pickedImage = image;
                  });
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MakeInput(
                            label: "First Name",
                            validator: (value) => nameValidator(value),
                            onSaved: (value) {
                              fname = value;
                            },
                          ),
                          MakeInput(
                            label: "Last Name",
                            validator: (value) => nameValidator(value),
                            onSaved: (value) {
                              lname = value;
                            },
                          ),
                          MakeInput(
                            label: "Email",
                            validator: (value) => emailValidator(value),
                            onSaved: (value) {
                              email = value;
                            },
                          ),
                          MakeInput(
                            label: "Mobile Number",
                            validator: (value) => mobileNumberValidator(value),
                            onSaved: (value) {
                              fname = value;
                            },
                          ),
                          MakeInput(
                            label: "Password",
                            validator: (value) => passwordValidator(value),
                            onSaved: (value) {
                              fname = value;
                            },
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: CTheme.of(context)
                                      .theme
                                      .backgroundInverse,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  foregroundColor:
                                      CTheme.of(context).theme.backgroundColor,
                                ),
                                onPressed: () {},
                                child: const Text("Update Profile")),
                          ),
                          const Gap(20),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: ElevatedButton(
                                style: CTheme.of(context).theme.buttonStyle,
                                onPressed: () {},
                                child: const Text("Logout")),
                          ),
                        ])),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
