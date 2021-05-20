/* ************************************************************************
 * FILE : router.dart
 * DESC : Defines routes for navigation
 * ************************************************************************
 */

import 'package:flutter/material.dart';
import 'package:Breakthrough_Profile/user/editProfile.dart';
import 'package:Breakthrough_Profile/user/profile.dart';



// Different named routes to aid in navigation
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {

    case '/profile':
      var userAccount = settings.arguments;
      return MaterialPageRoute(builder: (context) => ProfilePage(userAccount));
      break;

     case '/editProfile':
       var userAccount = settings.arguments;
       return MaterialPageRoute(builder: (context) => EditProfilePage(userAccount));
       break;

    default:
      return null;
      break;
  }
}
