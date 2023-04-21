import 'package:encore/network/api_client.dart';
import 'package:encore/widgets/dialogs/encore_dialogs.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/constants.dart';
import '../../widgets/appBar/encore_appbar.dart';
import '../../widgets/buttons/action_button.dart';

import '../login/login_vu.dart';
import '../update_password/update_password_vu.dart';
import 'profile_vm.dart';

class ProfileScreen extends ViewModelBuilderWidget<ProfileViewModel> {
  const ProfileScreen({super.key});

  @override
  Widget builder(
      BuildContext context, ProfileViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(95),
        child: EncoreAppBar(
          addBackButton: false,
          title: 'encor',
          actions: [
            // ActionButton(icon: 'assets/icons/bell_icon.svg'),
            SizedBox(width: 12),
            ActionButton(icon: 'assets/icons/profile.svg')
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
        child: Column(
          children: [
            Text(
              'Profile',
              style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: EncoreStyles.primaryColor),
            ),
            const SizedBox(height: 12),
            Stack(
              children: [
                ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(35),
                    child: SvgPicture.asset(
                      'assets/icons/profile_icon.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Positioned(
                //   right: 0,
                //   top: 0,
                //   child: Container(
                //     height: 25,
                //     width: 25,
                //     decoration: BoxDecoration(
                //         color: EncoreStyles.whiteColor, shape: BoxShape.circle),
                //     child: SvgPicture.asset(
                //       'assets/icons/edit.svg',
                //       fit: BoxFit.scaleDown,
                //     ),
                //   ),
                // )
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Smith Wilimson',
              style: GoogleFonts.poppins(
                color: EncoreStyles.primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 75),
            ButtonWithSuffix(
              btnLabel: 'Update Password',
              suffixIcon: SvgPicture.asset('assets/icons/arrow_next.svg'),
              expanded: true,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UpdatePasswordScreen())),
            ),
            const SizedBox(height: 32),
            ButtonWithSuffix(
              color: const Color(0xff1ECB96),
              btnLabel: 'Delete account',
              suffixIcon: SvgPicture.asset('assets/icons/delete_account.svg'),
              expanded: true,
              onTap: () {
                EncoreDialogs.showSuccessAlert(
                  context,
                  title: 'Delete Account',
                  message: 'Are you confirm to delete account',
                  onConfirm: () {
                    viewModel.dalateAccount(context);
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const CreateAccountScreen()));
                  },
                  enableCancelButton: true,
                  onCancel: () {
                    Navigator.pop(context);
                  },
                );
              },
            ),
            const SizedBox(height: 32),
            ButtonWithSuffix(
                btnLabel: 'Logout',
                suffixIcon: SvgPicture.asset('assets/icons/logout_icon.svg'),
                expanded: true,
                onTap: () {
                  EncoreDialogs.showSuccessAlert(
                    context,
                    title: 'Log Out',
                    message: 'Are you confirm to logout',
                    onConfirm: () async {
                      print('object');
                      var resp = await ApiClient.post(
                          request: {}, endPoint: '/logout');

                      if (resp['status'] == 'Ok') {
                        await ApiClient.prefs!.clear();
                        ApiClient.authToken = '';
                        EncoreDialogs.showSuccessAlert(
                          context,
                          title: 'Success',
                          message: 'Logout Successfully',
                          onConfirm: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                        );
                      } else {
                        EncoreDialogs.showErrorAlert(context,
                            title: 'Error', message: resp['ErrorMessage']);
                      }
                    },
                    enableCancelButton: true,
                    onCancel: () {
                      Navigator.pop(context);
                    },
                  );
                }),
            // const SizedBox(height: 300),
            // const Spacer(),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        //bottom navigation bar on scaffold
        color: EncoreStyles.primaryColor,
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin:
            7, //notche margin between floating button and bottom appbar
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            'assets/icons/home.svg',
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }

  @override
  ProfileViewModel viewModelBuilder(BuildContext context) {
    return ProfileViewModel();
  }
}
