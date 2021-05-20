/* ************************************************************************
 * FILE : profile.dart
 * DESC : User profile page displaying one's personal info
 *        with options to edit and log-out.
 * ************************************************************************
 */

import 'package:Breakthrough_Profile/data/globals.dart';
import 'package:Breakthrough_Profile/utils/backend/userInteraction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Breakthrough_Profile/utils/navigation.dart';
import 'package:google_fonts/google_fonts.dart';

// User profile page widget
class ProfilePage extends StatefulWidget {

  ProfilePage(this.account);
  final UserAccount account;

  @override
  ProfilePageState createState() => new ProfilePageState();
}

// Dynamic data for profile
class ProfilePageState extends State<ProfilePage> {
  
  UserAccount userAccount;

  @override
  void initState() {
    super.initState();
    this.userAccount = this.widget.account;
  }

  // Displays the static background image
  Align backgroundImage() {
    return Align(
      alignment: Alignment.topCenter, 
      child: Image.asset(BACKGROUND_IMAGE)
    );
  }

  // Displays the bottom white curved box (purely for design)
  Align bottomBox(double height) {
    return Align(
      alignment: Alignment.bottomCenter, 
      child: Container(
        height: (height * BOTTOM_BOX_SIZE),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.0),
          color: Colors.white
        ),
      ),
    );
  }

  // Displays user's current profile picture
  Container profilePicture() {
    return Container(
      width: PICTURE_SIZE,
      height: PICTURE_SIZE,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(this.userAccount.profilePicPath, fit: BoxFit.cover),
      )
    );
  }

  // Displays user's full name
  Material fullName() {
    return Material(
      child: Text(
        this.userAccount.firstName + " " + this.userAccount.lastName, 
        style: GoogleFonts.pattaya(textStyle: TextStyle(color: Colors.black, fontSize: 32))
      ),
    );
  }

  // Displays user's current DOB
  Material dateOfBirth() {
    return Material(
      child: Text(
        this.userAccount.dateOfBirth, 
        style: TextStyle(color: Colors.black)
      )
    );
  }

  // Button to navigate to the editProfile page
  Positioned editProfileButton(double height) {
    return Positioned(bottom: 15,
      child: RaisedButton(
        child: Text("Edit Profile"),
        onPressed: () {
          this.userAccount == null
          ? Container()
          : locator<NavigationService>().navigateWithParameters('/editProfile',this.userAccount).then((result) {
              if (result != null && result is UserAccount) {
                setState(() { 
                  this.userAccount = result; 
                });
              }
          });
        },
      )
    );
  }

  Column userInfo(double height) {
    return Column(
      children: [
        SizedBox(height: (height * (1 - BOTTOM_BOX_SIZE)) - (PICTURE_SIZE / 2)),
        profilePicture(),
        SizedBox(height: 5),
        fullName(),
        SizedBox(height: 5),
        dateOfBirth(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;

    return userAccount == null
    // If the account has not been grabbed yet, display a loading screen
    ? Container(
        color: Colors.white, 
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white, 
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          )
        )
      )

    // Stack of widgets on the screen
    : Stack(
      alignment: Alignment.center,
      children: <Widget>[
        backgroundImage(),
        bottomBox(height),
        userInfo(height),
        editProfileButton(height)
      ]
    );
  }
}
