import 'package:encore/constants/constants.dart';
import 'package:encore/screens/create_account/create_account_vu.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/buttons/action_button.dart';
import '../../widgets/input_field/text_field.dart';
import 'login_vm.dart';
import 'package:stacked/stacked.dart';

class LoginScreen extends ViewModelBuilderWidget<LoginViewModel> {
  const LoginScreen({super.key});

  @override
  Widget builder(
      BuildContext context, LoginViewModel viewModel, Widget? child) {
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
                      'Login',
                      style: EncoreStyles.textHeading,
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'Fil in the form with\nyour login Credentials',
                      style: EncoreStyles.subTextHeading,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    SvgPicture.asset('assets/icons/login.svg'),
                    const SizedBox(height: 34),
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
                    const SizedBox(height: 20),
                    EncoreTextField(
                        obscureText: viewModel.obsecureText,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Image.asset(
                            'assets/icons/Icon-password.png',
                            scale: 3.5,
                          ),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: viewModel.onObsecure,
                          child: SvgPicture.asset(
                              viewModel.obsecureText
                                  ? 'assets/icons/show_password_icon.svg'
                                  : 'assets/icons/hide_password_icon.svg',
                              fit: BoxFit.scaleDown),
                        ),
                        onSaved: viewModel.onPasswordSaved,
                        validator: viewModel.passwordValidator,
                        hintText: 'Password'),
                    const SizedBox(height: 30),
                    Text(
                      'By Signing In you are agreeing\nto all the user terms and services',
                      style: EncoreStyles.normalText,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    EncoreButton(
                      onTap: () {
                        viewModel.login(context);
                      },
                      btnLabel: 'Login',
                      expanded: true,
                    ),
                    const SizedBox(height: 30),
                    RichText(
                      text: TextSpan(
                          text: 'Don\'t have an account?',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Sign up',
                                style: TextStyle(
                                    color: EncoreStyles.primaryColor,
                                    fontSize: 20),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CreateAccountScreen()));
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
  LoginViewModel viewModelBuilder(BuildContext context) {
    return LoginViewModel();
  }
}
