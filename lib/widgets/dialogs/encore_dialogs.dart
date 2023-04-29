import 'package:encore/constants/constants.dart';
import 'package:flutter/material.dart';

import '../buttons/action_button.dart';
import '../input_field/encore_card.dart';

class EncoreDialogs {
  static final EncoreDialogs _instance = EncoreDialogs();

  static showSuccessAlert(BuildContext context,
      {required String title,
      required String message,
      VoidCallback? onCancel,
      bool enableCancelButton = false,
      String? okButtonLabel,
      VoidCallback? onConfirm}) {
    return _instance._showCustomAlert(
      context,
      title: title,
      message: message,
      // icon: 'assets/icons/success_icon.svg',
      okButtonLabel: okButtonLabel ?? 'Ok',
      onCancel: onCancel,
      enableCancelButton: enableCancelButton,
      onConfirm: onConfirm,
    );
  }

  static showErrorAlert(
    BuildContext context, {
    required String title,
    required String message,
    String? okButtonLabel,
    VoidCallback? onCancel,
    bool enableCancelButton = false,
    VoidCallback? onConfirm,
  }) {
    return _instance._showCustomAlert(
      context,
      title: title,
      message: message,
      // icon: 'assets/icons/error_icon.svg',
      okButtonLabel: okButtonLabel ?? 'Ok',
      okButtonColor: EncoreStyles.primaryErrorColor,
      onCancel: onCancel,
      enableCancelButton: enableCancelButton,
      onConfirm: onConfirm,
    );
  }

  _showCustomAlert(
    context, {
    required String title,
    required String message,
    // required String icon,
    bool enableCancelButton = false,
    Color? okButtonColor,
    String okButtonLabel = 'Ok',
    String cancelButtonLabel = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        insetPadding: const EdgeInsets.all(16),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SvgPicture.asset(icon, fit: BoxFit.scaleDown),
            // const SizedBox(height: 16),
            Text(title,
                textAlign: TextAlign.center, style: EncoreStyles.lgMediumStyle)
          ],
        ),
        content: Builder(builder: (context) {
          return SizedBox(
              width: MediaQuery.of(context).size.shortestSide,
              child: Text(message,
                  textAlign: TextAlign.center,
                  style: EncoreStyles.smNormalStyle
                      .copyWith(color: const Color(0xff667085))));
        }),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: EncoreButton(
              btnLabel: okButtonLabel,
              expanded: true,
              color: okButtonColor,
              onTap: onConfirm ?? () => Navigator.pop(context),
            ),
          ),
          SizedBox(height: enableCancelButton ? 12 : 16),
          Visibility(
            visible: enableCancelButton,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: EncoreCard(
                  height: 48,
                  onTap: onCancel ?? () => Navigator.pop(context),
                  child: Text(
                    cancelButtonLabel,
                    style: EncoreStyles.mdMediumStyle,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  static showProgress(BuildContext context,
      {String title = 'Loading please wait'}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 20),
                Text(
                  title,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 13, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

hideProgress(context) {
  Navigator.pop(context);
}
