/* ************************************************************************
 * FILE : globals.dart
 * DESC : Stores the constant values for the application. 
 * ************************************************************************
 */

import 'package:firebase_storage/firebase_storage.dart';
import 'package:Breakthrough_Profile/data/theme.dart';
import 'package:flutter/material.dart';


// Reference to photo storage
final Reference imagesStorage = FirebaseStorage.instance.ref().child(IMAGE);

// Constants
const PRIMARY_COLOR = Color(0xFF0c2771);
const SECONDARY_COLOR = Color(0xFFa6b4db);
const SETUP_SPACING = EdgeInsets.only(left: 24.0, right: 24.0, bottom: 120.0);
const STANDARD_SPACING = EdgeInsets.only(top: 48.0, left: 24.0, right: 24.0, bottom: 80.0);

// Strings for backend interaction
const UID = 'uid';
const FNAME = 'firstName';
const LNAME = 'lastName';
const DOB = 'dateOFBirth';
const IMAGE = 'image';

// Strings repreated in-app
const CATEGORY_PROMPT = "Category";
const LIGHT = 'Light Mode';
const DARK ='Dark Mode';
const SYSTEM = 'System';
const CURRENT_THEME = 'current_theme';


// Theming values
//CurrentTheme currentTheme = CurrentTheme();

// Theme modes names
const List<String> themeNames = [
  LIGHT,
  DARK,
  SYSTEM
];
