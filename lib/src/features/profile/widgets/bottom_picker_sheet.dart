import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';

void bottomPickerSheet(
    BuildContext context, Function imageFromCamera, Function imageFromGallery) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
            child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap: () {
                imageFromCamera();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                imageFromGallery();
                Navigator.pop(context);
              },
            )
          ],
        ));
      });
}

void logoutPicker(BuildContext context, Function logoutFromSingleDevice,
    Function logoutFromAllDevices) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: SafeArea(
              maintainBottomViewPadding: true,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                CTheme.of(context).theme.backgroundInverse,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            foregroundColor:
                                CTheme.of(context).theme.backgroundColor,
                          ),
                          onPressed: () {
                            logoutFromSingleDevice();
                            Navigator.pop(context);
                          },
                          child: const Text("Logout from this Device")),
                    ),
                    const Gap(10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: ElevatedButton(
                          style: CTheme.of(context).theme.buttonStyle,
                          onPressed: () {
                            logoutFromAllDevices();
                            Navigator.pop(context);
                          },
                          child: const Text("Logout from all Devices")),
                    ),
                  ],
                ),
              )),
        );
      });
}
