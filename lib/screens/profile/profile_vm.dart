import 'package:encore/screens/login/login_vu.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../network/api_client.dart';
import '../../widgets/dialogs/encore_dialogs.dart';

class ProfileViewModel extends BaseViewModel {
  dalateAccount(BuildContext context) async {
    var resp = await ApiClient.get(request: {}, endPoint: '/delete-user');
    print(resp);

    if (resp['status'] == 'Ok') {
      EncoreDialogs.showSuccessAlert(
        context,
        title: 'Success',
        message: 'User Deleted Successfully',
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
