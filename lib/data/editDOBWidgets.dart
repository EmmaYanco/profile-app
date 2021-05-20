/* ************************************************************************
 * FILE : editDOBWidgets.dart
 * DESC : Contains selectDate() and dobField(), used in editProfile.dart 
 * ************************************************************************
 */

import 'package:Breakthrough_Profile/utils/backend/userInteraction.dart';
import 'package:Breakthrough_Profile/utils/dateFormatting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Function used in dobField(), creates a CupertinoPicker to choose the new date of birth
selectDate(BuildContext context, TextEditingController controller, String chosenTime) async {
  DateTime tempPickedDate = chosenTime ?? DateTime.now();
  showModalBottomSheet<DateTime>(
    context: context,
    builder: (context) {
      return Container(
        height: 350,
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // If cancel button tapped, don't update DOB
                  CupertinoButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  // If done button tapped, update DOB in database AND in textform
                  CupertinoButton(
                    child: Text('Done'),
                    onPressed: () {
                      Navigator.of(context).pop(tempPickedDate);
                      chosenTime = formatDate(tempPickedDate.toString());
                      controller.text = chosenTime;
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: CupertinoDatePicker(
                  // This mode is used for dates, not times (since we need user's DOB)
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime dateTime) {
                    tempPickedDate = dateTime;
                  },
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

// Function used in editProfile.dart, allows user to update their date of birth
Widget dobField(BuildContext context, UserAccount account, TextEditingController controller, String chosenTime) {
  return GestureDetector(
    onTap: () => selectDate(context, controller, chosenTime),
    child: AbsorbPointer(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: 'Date of Birth'),
        onSaved: (val) => {
          if(val != null)
            account.dateOfBirth = val,
        },
      ),
    )
  );
}