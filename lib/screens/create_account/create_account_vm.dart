import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:file_picker/file_picker.dart';

import '../../network/api_client.dart';
import '../../widgets/dialogs/encore_dialogs.dart';
import '../login/login_vu.dart';

class CreateAccountViewModel extends BaseViewModel {
  PlatformFile? filePath;
  String fileSize = '';
  final formKey = GlobalKey<FormState>();
  String fullName = '';
  String email = '';
  String phoneNo = '';
  String password = '';

  onFullNameSaved(String? value) {
    fullName = value!.trim();
  }

  onEmailSaved(String? value) {
    email = value!.trim();
  }

  onPhNoSaved(String? value) {
    phoneNo = value!.trim();
  }

  onPasswordSaved(String? value) {
    password = value!.trim();
  }

  String? fullNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full Name is required';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    return null;
  }

  String? phNoValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ph No is required';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  signUp(BuildContext context) async {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      var registerUser = {
        "name": fullName,
        "email": email,
        "password": password,
        "role": 3,
        "profile_image": 'testing url'
      };
      var resp =
          await ApiClient.post(request: registerUser, endPoint: '/user-create');
      print(resp);

      if (resp['status'] == 'Ok') {
        EncoreDialogs.showSuccessAlert(
          context,
          title: 'Success',
          message: 'Sign Up Successfully',
          onConfirm: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
        );
      } else {
        EncoreDialogs.showErrorAlert(context,
            title: 'Error', message: resp['error']);
      }
    }
  }

  onPickImageFile(BuildContext context) async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf', 'jpg', 'JPEG']);
    if (pickedFile != null) {
      filePath = pickedFile.files[0];
      if (filePath!.path!.endsWith('.jpg') ||
          filePath!.path!.endsWith('.jpeg') ||
          filePath!.path!.endsWith('.png')) {
        // File is an image
        // model.user!.image = filePath!.path!;
        print('Image File');

        EncoreDialogs.showSuccessAlert(
          context,
          okButtonLabel: 'Ok',
          title: 'Image File Path',
          message: filePath!.path!,
          onConfirm: () {
            // onDeleteFile();
            Navigator.pop(context);
          },
        );

        // fileSize = await getFileSize(filePath!.path!);

        notifyListeners();
      } else {
        EncoreDialogs.showErrorAlert(
          context,
          okButtonLabel: 'Ok',
          title: 'File Picked Error',
          message: 'Selected file must be an Image',
          onConfirm: () {
            // onDeleteFile();
            Navigator.pop(context);
          },
        );
      }
    } else {
      debugPrint('You didn\'t pick any file');
    }
  }
}
