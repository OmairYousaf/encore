import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/constants.dart';
import '../../widgets/buttons/action_button.dart';

import 'update_password_vm.dart';

class UpdatePasswordScreen
    extends ViewModelBuilderWidget<UpdatePasswordViewModel> {
  const UpdatePasswordScreen({super.key});

  @override
  Widget builder(
      BuildContext context, UpdatePasswordViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: null,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 75),
          child: Form(
            key: viewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ActionButton(
                    icon: 'assets/icons/back.svg',
                    onTap: () => Navigator.pop(context)),
                const SizedBox(height: 24),
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset('assets/icons/encore_icon.svg')),
                const SizedBox(height: 41),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Update Your Password',
                    style: GoogleFonts.poppins(
                      color: EncoreStyles.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                textField('Old Password', viewModel.onOldPassSaved,
                    viewModel.oldPassValidator),
                const SizedBox(height: 8),
                textField('New Password', viewModel.onNewPassSaved,
                    viewModel.newPassValidator),
                const SizedBox(height: 8),
                textField('Confirm Password', viewModel.onConfNewPassSaved,
                    viewModel.confNewPassValidator),
                // const Spacer(),
                const SizedBox(height: 100),
                EncoreButton(
                  btnLabel: 'Confirm',
                  height: 60,
                  expanded: true,
                  onTap: () {
                    print('object');
                    viewModel.updatePass(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textField(String hintText, dynamic Function(String?)? onSaved,
      String? Function(String?)? validator) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(12),
          height: 60,
          decoration: BoxDecoration(
            color: EncoreStyles.whiteColor,
            border: EncoreStyles.cardBorderWithPrimaryColr,
            borderRadius: BorderRadius.circular(8),
            // boxShadow: EncoreStyles.cardShadow,
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: SvgPicture.asset(
              'assets/icons/lock.svg',
              fit: BoxFit.scaleDown,
            ),
            // counterStyle:
            //     EncoreStyles.textFieldHint.copyWith(color: Colors.black),
            border: InputBorder.none,
            // errorStyle: TextStyle(color: EncoreStyles.primaryErrorColor),
            // contentPadding:
            //     const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            hintText: hintText,
            suffixIcon: SvgPicture.asset(
              'assets/icons/eye_icon.svg',
              fit: BoxFit.scaleDown,
            ),
            hintStyle: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: EncoreStyles.primaryColor),
            counterText: '',
          ),
          onSaved: onSaved,
          validator: validator,
        ),
      ],
    );
  }

  @override
  UpdatePasswordViewModel viewModelBuilder(BuildContext context) {
    return UpdatePasswordViewModel();
  }
}
