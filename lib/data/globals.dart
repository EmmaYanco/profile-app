/* ************************************************************************
 * FILE : globals.dart
 * DESC : Stores the constant values for the application. 
 * ************************************************************************
 */

import 'package:firebase_storage/firebase_storage.dart';

// Reference to photo storage
final Reference imageStorage = FirebaseStorage.instance.ref().child(IMAGES);

// Strings for backend interaction
const UID = 'uid';
const FNAME = 'firstName';
const LNAME = 'lastName';
const DOB = 'dateOfBirth';
const IMAGES = 'images';
const PPIC = "profilePic";

// Used for formatting on the page
const BOTTOM_BOX_SIZE = (16/21);
const PICTURE_SIZE = 120.0;

// String of background image path
const BACKGROUND_IMAGE = 'assets/blue_background.jpeg';