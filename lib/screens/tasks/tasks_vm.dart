import 'dart:ffi';

import 'package:encore/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../network/api_client.dart';
import '../../utils/preferences.dart';
import '../../widgets/dialogs/encore_dialogs.dart';
import '../create_event/model/model.dart';

class TasksViewModel extends BaseViewModel {
  TasksViewModel() {
    getPrifileUrl();
    FadeInImage.assetNetwork(
      placeholder: 'assets/images/placeholder.png',
      image: 'https://example.com/images/image1.jpg',
      fit: BoxFit.cover,
    );
    for (int i = 0; i < eventsList.length; i++) {
      print(eventsList[i].toJson());
    }
  }
  getPrifileUrl() async {
    var user = await Preferences.getSavedUser();
    profileUrl =
        '${ApiClient.wBaseUrl.substring(0, ApiClient.wBaseUrl.length - 3)}${user!.data!.profileImage}';
    print(profileUrl);
    notifyListeners();
  }

  String profileUrl = '';

  List<Event> eventsList = [];
  List<Event> followUpList = [];
  String eventDateTime = '';
  String eventDate = '';
  String eventTime = '';
  String followUpDateTime = '';
  String followUpDate = '';
  String followUpTime = '';

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

  String getDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('dd-MM-yy').format(dateTime);
  }

  String getTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('HH:mm').format(dateTime);
  }

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

  Future<void> deleteEvent(BuildContext context, String id) async {
    setBusy(true);

    final resp = await ApiClient.get(
      request: {},
      endPoint: '/delete-event/$id',
    );
    if (resp['status'] == 'Ok') {
      setBusy(false);
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
