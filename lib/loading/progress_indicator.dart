import 'package:encore/constants/constants.dart';
import 'package:flutter/material.dart';

class EncoreProgressIndicator extends StatelessWidget {
  const EncoreProgressIndicator(this.isBusy, {Key? key, this.color})
      : super(key: key);
  final bool isBusy;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isBusy,
      child: LinearProgressIndicator(
        color: color ?? EncoreStyles.primaryColor,
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}
