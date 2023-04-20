import 'package:encore/constants/constants.dart';
import 'package:encore/screens/login/login_vu.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../network/api_client.dart';
import '../../widgets/dialogs/encore_dialogs.dart';

class UpdatePasswordViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  String oldPass = '';
  String newPass = '';
  String confPass = '';
  bool oldObsecureText = true;
  bool newObsecureText = true;
  bool confNewObsecureText = true;

  onOldPassSaved(String? value) {
    oldPass = value!.trim();
  }

  onNewPassSaved(String? value) {
    newPass = value!.trim();
  }

  onConfNewPassSaved(String? value) {
    confPass = value!.trim();
  }

  String? oldPassValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Old Pass. required';
    }
    return null;
  }

  String? newPassValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'New Pass. required';
    }
    return null;
  }

  String? confNewPassValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Conf New Pass. required';
    } else if (newPass != confPass) {
      return 'Pass & Conf. Pass not matched';
    }
    return null;
  }

  onOldObsecure() {
    oldObsecureText = !oldObsecureText;
    notifyListeners();
  }

  onNewObsecure() {
    newObsecureText = !newObsecureText;
    notifyListeners();
  }

  onConfNewObsecure() {
    confNewObsecureText = !confNewObsecureText;
    notifyListeners();
  }

  updatePass(BuildContext context) async {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      var updatePass = {
        "user_id": EncoreStyles.userId,
        "old_password": oldPass,
        "new_password": newPass
      };
      var resp = await ApiClient.post(
          request: updatePass, endPoint: '/change-password');
      print(resp);

      if (resp['status'] == 'Ok') {
        EncoreDialogs.showSuccessAlert(
          context,
          title: 'Success',
          message: 'Password Updated Successfully',
          onConfirm: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
        );
      } else if (resp['status'] == "Error") {
        EncoreDialogs.showErrorAlert(context,
            title: 'Error', message: 'Bad Request');
      } else {
        EncoreDialogs.showErrorAlert(context,
            title: 'Error', message: resp['ErrorMessage']);
      }
    }
  }
}
