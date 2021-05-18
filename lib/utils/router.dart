/* ************************************************************************
 * FILE : router.dart
 * DESC : Defines routes for navigation
 * ************************************************************************
 */

import 'package:flutter/material.dart';
import 'package:Breakthrough_Profile/data/theme.dart';
import 'package:Breakthrough_Profile/user/editProfile.dart';
import 'package:Breakthrough_Profile/user/profile.dart';
import 'package:Breakthrough_Profile/utils/backend/userInteraction.dart';




// Different named routes to aid in navigation
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {

    case '/profile':
      return MaterialPageRoute(builder: (context) => ProfilePage());
      break;

    // case '/editProfile':
    //   var userAccount = settings.arguments;
    //   return MaterialPageRoute(builder: (context) => EditProfilePage(userAccount));
    //   break;

    default:
      return null;
      break;
  }
}
