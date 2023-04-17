import 'package:encore/screens/create_event/create_event_vm.dart';
import 'package:encore/widgets/date_picker/date_picker.dart';
import 'package:encore/widgets/dialogs/encore_dialogs.dart';
import 'package:encore/widgets/input_field/text_field.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/constants.dart';
import '../../widgets/appBar/encore_appbar.dart';
import '../../widgets/buttons/action_button.dart';
import 'package:google_fonts/google_fonts.dart';
import '../profile/profile_vu.dart';
import 'model/model.dart';

class CreateEventScreen extends ViewModelBuilderWidget<CreateEventViewModel> {
  CreateEventScreen(this.model, {super.key});
  Event? model;
  String? selectedEvent = 'How event occured?';
  String? selectedFollowUp = 'How Follow-up occured?';
  String? selectedPriority = 'Priority';
  List<String> events = [
    'How event occured?',
    'Call',
    'Email',
    'Letter',
    'Text',
    'Appointment'
  ];
  List<String> followUps = [
    'How Follow-up occured?',
    'Call',
    'Email',
    'Letter',
    'Text',
    'Appointment'
  ];
  List<String> priority = ['Priority', '1', '2', '3', '4', '5'];
  @override
  Widget builder(
      BuildContext context, CreateEventViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(95),
        child: EncoreAppBar(
          addBackButton: false,
          title: 'encor',
          actions: [
            // const ActionButton(icon: 'assets/icons/bell_icon.svg'),
            const SizedBox(width: 12),
            ActionButton(
              icon: 'assets/icons/profile.svg',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
              },
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
          child: Form(
            key: viewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Event',
                  style: EncoreStyles.containerTitleText.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 28),
                // EncoreTextField(
                //   hintText: 'Add Title',
                //   // style: EncoreStyles.textFieldHint
                //   //     .copyWith(color: const Color(0xffAFAEAE)),
                // ),

                Stack(children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(12),
                    height: 56,
                    decoration: BoxDecoration(
                      color: EncoreStyles.whiteColor,
                      border: EncoreStyles.cardBorder,
                      borderRadius: BorderRadius.circular(8),
                      // boxShadow: EncoreStyles.cardShadow,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: viewModel.dropdownValue1,

                            onChanged: (String? newValue) {
                              viewModel.dropdownValue1 = newValue!;
                              // if (model != null) {
                              //   model!.eventOccur = newValue!;
                              //   viewModel.notifyListeners();
                              // } else {
                              //   selectedEvent = newValue!;
                              //   viewModel.notifyListeners();
                              // }
                            },
                            // icon: const Icon(Icons.arrow_drop_down),
                            icon:
                                SvgPicture.asset('assets/icons/down_arrow.svg'),
                            iconSize: 24,
                            // underline: const SizedBox.shrink(),
                            style: const TextStyle(
                                color: Color(0xffAFAEAE), fontSize: 16),

                            isExpanded: true,
                            items: [
                              'How event occured?',
                              'Call',
                              'Email',
                              'Letter',
                              'Text',
                              'Appointment'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
                const SizedBox(height: 8),
                const SizedBox(height: 8),
                SizedBox(
                  height: 6 * 24.0,
                  child: EncoreTextField(
                    hintText: 'Add notes',
                    maxLine: 7,
                    // onSaved: (note) {
                    //   viewModel.note = note!;
                    //   print(viewModel.note);
                    // },
                    controller: viewModel.noteController,

                    // style: EncoreStyles.textFieldHint
                    //     .copyWith(color: const Color(0xffAFAEAE)),
                  ),
                ),
                const SizedBox(height: 24),
                _card(
                    viewModel.contactNo == ''
                        ? 'Import Contact'
                        : viewModel.contactNo,
                    'contacts', onTap: () async {
                  // viewModel.selectContact(context);
                  viewModel.contact = await viewModel.pickContact();

                  viewModel.contactNo = viewModel.contact!.phones!.first.value!;
                  viewModel.notifyListeners();
                }),
                const SizedBox(height: 24),
                Text(
                  'Set Your Follow Up Date and Time',
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff000000)),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 53,
                  child: Row(
                    children: [
                      EncoreDatePicker(
                          title: viewModel.dateFormated == ''
                              ? 'Select Date'
                              : viewModel.dateFormated,
                          onGetDate: (date) {
                            print(date);
                            viewModel.setDate(date!);
                          }),
                      const SizedBox(width: 12),
                      Flexible(
                        child: TextField(
                            onChanged: (text) {
                              if (text.length > 2) {
                                viewModel.hourController.value =
                                    TextEditingValue(
                                  text: viewModel.hourController.text
                                      .substring(0, 2),
                                  selection: TextSelection.collapsed(offset: 2),
                                );
                              }
                            },
                            textAlign: TextAlign.center,
                            controller: viewModel.hourController,
                            decoration: InputDecoration(
                                hintText: '09',
                                hintStyle: EncoreStyles.textFieldHint
                                    .copyWith(color: const Color(0xffAFAEAE)),
                                // contentPadding: const EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: EncoreStyles.cardBorderColor)))),
                      ),
                      Flexible(
                        child: TextField(
                            onChanged: (text) {
                              if (text.length > 2) {
                                viewModel.minuteController.value =
                                    TextEditingValue(
                                  text: viewModel.minuteController.text
                                      .substring(0, 2),
                                  selection: TextSelection.collapsed(offset: 2),
                                );
                              }
                            },
                            textAlign: TextAlign.center,
                            controller: viewModel.minuteController,
                            decoration: InputDecoration(
                                hintText: '09',
                                hintStyle: EncoreStyles.textFieldHint
                                    .copyWith(color: const Color(0xffAFAEAE)),
                                // contentPadding: const EdgeInsets.all(10),
                                border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10))))),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Stack(children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(12),
                    height: 56,
                    decoration: BoxDecoration(
                      color: EncoreStyles.whiteColor,
                      border: EncoreStyles.cardBorder,
                      borderRadius: BorderRadius.circular(8),
                      // boxShadow: EncoreStyles.cardShadow,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: model == null
                                ? selectedFollowUp
                                : model!.followupOccur,
                            onChanged: (String? newValue) {
                              if (model != null) {
                                model!.followupOccur = newValue!;
                                viewModel.notifyListeners();
                              } else {
                                selectedFollowUp = newValue!;
                                viewModel.notifyListeners();
                              }
                            },
                            // icon: const Icon(Icons.arrow_drop_down),
                            icon:
                                SvgPicture.asset('assets/icons/down_arrow.svg'),
                            iconSize: 24,
                            // underline: const SizedBox.shrink(),
                            style: const TextStyle(
                                color: Color(0xffAFAEAE), fontSize: 16),

                            isExpanded: true,
                            items: followUps
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),

                const SizedBox(height: 24),
                Stack(children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(12),
                    height: 56,
                    width: 150,
                    decoration: BoxDecoration(
                      color: EncoreStyles.whiteColor,
                      border: EncoreStyles.cardBorder,
                      borderRadius: BorderRadius.circular(8),
                      // boxShadow: EncoreStyles.cardShadow,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButtonFormField<String>(
                          value: model == null
                              ? selectedPriority
                              : model!.priority,
                          onChanged: (String? newValue) {
                            if (model != null) {
                              model!.priority = newValue!;
                              viewModel.notifyListeners();
                            } else {
                              selectedPriority = newValue!;
                              viewModel.notifyListeners();
                            }
                          },
                          // icon: const Icon(Icons.arrow_drop_down),
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 45),
                            child:
                                SvgPicture.asset('assets/icons/down_arrow.svg'),
                          ),
                          iconSize: 24,
                          // underline: const SizedBox.shrink(),
                          style: const TextStyle(
                              color: Color(0xffAFAEAE), fontSize: 16),

                          // isExpanded: true,
                          items: priority
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ]),

                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: EncoreStyles.primaryColor,
        //Floating action button on Scaffold
        onPressed: () async {
          if (viewModel.dropdownValue1 == 'How event occured?' ||
              viewModel.noteController.text == '' ||
              // viewModel.name == '' ||
              // viewModel.formattedDateTime == '' ||
              viewModel.dropdownValue2 == 'How Follow-up occured?' ||
              viewModel.dropdownValue3 == 'Priority') {
            EncoreDialogs.showErrorAlert(
              context,
              title: 'Alert',
              message: 'All Fields are necessary!',
              onCancel: () => Navigator.pop(context),
              onConfirm: () => Navigator.pop(context),
            );
          } else {
            viewModel.name = viewModel.getName(viewModel.contact!.displayName!);
            viewModel.getDateTime();
            viewModel.formKey.currentState!.validate();
            viewModel.formKey.currentState!.save();

            await viewModel.createEvent();
          }

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => const EventDetailScreen()));
        },
        child: SvgPicture.asset(
            'assets/icons/floating_tick_icon.svg'), //icon inside button
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        height: 70,
        //bottom navigation bar on scaffold
        color: EncoreStyles.primaryColor,
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin:
            7, //notche margin between floating button and bottom appbar
        child: GestureDetector(
          onTap: () async {
            // print(viewModel.dropdownValue1);
            // print(viewModel.dropdownValue2);

            // print(viewModel.noteController.text);
            // print(viewModel.dropdownValue3);
            // String fChar = viewModel.contact!.displayName!.split(' ')[0][0];
            // String sChar = viewModel.contact!.displayName!.split(' ')[1][0];
            // print(fChar + sChar);
            // print(viewModel.contact!.displayName);
            // print(viewModel.dateFormated);
            // print(viewModel.formattedDateTime);

            // if (viewModel.dropdownValue1 == 'How event occured?' ||
            //     viewModel.noteController.text == '' ||
            //     // viewModel.name == '' ||
            //     // viewModel.formattedDateTime == '' ||
            //     viewModel.dropdownValue2 == 'How Follow-up occured?' ||
            //     viewModel.dropdownValue3 == 'Priority') {
            //   EncoreDialogs.showErrorAlert(
            //     context,
            //     title: 'Alert',
            //     message: 'All Fields are necessary!',
            //     onCancel: () => Navigator.pop(context),
            //     onConfirm: () => Navigator.pop(context),
            //   );
            // } else {
            //   viewModel.name =
            //       viewModel.getName(viewModel.contact!.displayName!);
            //   viewModel.getDateTime();
            //   viewModel.formKey.currentState!.validate();
            //   viewModel.formKey.currentState!.save();

            //   await viewModel.createEvent();
            // }
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
  CreateEventViewModel viewModelBuilder(BuildContext context) {
    CreateEventViewModel vm = CreateEventViewModel(context, model);
    return CreateEventViewModel(context, model);
  }
}

Widget _card(String label, String icon, {VoidCallback? onTap}) {
  return EncoreCard(
    onTap: onTap,
    height: 56,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(9, 0, 6, 0),
      child: Row(
        children: [
          Text(label,
              style: EncoreStyles.textFieldHint
                  .copyWith(color: const Color(0xffAFAEAE))),
          const Spacer(),
          SvgPicture.asset('assets/icons/$icon.svg', fit: BoxFit.scaleDown),
        ],
      ),
    ),
  );
}
