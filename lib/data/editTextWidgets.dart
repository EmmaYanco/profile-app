/* ************************************************************************
 * FILE : editTextWidgets.dart
 * DESC : Contains firstNameField() and lastNameField(), 
 *        used in editProfile.dart 
 * ************************************************************************
 */

import 'package:Breakthrough_Profile/utils/backend/userInteraction.dart';
import 'package:flutter/material.dart';

// Function used in editProfile.dart to change the user's first name
TextFormField firstNameField(UserAccount account) {
  return TextFormField(
    initialValue: account.firstName,
    onSaved: (value) => account.firstName = value,
    maxLengthEnforced: true,
    maxLength: 30,
    autofocus: false,
    validator: (value) => 
      value.length == 0 ? 'First name cannot be blank.' : null,
    decoration: InputDecoration(
      labelText: 'First Name',
    ),
  );
}

// Function used in editProfile.dart to change the user's last name
TextFormField lastNameField(UserAccount account) {
  return TextFormField(
    initialValue: account.lastName,
    onSaved: (value) => account.lastName = value,
    maxLengthEnforced: true,
    maxLength: 30,
    autofocus: false,
    validator: (value) =>
      value.length == 0 ? 'Last name cannot be blank.' : null,
    decoration: InputDecoration(
      labelText: 'Last Name',
    ),
  );
}