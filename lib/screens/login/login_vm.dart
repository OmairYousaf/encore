import 'package:encore/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../network/api_client.dart';
import '../../widgets/dialogs/encore_dialogs.dart';
import '../tasks/tasks_vu.dart';

class LoginViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  bool obsecureText = true;

  onEmailSaved(String? value) {
    email = value!.trim();
  }

  onPasswordSaved(String? value) {
    password = value!.trim();
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  onObsecure() {
    obsecureText = !obsecureText;
    notifyListeners();
  }

  login(BuildContext context) async {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      var loginUser = {
        "email": email,
        "password": password,
      };
      var resp = await ApiClient.login(loginUser);
      print(resp);

      if (resp['status'] == 'Ok') {
        ApiClient.prefs!.setString('token', ApiClient.authToken);
        EncoreStyles.userId = resp['data']['data']['id'];
        EncoreDialogs.showSuccessAlert(
          context,
          title: 'Success',
          message: 'Login Successfully',
          onConfirm: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => TasksScreen()));
          },
        );
      } else {
        EncoreDialogs.showErrorAlert(context,
            title: 'Error', message: resp['ErrorMessage']);
      }
    }
  }
}
