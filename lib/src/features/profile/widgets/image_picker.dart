import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turf_touch/src/features/profile/widgets/alert_dialog.dart';
import 'package:turf_touch/src/features/profile/widgets/bottom_picker_sheet.dart';

class TurfTouchImagePicker extends StatefulWidget {
  final Function(File?) onImagePicked;
  final String? imageUrl;
  const TurfTouchImagePicker({
    super.key,
    required this.onImagePicked,
    this.imageUrl,
  });

  @override
  TurfTouchImagePickerState createState() => TurfTouchImagePickerState();
}

class TurfTouchImagePickerState extends State<TurfTouchImagePicker> {
  final ImagePicker _picker = ImagePicker();

  File? _image;
  bool uploadStatus = false;

  _imageFromCamera() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (pickedImage == null) {
      if (!context.mounted) {
        return;
      }
      showAlertDialog(
          context: context,
          title: "Error Uploading!",
          content: "No Image was selected.");
      return;
    }
    final File fileImage = File(pickedImage.path);

    if (imageConstraint(fileImage)) {
      setState(() {
        _image = fileImage;
      });
      widget.onImagePicked(fileImage);
    }
  }

  _imageFromGallery() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedImage == null) {
      if (!context.mounted) {
        return;
      }
      showAlertDialog(
          context: context,
          title: "Error Uploading!",
          content: "No Image was selected.");
      return;
    }
    final File fileImage = File(pickedImage.path);
    if (imageConstraint(fileImage)) {
      setState(() {
        _image = fileImage;
      });
      widget.onImagePicked(fileImage);
    }
  }

  bool imageConstraint(File image) {
    if (!['bmp', 'jpg', 'jpeg']
        .contains(image.path.split('.').last.toString())) {
      showAlertDialog(
          context: context,
          title: "Error Uploading!",
          content: "Image format should be jpg/jpeg/bmp.");
      return false;
    }
    if (image.lengthSync() > 1000000) {
      showAlertDialog(
          context: context,
          title: "Error Uploading!",
          content: "Image Size should be less than 1 MB.");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        // Display Progress Indicator if uploadStatus is true
        child: uploadStatus
            ? const SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  strokeWidth: 7,
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 40),
                child: GestureDetector(
                  onTap: () {
                    bottomPickerSheet(
                        context, _imageFromCamera, _imageFromGallery);
                  },
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width / 5,
                        backgroundColor: Colors.grey,
                        backgroundImage: (_image != null)
                            ? FileImage(_image!)
                            : (widget.imageUrl != "" && widget.imageUrl != null)
                                ? NetworkImage(widget.imageUrl!)
                                    as ImageProvider<Object>?
                                : const AssetImage('assets/camera_img.png'),
                      ),
                      const Positioned(
                        bottom: 15,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.edit),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
