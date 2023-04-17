import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/constants.dart';
import '../../widgets/appBar/encore_appbar.dart';
import '../../widgets/buttons/action_button.dart';

import '../profile/profile_vu.dart';
import 'event_detail_vm.dart';

class EventDetailScreen extends ViewModelBuilderWidget<EventDetailViewModel> {
  const EventDetailScreen({super.key});

  @override
  Widget builder(
      BuildContext context, EventDetailViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(95),
        child: EncoreAppBar(
          // addBackButton: false,
          title: 'encor',
          actions: [
            const ActionButton(icon: 'assets/icons/bell_icon.svg'),
            const SizedBox(width: 12),
            ActionButton(
              icon: 'assets/icons/profile.svg',
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen())),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Meeting With Client',
                style: EncoreStyles.containerTitleText.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 14),
              const Text(
                'Johns James',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xffAFAEAE)),
              ),
              const SizedBox(height: 36),
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: EncoreStyles.primaryColor,
                        shape: BoxShape.circle),
                    child: SvgPicture.asset(
                      'assets/icons/call.svg',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Event occured through call',
                    style: EncoreStyles.textStyle,
                  )
                ],
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'To do list',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff000000)),
                ),
              ),
              const SizedBox(height: 29),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('1. Discuss Project scope',
                      style: EncoreStyles.textStyle)),
              const SizedBox(height: 14),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('2. Discuss Project cost',
                      style: EncoreStyles.textStyle)),
              const SizedBox(height: 14),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('3. Discuss Project timeline',
                    style: EncoreStyles.textStyle),
              ),
              const SizedBox(height: 29),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Follow up',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff000000)),
                ),
              ),
              const SizedBox(height: 14),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 32,
                  width: 200,
                  decoration: BoxDecoration(
                      color: EncoreStyles.whiteColor,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: EncoreStyles.primaryColor)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Row(
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                              color: EncoreStyles.primaryColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: SvgPicture.asset(
                            'assets/icons/container_bell.svg',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '20-Nov-2022 | 02:50PM',
                          style: EncoreStyles.textFieldHint,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Row(
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                          color: EncoreStyles.primaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                      child: SvgPicture.asset(
                        'assets/icons/call.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Follow Up Occured Through Call',
                      style: EncoreStyles.textStyle.copyWith(fontSize: 14),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        //bottom navigation bar on scaffold
        color: EncoreStyles.primaryColor,
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin:
            7, //notche margin between floating button and bottom appbar
        child: SvgPicture.asset(
          'assets/icons/home.svg',
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }

  @override
  EventDetailViewModel viewModelBuilder(BuildContext context) {
    return EventDetailViewModel();
  }
}
