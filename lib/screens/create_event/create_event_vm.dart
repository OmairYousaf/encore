import 'package:encore/screens/create_event/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:intl/intl.dart';

import '../../network/api_client.dart';
import '../../utils/preferences.dart';
import '../../widgets/dialogs/encore_dialogs.dart';

class CreateEventViewModel extends BaseViewModel {
  Event? model;
  String profileUrl = '';
  String hour = '';
  String followupDateTime = '';
  String minute = '';
  BuildContext context;
  var maxLength = 12;
  // ignore: prefer_typing_uninitialized_variables
  var maxLengthFormatter;
  final FlutterContactPicker _contactPicker = new FlutterContactPicker();
  Contact? contact;
// Create a TextInputFormatter to restrict the number of characters

  final formKey = GlobalKey<FormState>();
  CreateEventViewModel(this.context, this.model) {
    getTimeFormatter();
    getPrifileUrl();
    print(model);
    if (model != null) {
      contactNo = model!.phone!;
      contactName = model!.name!;
      removeTimeFromDate(model!.followupDateTime!);
    }
  }

  getTimeFormatter() {
    maxLengthFormatter = LengthLimitingTextInputFormatter(maxLength);
  }

  getPrifileUrl() async {
    var user = await Preferences.getSavedUser();
    profileUrl =
        '${ApiClient.wBaseUrl.substring(0, ApiClient.wBaseUrl.length - 3)}${user!.data!.profileImage}';
    print(profileUrl);
    notifyListeners();
  }

  removeTimeFromDate(String dateTimeString) {
    // Remove the last eight characters from the string (the period, the two digits representing the hundredths of a second, and the four digits representing the milliseconds)

    DateTime dateTime = DateTime.parse(dateTimeString);
    selectedDate = dateTime;
    hour = dateTime.hour.toString();
    minute = dateTime.minute.toString();
    followupDateTime = dateTimeString.substring(0, dateTimeString.length - 9);
    DateTime date = DateTime.parse(followupDateTime);
    followupDateTime = DateFormat("dd MMM yyyy").format(date);

    print(model!.followupDateTime);
    print(hour);
    print(minute);
    if (model != null) {
      hourController.text = hour;
      minuteController.text = minute;
      noteController.text = model!.note!;
    }
  }

  TextEditingController noteController = TextEditingController();
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();
  // getContacts() async {}
  String dropdownValue1 = 'How event occured?';
  String dropdownValue2 = 'How Follow-up occured?';
  String dropdownValue3 = 'Priority';
  String formattedDateTime = '';
  // ContactPicker contactPicker = ContactPicker();
  // Contact? contact;
  String dateFormated = 'Select Date';
  String contactNo = 'Import Contact';
  String contactName = '';
  String note = '';
  String name = '';

  DateTime? selectedDate;

  // final FlutterContactPicker contactPicker = FlutterContactPicker();
  // Contact? _contact;

  Future<Contact?> pickContact() async {
    // Get all contacts from the device
    bool checkPermission = await getContactsPermission();
    if (checkPermission) {
      setBusy(true);

      try {
        contact = await _contactPicker.selectContact();
        print(contact);
        // Perform a form operation here
      }
      //  on FormOperationException catch (e) {
      //   if (e.errorCode == FormOperationErrorCode.FORM_OPERATION_CANCELED) {
      //     // Handle form operation cancellation here
      //     print('Form operation cancelled by the user');
      //   } else {
      //     // Handle other form operation errors here
      //     print('Form operation failed with error code: ${e.errorCode}');
      //   }
      // }
      catch (e) {
        // Handle other exceptions here
        print('An error occurred: $e');
      }
      // Iterable<Contact> contacts = await ContactsService.getContacts();

      // Display the contact picker
    }
    if (contact != null) {
      setBusy(false);
      return contact!;
    } else {
      setBusy(false);
      return null;
      // return EncoreDialogs.showErrorAlert(
      //   context,
      //   title: 'Error',
      //   message: 'selected contact must be non-null',
      //   onConfirm: () {
      //     setBusy(false);
      //     Navigator.pop(context);
      //   },
      // );
    }
  }

  setDate(int timeStamp) {
    selectedDate = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    dateFormated = DateFormat('d MMM yyyy').format(selectedDate!);
    followupDateTime = DateFormat('d MMM yyyy').format(selectedDate!);
    notifyListeners();
    // return dateFormated;
  }

