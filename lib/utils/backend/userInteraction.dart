/* ************************************************************************
 * FILE : userInteraction.dart
 * DESC : Handles interaction with user collection in the database.
 * ************************************************************************
 */

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Breakthrough_Profile/data/globals.dart';

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
    String uid = FirebaseAuth.instance.currentUser.uid;
    await users.doc(uid).update(userData);
  }
}

class UserAccount {
  String id = '';
  String firstName = '';
  String lastName = '';
  String dateOfBirth = '';

  Map<String, dynamic> toJson() {

    return {
      FNAME: this.firstName,
      LNAME: this.lastName,
      DOB: this.dateOfBirth,
    };
  }

  // Builds from JSON data
  UserAccount fromJson(Map<String, dynamic> userData, String userId) {

    this.id = userId;
    this.firstName = userData[FNAME];
    this.lastName = userData[FNAME];
    this.dateOfBirth = userData[DOB];
 
    return this;
  }

  UserAccount clone() {
    UserAccount clonedAccount = UserAccount();
    clonedAccount.id = this.id;
    clonedAccount.firstName = this.firstName;
    clonedAccount.lastName = this.lastName;
    clonedAccount.dateOfBirth = this.dateOfBirth;

    return clonedAccount;
  }

}



// USED FOR BUG FIX

// CITE : https://github.com/flutter/flutter/issues/18547
// DESC : Fixes error-catching bug currently present in storage module
Future<T> runSafe<T>(Future<T> Function() func) {
  final onDone = Completer<T>();
  runZoned(
    func,
    onError: (e, s) {
      if (!onDone.isCompleted) {
        onDone.completeError(e, s as StackTrace);
      }
    },
  ).then((result) {
    if (!onDone.isCompleted) {
      onDone.complete(result);
    }
  });
  return onDone.future;
}