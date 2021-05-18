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

// User profile page widget
class ProfilePage extends StatefulWidget {

  ProfilePage();

  @override
  ProfilePageState createState() => new ProfilePageState();
}

// Dynamic data for profile
class ProfilePageState extends State<ProfilePage> {
  UserAccount userAccount;
  
  void getUser() async {
    UserAccount currentUser = await UserInteraction().loadCurrentUser();
    this.userAccount = currentUser;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  showFullName(){
    return this.userAccount == null
      ? Container()
      : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Username
              Text(
                this.userAccount.firstName + " " + this.userAccount.lastName,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 14.0),
            ],
          ),
        );
  }


  Widget profileEditButton() {
    return IconButton(
      icon: Icon(Icons.edit),
      tooltip: 'Edit',
      onPressed: () {
        locator<NavigationService>().navigateWithParameters(
          '/profileEdit',
          this.userAccount
        ).then((result) {

          // Update account
          if (result != null && result is UserAccount) {
            setState(() { this.userAccount = result; });
          }
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    return userAccount == null
    ? Container(color: Colors.white, 
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white, 
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          )
        )
      )
    : Scaffold(
        appBar: AppBar(
          title: Text("Hello"),
          actions: [
            profileEditButton()
          ],
        ),
        
        body:  ListView(
          children: <Widget>[Padding(
            padding: STANDARD_SPACING,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                showFullName(),
              ]
            )
            ),
          ]
        )
    );
  }
}
