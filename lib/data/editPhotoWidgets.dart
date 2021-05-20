/* ************************************************************************
 * FILE : editPhotoWidgets.dart
 * DESC : Contains chooseImage() and editProfilePicture(), 
 *        used in editProfile.dart 
 * ************************************************************************
 */

import 'dart:io';
import 'package:Breakthrough_Profile/utils/backend/userInteraction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

// Function used in editProfilePicture(), allows user to select and crop image
chooseImage(UserAccount account) async {

  // Opens camera roll, allows user to choose an image
  PickedFile image = await ImagePicker().getImage(source: ImageSource.gallery);

  if (image == null)
    return;

  // Then takes the chosen image and allows the user to crop it
  File croppedImage = await ImageCropper.cropImage(
    sourcePath: image.path,
    maxWidth: 67,
    maxHeight: 67,
    aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
  );

  if (croppedImage == null)
    return;

  File file = File(croppedImage.path);

  // Adds the photo to Firebase Storage and sets the user's profilePicPath to the new image location
  await account.addPhoto(file);
}


// Function used in editProfile.dart, allows user to change their profile picture
Widget editProfilePicture(UserAccount account) {
  return Stack(
    children: [
      Container(
        width: 120,
        height: 120,
        // Displays the user's existing profile picture
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(account.profilePicPath, fit: BoxFit.cover),
        )
      ),
      Container(
        width: 120,
        height: 120,
        // A semi-transparent button that when clicked, allows user to upload new profile picture
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: FlatButton(
            child: Icon(CupertinoIcons.camera, color: Colors.white),
            color: Colors.black.withOpacity(0.5),
            onPressed: () {
              chooseImage(account);
            },
          ),
        )
      )
    ]
  );
}