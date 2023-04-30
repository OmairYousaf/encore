import 'package:cached_network_image/cached_network_image.dart';
import 'package:encore/screens/create_event/create_event_vm.dart';
import 'package:encore/widgets/date_picker/date_picker.dart';
import 'package:encore/widgets/dialogs/encore_dialogs.dart';
import 'package:encore/widgets/input_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:stacked/stacked.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/constants.dart';
import '../../widgets/appBar/encore_appbar.dart';
import '../../widgets/buttons/action_button.dart';
import 'package:google_fonts/google_fonts.dart';
import '../profile/profile_vu.dart';
import 'model/model.dart';

class CreateEventScreen extends ViewModelBuilderWidget<CreateEventViewModel> {
  CreateEventScreen(this.model, {super.key}) {
    print(model);
  }
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
          title: 'encore',
          actions: [
            // const ActionButton(icon: 'assets/icons/bell_icon.svg'),
            const SizedBox(width: 12),
            ActionButton(
              icon: 'assets/icons/profile.svg',
              profileImage: !viewModel.profileUrl.endsWith('no_image')
                  ? CachedNetworkImage(
                      placeholder: (context, uri) => SvgPicture.asset(
                        'assets/icons/account.svg',
                        // scale: 4.5,
                      ),
                      imageUrl: viewModel.profileUrl,
                      fit: BoxFit.cover,
                    )
                  : null,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileScreen(false)));
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
                            value: model == null
                                ? selectedEvent
                                : model!.eventOccur,
                            // value: viewModel.dropdownValue1,
                            // isDense: true,
                            onChanged: (String? newValue) {
                              // viewModel.dropdownValue1 = newValue!;
                              viewModel.notifyListeners();
                              if (model != null) {
                                model!.eventOccur = newValue;
                                viewModel.notifyListeners();
                              } else {
                                selectedEvent = newValue;
                                viewModel.dropdownValue1 = newValue!;
                                viewModel.notifyListeners();
                              }
                            },
                            // icon: const Icon(Icons.arrow_drop_down),
                            icon:
                                SvgPicture.asset('assets/icons/down_arrow.svg'),
                            iconSize: 24,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '',
                            ),
                            validator: (value) {
                              if (value == 'How event occured?') {
                                return 'Please select an option';
                              }
                              return null;
                            },
                            // underline: const SizedBox.shrink(),

                            style: const TextStyle(
                                color: Color(0xffAFAEAE), fontSize: 16),

                            isExpanded: true,
                            items: events
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
                const SizedBox(height: 8),
                const SizedBox(height: 8),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      style: const TextStyle(
                          color: Color(0xffAFAEAE), fontSize: 16),
                      maxLines: 6,
                      controller: viewModel.noteController,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                            color: Color(0xffAFAEAE), fontSize: 16),
                        hintText: 'Add notes',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (note) {
                        model == null
                            ? viewModel.note = note
                            : model!.note != note;
                        viewModel.notifyListeners();
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    // if (viewModel.formKey.currentState == null ||
                    //     viewModel.formKey.currentState!.validate())
                    //   SizedBox(height: 8.0)
                    // else
                    //   Text(
                    //     'Please enter some text',
                    //     style: TextStyle(color: Colors.red),
                    //   ),
                  ],
                ),

                // Column(
                //   children: [
                //     SizedBox(
                //       height: 6 * 18.0,
                //       child: EncoreTextField(
                //         initialValue: model == null ? '' : model!.note,
                //         hintText: 'Add notes',
                //         maxLine: 7,
                //         onSaved: (note) {
                //           model == null
                //               ? viewModel.note = note!
                //               : model!.note != note;
                //           print(viewModel.note);
                //         },
                //         validator: (value) {
                //           if (value!.isEmpty) {
                //             return 'Please enter some text';
                //           }
                //           return null;
                //         },

                //         // controller: viewModel.noteController,

                //         // style: EncoreStyles.textFieldHint
                //         //     .copyWith(color: const Color(0xffAFAEAE)),
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 24),
                viewModel.isBusy
                    ? Center(
                        child: EncoreCard(
                            child: Row(
                        children: [
                          Text('Loading contacts...'),
                          Spacer(),
                          CircularProgressIndicator(),
                        ],
                      )))
                    : _card(model == null ? viewModel.contactNo : model!.phone!,
                        'contacts', onTap: () async {
                        // viewModel.selectContact(context);
                        // viewModel.setBusy(true);
                        // EncoreDialogs.showProgress(context,
                        //     title: 'loading, please wait...');
                        await viewModel.pickContact();
                        // hideProgress(context);
                        // viewModel.setBusy(false);
                        // model!.phone = viewModel.contact!.phones!.first.value!;
                        if (viewModel.contact != null) {
                          viewModel.contactNo =
                              viewModel.contact!.phoneNumbers!.first;
                          model!.phone = viewModel.contact!.phoneNumbers!.first;
                          model!.name =
                              viewModel.getName(viewModel.contact!.fullName!);
                        } else {
                          viewModel.contactNo = 'Import Contact';
                          model!.phone = 'Import Contact';
                        }
                        if (model != null) {
                          // model!.phone = viewModel.contact!.phoneNumbers!.first;
                          // model!.name =
                          //     viewModel.getName(viewModel.contact!.fullName!);
                        }
                        viewModel.notifyListeners();
                      }),
                // if (viewModel.contact == null)
                //   SizedBox(height: 8.0)
                // else
                //   Text(
                //     'Please enter some text',
                //     style: TextStyle(color: Colors.red),
                //   ),
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
                          title: model == null
                              ? viewModel.dateFormated
                              : viewModel.followupDateTime,
                          onGetDate: (date) {
                            print(date);
                            viewModel.setDate(date!);
                          }),
                      const SizedBox(width: 12),
                      Flexible(
                        child: TextFormField(
                            style: const TextStyle(
                                color: Color(0xffAFAEAE), fontSize: 16),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^1[0-2]|[1-9]$')),
                            ],
                            onChanged: (text) {
                              if (text.length > 2) {
                                viewModel.hourController.value =
                                    TextEditingValue(
                                  text: viewModel.hourController.text
                                      .substring(0, 2),
                                  selection: TextSelection.collapsed(offset: 2),
                                );
                              }
                              // viewModel
                              //     .makeHours(viewModel.hourController.text);
                            },
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'Hours';
                            //   }
                            //   return null;
                            // },
                            textAlign: TextAlign.center,
                            controller: viewModel.hourController,
                            decoration: InputDecoration(
                                hintText: 'HH',
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
                        child: TextFormField(
                            style: const TextStyle(
                                color: Color(0xffAFAEAE), fontSize: 16),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^([1-5]?[0-9]|60)$')),
                            ],
                            onChanged: (text) {
                              if (text.length > 2) {
                                viewModel.minuteController.value =
                                    TextEditingValue(
                                  text: viewModel.minuteController.text
                                      .substring(0, 2),
                                  selection: TextSelection.collapsed(offset: 2),
                                );
                              }
                              // viewModel
                              //     .makeMinutes(viewModel.minuteController.text);
                            },
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'Minutes';
                            //   }
                            //   return null;
                            // },
                            textAlign: TextAlign.center,
                            controller: viewModel.minuteController,
                            decoration: InputDecoration(
                                hintText: 'MM',
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
                            // value: viewModel.dropdownValue2,
                            onChanged: (String? newValue) {
                              // viewModel.dropdownValue2 = newValue!;
                              if (model != null) {
                                model!.followupOccur = newValue!;
                                viewModel.notifyListeners();
                              } else {
                                selectedFollowUp = newValue!;
                                viewModel.dropdownValue2 = newValue;
                                viewModel.notifyListeners();
                              }
                            },
                            // icon: const Icon(Icons.arrow_drop_down),
                            icon:
                                SvgPicture.asset('assets/icons/down_arrow.svg'),
                            iconSize: 24,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '',
                            ),
                            validator: (value) {
                              if (value == 'How Follow-up occured?') {
                                return 'Please select an option';
                              }
                              return null;
                            },

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
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 3.4,
                      child: DropdownButtonFormField<String>(
                        value:
                            model == null ? selectedPriority : model!.priority,
                        // value: viewModel.dropdownValue3,
                        onChanged: (String? newValue) {
                          // viewModel.dropdownValue3 = newValue!;
                          if (model != null) {
                            model!.priority = newValue!;
                            viewModel.notifyListeners();
                          } else {
                            selectedPriority = newValue!;
                            viewModel.dropdownValue3 = newValue;
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
                        isExpanded: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '',
                        ),
                        validator: (value) {
                          if (value == 'Priority') {
                            return 'Select priority';
                          }
                          return null;
                        },
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
          if (viewModel.formKey.currentState!.validate()) {
            print('validate');

            viewModel.formKey.currentState!.save();
            if (viewModel.contactNo == 'Import Contact') {
              EncoreDialogs.showErrorAlert(
                context,
                title: 'Alert',
                message: 'Select Contact First',
                onCancel: () => Navigator.pop(context),
                // onConfirm: () => Navigator.pop(context),
              );
            } else if (model == null && viewModel.selectedDate == null) {
              EncoreDialogs.showErrorAlert(
                context,
                title: 'Alert',
                message: 'Select Date Time',
                onCancel: () => Navigator.pop(context),
                // onConfirm: () => Navigator.pop(context),
              );
            } else if (viewModel.hourController.text == '') {
              EncoreDialogs.showErrorAlert(
                context,
                title: 'Alert',
                message: 'Add Hours',
                onCancel: () => Navigator.pop(context),
                // onConfirm: () => Navigator.pop(context),
              );
            } else if (viewModel.minuteController.text == '') {
              EncoreDialogs.showErrorAlert(
                context,
                title: 'Alert',
                message: 'Add Minutes',
                onCancel: () => Navigator.pop(context),
                // onConfirm: () => Navigator.pop(context),
              );
            } else {
              viewModel.makeHours(viewModel.hourController.text);
              viewModel.makeMinutes(viewModel.minuteController.text);
              print(viewModel.hourController.text);
              print(viewModel.minuteController.text);
              if (model == null) {
                viewModel.name =
                    viewModel.getName(viewModel.contact!.fullName!);
                viewModel.getDateTime();
                print('Event Create');

                await viewModel.createEvent();
              } else {
                viewModel.getDateTime();
                await viewModel.updateEvent();
              }
            }
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
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(
              'assets/icons/home.svg',
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }

  @override
  CreateEventViewModel viewModelBuilder(BuildContext context) {
    // CreateEventViewModel vm = CreateEventViewModel(context);
    return CreateEventViewModel(context, model);
  }
}

Widget _card(
  String label,
  String icon, {
  VoidCallback? onTap,
}) {
  String message;
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

class _NumberRangeTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  _NumberRangeTextInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final input = int.tryParse(newValue.text) ?? 0;
    if (input < min) {
      return TextEditingValue(text: '$min');
    } else if (input > max) {
      return TextEditingValue(text: '$max');
    }
    return newValue;
  }
}
