import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/constants.dart';

class EncoreTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final bool autoFocus;
  final bool enabled;
  final List<TextInputFormatter>? inputFormat;
  final String hintText;
  TextStyle? hintStyle;
  final TextInputType keyboardType;
  final int? maxLength;
  final int? maxLine;
  final FocusNode? focusNode;
  final Function(String?)? onSaved;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final String? initialValue;
  final bool enableInteractiveSelection;
  final bool obscureText;
  final Widget? suffixIcon;
  final Color? cursorColor;
  final bool enableHeading;
  final String heading;
  final void Function(String?)? onChanged;
  EncoreTextField({
    Key? key,
    this.controller,
    this.enabled = true,
    required this.hintText,
    this.hintStyle,
    this.prefixIcon,
    this.inputFormat,
    this.autoFocus = false,
    this.keyboardType = TextInputType.name,
    this.maxLength,
    this.maxLine = 1,
    this.focusNode,
    this.enableInteractiveSelection = true,
    this.onSaved,
    this.onEditingComplete,
    this.textInputAction,
    this.validator,
    this.initialValue,
    this.suffixIcon,
    this.enableHeading = false,
    this.heading = 'Heading',
    this.obscureText = false,
    this.cursorColor,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(12),
          height: maxLine == 1 ? 56 : double.infinity,
          decoration: BoxDecoration(
            color: EncoreStyles.whiteColor,
            border: EncoreStyles.cardBorder,
            borderRadius: BorderRadius.circular(8),
            // boxShadow: EncoreStyles.cardShadow,
          ),
        ),
        TextFormField(
          
          enabled: enabled,
          autofocus: autoFocus,
          focusNode: focusNode,
          onSaved: onSaved,
          obscureText: obscureText,
          validator: validator,
          initialValue: initialValue,
          textInputAction: textInputAction,
          onChanged: onChanged,
          cursorColor: cursorColor,
          onEditingComplete: onEditingComplete,
          controller: controller,
          maxLength: maxLength,
          maxLines: maxLine,
          enableInteractiveSelection: enableInteractiveSelection,
          inputFormatters: inputFormat,
          // style: EncoreStyles.mdNormalStyle,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            // counterStyle:
            //     EncoreStyles.textFieldHint.copyWith(color: Colors.black),
            border: InputBorder.none,
            // errorStyle: TextStyle(color: EncoreStyles.primaryErrorColor),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            hintText: hintText,
            suffixIcon: suffixIcon,
            hintStyle: hintStyle ??
                EncoreStyles.textFieldHint
                    .copyWith(color: const Color(0xffAFAEAE)),
            counterText: '',
          ),
        ),
      ],
    );
  }
}
