/* ************************************************************************
 * FILE : profile.dart
 * DESC : User profile page displaying one's name, photo, and DOB.
 * ************************************************************************
 */

import 'package:Breakthrough_Profile/data/editDOBWidgets.dart';
import 'package:Breakthrough_Profile/data/editPhotoWidgets.dart';
import 'package:Breakthrough_Profile/data/editTextWidgets.dart';
import 'package:Breakthrough_Profile/data/globals.dart';
import 'package:Breakthrough_Profile/utils/backend/userInteraction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Breakthrough_Profile/utils/navigation.dart';

// User profile page widget
class EditProfilePage extends StatefulWidget {

  EditProfilePage(this.account);
  final UserAccount account;

  @override
  EditProfilePageState createState() => new EditProfilePageState();
}

// Dynamic data for profile
class EditProfilePageState extends State<EditProfilePage> {

  UserAccount account;
  String chosenDateTime;
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();

  void initState() {
    super.initState();
    // Create a clone so database won't be updated unless user confirms changes
    this.account = this.widget.account.clone();
    // Set the initial value of the DOB field to the current DOB
    textEditingController.text = account.dateOfBirth;
  }

  // Generates popup asking user to confirm changes
  AlertDialog generateConfirmDialog() {
    return AlertDialog(
      title: const Text("Update account"),
      content: const Text("Confirm changes?"),
      actions: <Widget>[

        // Cancel button
        FlatButton(
          child: const Text("Cancel"),
          onPressed: () => locator<NavigationService>().pop(),
        ),

        // Confirm button
        FlatButton(
          child: const Text("Confirm"),
          onPressed: () async {
            // Update account
            UserInteraction().updateUser(this.account);
            // Return to profile page
            locator<NavigationService>().pop(num: 2, result: this.account);
          },
        ),
      ],
    );
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

  // Creates a column of the main widgets on the screen that edit the user's information
  Padding editableFields(BuildContext context, double height) {
    return Padding(
      padding: EdgeInsets.only(left: 24.0, right: 24.0), 
      child: Form(
        key: formKey, 
        child: Column(
          children: [
            SizedBox(height: (height * (1 - BOTTOM_BOX_SIZE)) - (PICTURE_SIZE / 2)),
            editProfilePicture(account),
            SizedBox(height: 5),
            firstNameField(account),
            SizedBox(height: 5),
            lastNameField(account),
            SizedBox(height: 5),
            dobField(context, account, textEditingController, chosenDateTime),
          ],
        )
      )
    );
  }


  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;

    return account == null
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
    : Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true, 
        appBar: AppBar(
          title: Text('Edit Profile'),
          backgroundColor: Colors.transparent,
          elevation: 0.0,),

        // Save button
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.done),
          backgroundColor: Colors.lightBlue[900],
          onPressed: () {
            formKey.currentState.save();
            if (formKey.currentState.validate()) {
              showDialog(
              context: context,
              child: generateConfirmDialog(),
              );
            }
          },
        ),

        // Stack of widgets on the screen
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            backgroundImage(),
            bottomBox(height),
            editableFields(context, height),
          ]
        )
      );
  }
}
