import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';
import 'package:turf_touch/src/features/profile/providers/get_profile_provider.dart';
import 'package:turf_touch/src/features/profile/services/update_profile_service.dart';
import 'package:turf_touch/src/features/profile/widgets/bottom_picker_sheet.dart';
import 'package:turf_touch/src/features/profile/widgets/image_picker.dart';
import 'package:turf_touch/src/shared/exceptions/exceptions.dart';
import 'package:turf_touch/src/shared/helpers/convert_to_12.dart';
import 'package:turf_touch/src/shared/providers/name_provider.dart';
import 'package:turf_touch/src/shared/validators/validators.dart';
import 'package:turf_touch/src/shared/widgets/make_input.dart';
import 'package:turf_touch/src/shared/widgets/top_snackbar.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final storage = const FlutterSecureStorage();
  final formKey = GlobalKey<FormState>();
  File? _pickedImage;
  String? fname;
  String? lname;
  String? email;
  String? mobileNumber;
  String? password;
  bool isLoading = false;
  void onUpdateProfile({
    required String dataFirstName,
    required String dataMobile,
    required String dataLastName,
  }) async {
    if (formKey.currentState == null) {
      logger.e("formkey is null");
      return;
    }
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      // after saving form operations
      try {
        setState(() {
          isLoading = true;
        });
        final response = await updateProfileService(
          firstName: fname ?? dataFirstName,
          lastName: lname ?? dataLastName,
          mobileNumber: mobileNumber ?? dataMobile,
          password: password,
          file: _pickedImage,
        );
        if (response) {
          if (!context.mounted) {
            return;
          }
          storage.write(key: "name", value: fname ?? dataFirstName);
          ref.invalidate(fullNameProvider);
          ref.invalidate(getProfileProvider);
          if (!mounted) return;
          getSnackBar(context: context, message: "Profile Updated");
        }
      } on TurfTouchException catch (err) {
        if (!context.mounted) {
          return;
        }
        if (!mounted) return;
        getSnackBar(
            context: context, message: err.message, type: SNACKBARTYPE.error);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void logoutSingle() {
    const storage = FlutterSecureStorage();
    storage.delete(key: "token");
    storage.delete(key: "name");
    context.go("/auth_landing");
  }

  void logoutAll() {
    const storage = FlutterSecureStorage();
    storage.delete(key: "token");
    storage.delete(key: "name");
    context.go("/auth_landing");
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(getProfileProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: CTheme.of(context).theme.backgroundColor,
      appBar: AppBar(
        foregroundColor: CTheme.of(context).theme.backgroundColor,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: profile.when(
        data: (data) {
          return Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: CTheme.of(context).theme.backgroundInverse),
                  child: TurfTouchImagePicker(
                    imageUrl: data.profile,
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
                                value: data.firstName,
                                label: "First Name",
                                validator: (value) => nameValidator(value),
                                onSaved: (value) {
                                  fname = value;
                                },
                              ),
                              MakeInput(
                                value: data.lastName,
                                label: "Last Name",
                                validator: (value) => nameValidator(value),
                                onSaved: (value) {
                                  lname = value;
                                },
                              ),
                              MakeInput(
                                isReadOnly: true,
                                value: data.email,
                                label: "Email",
                                validator: (value) => emailValidator(value),
                                onSaved: (value) {
                                  email = value;
                                },
                              ),
                              MakeInput(
                                value: data.phoneNo,
                                label: "Mobile Number",
                                validator: (value) =>
                                    mobileNumberValidator(value),
                                onSaved: (value) {
                                  mobileNumber = value;
                                },
                              ),
                              MakeInput(
                                label: "Password",
                                validator: (value) => null,
                                onSaved: (value) {
                                  fname = value;
                                },
                                isPassword: true,
                              ),
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: CTheme.of(context)
                                          .theme
                                          .backgroundInverse,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      foregroundColor: CTheme.of(context)
                                          .theme
                                          .backgroundColor,
                                    ),
                                    onPressed: (isLoading
                                        ? () {}
                                        : () {
                                            onUpdateProfile(
                                              dataFirstName: data.firstName!,
                                              dataLastName: data.lastName!,
                                              dataMobile: data.phoneNo!,
                                            );
                                          }),
                                    child: isLoading
                                        ? const CircularProgressIndicator()
                                        : const Text("Update Profile")),
                              ),
                              const Gap(20),
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                    style: CTheme.of(context).theme.buttonStyle,
                                    onPressed: () {
                                      logoutPicker(
                                          context, logoutSingle, logoutAll);
                                    },
                                    child: const Text("Logout")),
                              ),
                            ])),
                  ),
                ),
              ),
            ],
          );
        },
        error: (err, stk) {
          return const Center(
            child: Text("Uh Oh.. Something went Wrong."),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
