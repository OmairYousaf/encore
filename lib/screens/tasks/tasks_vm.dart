import 'dart:ffi';

import 'package:encore/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../network/api_client.dart';
import '../../widgets/dialogs/encore_dialogs.dart';
import '../create_event/model/model.dart';

class TasksViewModel extends BaseViewModel {
  List<Event> eventsList = [];
  List<Event> followUpList = [];
  String eventDateTime = '';
  String followUpDateTime = '';
  List<Color> colors = [
    EncoreStyles.primaryColor,
    const Color(0xff795DD8),
    const Color(0xffD85FB7),
    const Color(0xffF8A17B)
  ];
  List<String> clockPics = [
    'assets/icons/clock_icon_1.svg',
    'assets/icons/clock_icon_2.svg',
    'assets/icons/clock_icon_3.svg',
    'assets/icons/clock_icon_4.svg'
  ];

  String getName(String cntct) {
    String name;

    if (cntct.contains(" ")) {
      List<String> firstChars = [];
      List<String> words = cntct.split(' ');
      for (int i = 0; i < words.length; i++) {
        String firstChar = words[i].substring(0, 1);
        firstChars.add(firstChar);
      }
      name = firstChars.join("");
    } else {
      name = cntct.substring(0, 1);
    }

    print(name);
    return name;
  }

  List<bool> boolList = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  Future<void> getEvents(BuildContext context) async {
    setBusy(true);
    final resp = await ApiClient.get(
        request: {}, endPoint: '/event-list', fromJson: EventList.fromJson);
    if (resp['status'] == 'Ok') {
      eventsList.clear();

      eventsList = resp['data'].data;

      await getFollowUp(context);
    } else {
      setBusy(false);
      EncoreDialogs.showErrorAlert(context,
          title: 'Error', message: resp['message']);
    }
  }

  Future<void> getFollowUp(BuildContext context) async {
    final resp = await ApiClient.post(
        request: {}, endPoint: '/followup-list', fromJson: EventList.fromJson);
    if (resp['status'] == 'Ok') {
      followUpList.clear();
      followUpList = resp['data'].data;
      setBusy(false);
    } else {
      setBusy(false);
      EncoreDialogs.showErrorAlert(context,
          title: 'Error', message: resp['message']);
    }
  }

  String removeLastTwoZerosAndPreviousColumn(String dateTimeString) {
    // Remove the last eight characters from the string (the period, the two digits representing the hundredths of a second, and the four digits representing the milliseconds)
    String formattedDateTimeString =
        dateTimeString.substring(0, dateTimeString.length - 3);

    return formattedDateTimeString;
  }

  String removeLastTwoZeros(String dateTimeString) {
    // Split the string by the period to separate the seconds and milliseconds
    List<String> dateTimeParts = dateTimeString.split('.');

    // Check if the last part of the string has more than two characters
    if (dateTimeParts.last.length > 2) {
      // Remove the last two characters from the last part of the string
      dateTimeParts[dateTimeParts.length - 1] =
          dateTimeParts.last.substring(0, dateTimeParts.last.length - 2);
    }

    // Join the string back together using the period
    String formattedDateTimeString = dateTimeParts.join('.');

    return formattedDateTimeString;
  }
}