  getDateTime() {
    formattedDateTime =
        DateFormat("yyyy-MM-dd ${hourController.text}:${minuteController.text}")
            .format(selectedDate!);
    notifyListeners();
  }

  // late List<Contact> _contacts;
  // void selectContact(BuildContext context) async {
  //   _contacts = await ContactsService.getContacts(withThumbnails: false);
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         child: ListView.builder(
  //           itemBuilder: (BuildContext context, int index) {
  //             return ListTile(
  //               title: Text(_contacts[index].displayName!),
  //               onTap: () {
  //                 Navigator.pop(context, _contacts[index]);
  //               },
  //             );
  //           },
  //           itemCount: _contacts.length,
  //         ),
  //       );
  //     },
  //   ).then((selectedContact) {
  //     if (selectedContact != null) {
  //       // Do something with the selected contact
  //     }
  //   });
  // }

  Future<bool> getContactsPermission() async {
    if (await Permission.contacts.request().isGranted) {
      // Permission is already granted
      return true;
    }

    if (await Permission.contacts.isPermanentlyDenied) {
      // The user has previously denied the permission and has ticked the "Don't ask again" checkbox
      // You can either ask the user to grant the permission from the app settings, or display a message explaining why the permission is needed and how to grant it manually
      // For example:
      // showDialog(...)
      return false;
    }

    // Request the permission
    var status = await Permission.contacts.request();

    if (status.isDenied) {
      // The user denied the permission
      // You can display a message explaining why the permission is needed and how to grant it manually
      // For example:
      // showDialog(...)
    } else if (status.isPermanentlyDenied) {
      // The user denied the permission and has ticked the "Don't ask again" checkbox
      // You can either ask the user to grant the permission from the app settings, or display a message explaining why the permission is needed and how to grant it manually
      // For example:
      // showDialog(...)
    } else {
      return true;
      // The permission is granted
    }

    return false;
  }

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

  makeHours(String hrs) {
    hourController.text = hrs.padLeft(2, '0');
  }

  makeMinutes(String mnts) {
    minuteController.text = mnts.padLeft(2, '0');
  }

  createEvent() async {
    var eventRequest = {
      "event_occur": dropdownValue1,
      "followup_occur": dropdownValue2,
      "note": note,
      "followup_date_time": formattedDateTime,
      "priority": dropdownValue3,
      "name": name,
      "phone": contactNo
    };
    EncoreDialogs.showProgress(context, title: 'Creating Event');
    print(eventRequest);
    Event event = Event.fromJson(eventRequest);
    print(event);

    var resp =
        await ApiClient.post(request: eventRequest, endPoint: '/event-create');
    print(resp);

    if (resp['status'] == 'Ok') {
      hideProgress(context);
      EncoreDialogs.showSuccessAlert(
        context,
        title: 'Success',
        message: 'Event Created Successfully',
        onConfirm: () {
          print('Event Created Successfully');
          Navigator.pop(context);

          // eventRequest['name'] = name;
          Navigator.pop(context, event);
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
      );
    } else {
      EncoreDialogs.showErrorAlert(context,
          title: 'Error', message: resp['ErrorMessage']);
    }
  }

  updateEvent() async {
    var eventRequest = {
      "event_id": model!.id,
      "event_occur": model!.eventOccur,
      "followup_occur": model!.followupOccur,
      "note": noteController.text,
      "followup_date_time": formattedDateTime,
      "priority": model!.priority,
      "name": contactName,
      "phone": contactNo
    };
    EncoreDialogs.showProgress(context, title: 'Updating Event');
    print(eventRequest);
    Event event = Event.fromJson(eventRequest);
    print(event);

    var resp =
        await ApiClient.post(request: eventRequest, endPoint: '/event-edit');
    print(resp);

    if (resp['status'] == 'Ok') {
      hideProgress(context);
      EncoreDialogs.showSuccessAlert(
        context,
        title: 'Success',
        message: 'Event Updated Successfully',
        onConfirm: () {
          print('Event Updated Successfully');
          Navigator.pop(context);
          Navigator.pop(context, event);
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
      );
    } else {
      EncoreDialogs.showErrorAlert(context,
          title: 'Error', message: resp['ErrorMessage']);
    }
  }
}
