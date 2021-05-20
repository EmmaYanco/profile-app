// /* ************************************************************************
//  * FILE : dateFormatting.dart
//  * DESC : Handles formatting of date.
//  * ************************************************************************
//  */

import 'package:intl/intl.dart';

// Adds suffix to day
String addSuffix (messageDate) {
  String num = DateFormat('d').format(messageDate).toString();
  if (num == '1' || num == '21' || num == '31') {
    return "st";
  }
  if (num == '2' || num == '22') {
    return "nd";
  }
  if (num == '3' || num == '23') {
    return "rd";
  }
  else {
    return "th";
  }
}

// Formats date nicely
String formatDate(String messageDate) {
  print(messageDate);
  DateTime parsedDate = DateTime.parse(messageDate);
  String strDate = DateFormat.yMMMMd('en_US').format(parsedDate).toString();
  int spaceIndex = strDate.indexOf(" ", strDate.indexOf(" ") + 1) - 1;
  return strDate.substring(0, spaceIndex) + addSuffix(parsedDate) + strDate.substring(spaceIndex, strDate.length); 
}
