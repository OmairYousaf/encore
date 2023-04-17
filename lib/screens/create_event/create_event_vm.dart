// import 'package:contact_picker/contact_picker.dart';
// import 'package:contacts_service/contacts_service.dart';
import 'package:encore/screens/create_event/model/model.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:intl/intl.dart';

import '../../network/api_client.dart';
import '../../widgets/dialogs/encore_dialogs.dart';

class CreateEventViewModel extends BaseViewModel {
  Event? model;
  BuildContext context;
  final formKey = GlobalKey<FormState>();
  CreateEventViewModel(this.context, this.model) {
    print(model);
    if (model != null) {
      removeTimeFromDate(model!.followupDateTime!);
    }
  }

  removeTimeFromDate(String dateTimeString) {
    // Remove the last eight characters from the string (the period, the two digits representing the hundredths of a second, and the four digits representing the milliseconds)
    model!.followupDateTime =
        dateTimeString.substring(0, dateTimeString.length - 8);
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
  Contact? contact;
  String dateFormated = 'Select Date';
  String contactNo = 'Import Contact';
  String note = '';
  String name = '';

  DateTime? selectedDate;

  // final FlutterContactPicker contactPicker = FlutterContactPicker();
  // Contact? _contact;

  Future<Contact> pickContact() async {
    // Get all contacts from the device
    bool checkPermission = await getContactsPermission();
    if (checkPermission) {
      Iterable<Contact> contacts = await ContactsService.getContacts();

      // Display the contact picker
      contact = await ContactsService.openDeviceContactPicker();
    }
    return contact!;
  }

  setDate(int timeStamp) {
    selectedDate = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    dateFormated = DateFormat('d MMM yyyy').format(selectedDate!);

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

  createEvent() async {
    var eventRequest = {
      "event_occur": dropdownValue1,
      "followup_occur": dropdownValue2,
      "note": note,
      "followup_date_time": formattedDateTime,
      "priority": dropdownValue3,
      "name": contact!.displayName,
      "phone": contactNo
    };

    print(eventRequest);
    Event event = Event.fromJson(eventRequest);
    print(event);

    var resp =
        await ApiClient.post(request: eventRequest, endPoint: '/event-create');
    print(resp);

    if (resp['status'] == 'Ok') {
      EncoreDialogs.showSuccessAlert(
        context,
        title: 'Success',
        message: 'Event Created Successfully',
        onConfirm: () {
          print('Event Created Successfully');
          Navigator.pop(context);

          eventRequest['name'] = name;
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
