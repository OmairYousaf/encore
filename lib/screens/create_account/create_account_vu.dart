import 'dart:io';

import 'package:encore/constants/constants.dart';
import 'package:encore/screens/login/login_vu.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/buttons/action_button.dart';
import '../../widgets/input_field/text_field.dart';
import 'create_account_vm.dart';
import 'package:stacked/stacked.dart';

class CreateAccountScreen
    extends ViewModelBuilderWidget<CreateAccountViewModel> {
  const CreateAccountScreen({super.key});

  @override
  Widget builder(
      BuildContext context, CreateAccountViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(42, 75, 42, 75),
              child: Form(
                key: viewModel.formKey,
                child: Column(
                  children: [
                    Text(
                      'Create Account',
                      style: EncoreStyles.textHeading,
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        viewModel.onPickImageFile(context);
                      },
                      child: Container(
                        width: 125,
                        height: 125,
                        decoration: BoxDecoration(
                            boxShadow: EncoreStyles.cardShadow,
                            color: EncoreStyles.whiteColor,
                            image: viewModel.filePath != null
                                ? DecorationImage(
                                    image: FileImage(
                                        File(viewModel.filePath!.path!)),
                                    fit: BoxFit.cover)
                                : null,
                            borderRadius: BorderRadius.circular(100)),
                        child: viewModel.filePath == null
                            ? SvgPicture.asset(
                                'assets/icons/take_image.svg',
                                fit: BoxFit.scaleDown,
                              )
                            : SizedBox.shrink(),
                      ),
                    ),
                    const SizedBox(height: 32),
                    EncoreTextField(
                        prefixIcon: Image.asset(
                          'assets/icons/full-name.png',
                          scale: 3.5,
                        ),
                        onSaved: viewModel.onFullNameSaved,
                        validator: viewModel.fullNameValidator,
                        hintText: 'Full Name'),
                    const SizedBox(height: 12),
                    EncoreTextField(
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.black87,
                        ),
                        // prefixIcon: Image.asset(
                        //   'assets/icons/Icon-mail.png',
                        //   scale: 3.5,
                        // ),
                        onSaved: viewModel.onEmailSaved,
                        validator: viewModel.emailValidator,
                        hintText: 'Email'),
                    const SizedBox(height: 12),
                    EncoreTextField(
                        prefixIcon: Image.asset(
                          'assets/icons/phone-number.png',
                          scale: 3.5,
                        ),
                        onSaved: viewModel.onPhNoSaved,
                        validator: viewModel.phNoValidator,
                        hintText: 'Phone Number'),
                    const SizedBox(height: 12),
                    EncoreTextField(
                        obscureText: viewModel.obsecureText,
                        suffixIcon: GestureDetector(
                          onTap: viewModel.onObsecure,
                          child: SvgPicture.asset(
                              viewModel.obsecureText
                                  ? 'assets/icons/show_password_icon.svg'
                                  : 'assets/icons/hide_password_icon.svg',
                              fit: BoxFit.scaleDown),
                        ),
                        prefixIcon: Image.asset(
                          'assets/icons/Icon-password.png',
                          scale: 3.5,
                        ),
                        onSaved: viewModel.onPasswordSaved,
                        validator: viewModel.passwordValidator,
                        hintText: 'Password'),
                    const SizedBox(height: 34),
                    Text(
                      'By Signing In you are agreeing\nto all the user terms and services',
                      style: EncoreStyles.normalText,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    EncoreButton(
                      btnLabel: 'Sign Up',
                      expanded: true,
                      onTap: () {
                        viewModel.signUp(context);
                      },
                    ),
                    const SizedBox(height: 30),
                    RichText(
                      text: TextSpan(
                          text: 'Already have an account?',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Log In',
                                style: TextStyle(
                                    color: EncoreStyles.primaryColor,
                                    fontSize: 20),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()));
                                  })
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  CreateAccountViewModel viewModelBuilder(BuildContext context) {
    return CreateAccountViewModel();
  }
}
