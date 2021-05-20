/* ************************************************************************
 * FILE : userInteraction.dart
 * DESC : Handles interaction with user collection in the database.
 * ************************************************************************
 */

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Breakthrough_Profile/data/globals.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserInteraction {
  // Table with user data
  static final CollectionReference users = FirebaseFirestore.instance.collection("Users");


  // Loads current user from the backend, creating UserAccount from JSON data
  Future<UserAccount> loadCurrentUser() async {
    String userId = '0';
    DocumentSnapshot userDoc = await users.doc(userId).get();
    return UserAccount().fromJson(userDoc.data(), userId);
  }

  // Updates user in Firebase, generating JSON data from UserAccount
  Future<void> updateUser(UserAccount user) async {
    Map<String, dynamic> userData = user.toJson();
    await users.doc('0').update(userData);
  }
}

class UserAccount {
  String id = '';
  String firstName = '';
  String lastName = '';
  String dateOfBirth = '';
  String profilePic = '';
  String profilePicPath = '';

  Map<String, dynamic> toJson() {
    return {
      FNAME: this.firstName,
      LNAME: this.lastName,
      DOB: this.dateOfBirth,
      PPIC: this.profilePicPath,
    };
  }

  // Builds from JSON data
  UserAccount fromJson(Map<String, dynamic> userData, String userId) {
    this.id = userId;
    this.firstName = userData[FNAME];
    this.lastName = userData[LNAME];
    this.dateOfBirth = userData[DOB];
    this.profilePic = userData[PPIC];
    this.profilePicPath = userData[PPIC].toString();

    return this;
  }

  UserAccount clone() {
    UserAccount clonedAccount = UserAccount();
    clonedAccount.id = this.id;
    clonedAccount.firstName = this.firstName;
    clonedAccount.lastName = this.lastName;
    clonedAccount.dateOfBirth = this.dateOfBirth;
    clonedAccount.profilePicPath = this.profilePicPath;

    return clonedAccount;
  }

  // Adds photo to Storage and sets user's profilePicPath to the new location
  addPhoto(image) async {
    TaskSnapshot taskSnapshot = await imageStorage.child('0').putFile(image);
    this.profilePicPath = await taskSnapshot.ref.getDownloadURL();
  }
}