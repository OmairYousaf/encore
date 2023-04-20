import 'dart:io';

import 'package:encore/constants/constants.dart';
import 'package:encore/widgets/appBar/encore_appbar.dart';
import 'package:encore/widgets/dialogs/encore_dialogs.dart';
import 'package:flutter/material.dart';

import '../../loading/progress_indicator.dart';
import '../../widgets/buttons/action_button.dart';
import '../../widgets/tab_bar.dart';
import '../create_event/create_event_vu.dart';
import '../profile/profile_vu.dart';
import 'tasks_vm.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TasksScreen extends ViewModelBuilderWidget<TasksViewModel> {
  TasksScreen({super.key});
  final List<Map<String, dynamic>> data = [
    {
      "ticketNo": "12345",
      "date": "2023-04-20",
      "time": "10:30:00",
      "agent": "John",
      "action": "Resolved",
      "priority": "High"
    },
    {
      "ticketNo": "67890",
      "date": "2023-04-21",
      "time": "11:45:00",
      "agent": "Jane",
      "action": "In Progress",
      "priority": "Medium"
    },
    {
      "ticketNo": "24680",
      "date": "2023-04-22",
      "time": "09:15:00",
      "agent": "Bob",
      "action": "New",
      "priority": "Low"
    },
  ];

  @override
  Widget builder(
      BuildContext context, TasksViewModel viewModel, Widget? child) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('My List'),
    //   ),
    //   body: Column(
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Row(
    //           children: [
    //             for (var key in data.first.keys)
    //               Expanded(
    //                 flex: 1,
    //                 child: Text(
    //                   '$key:',
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.grey[600],
    //                   ),
    //                 ),
    //               ),
    //           ],
    //         ),
    //       ),
    //       Divider(),
    //       Expanded(
    //         child: ListView.builder(
    //           itemCount: data.length,
    //           itemBuilder: (context, index) {
    //             return Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Row(
    //                 children: [
    //                   for (var entry in data[index].entries)
    //                     Expanded(
    //                       flex: 1,
    //                       child: Text(
    //                         '${entry.value}',
    //                         style: TextStyle(
    //                           color: Colors.grey[800],
    //                         ),
    //                       ),
    //                     ),
    //                 ],
    //               ),
    //             );
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    return WillPopScope(
      onWillPop: () async {
        EncoreDialogs.showErrorAlert(
          context,
          title: 'Warning!',
          message: 'Are u confirm to exit',
          enableCancelButton: true,
          onCancel: () => Navigator.pop(context),
          onConfirm: () => exit(0),
        );
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(95),
          child: EncoreAppBar(
            addBackButton: false,
            title: 'encor',
            actions: [
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
        body: viewModel.isBusy
            ? const EncoreProgressIndicator(true)
            : EncoreTabBar(
                length: 2,
                tabs: const ['Events List View', 'Follow-Up List View'],
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 40, 8, 0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          upperContainer1(),
                          const SizedBox(height: 12),
                          Expanded(
                            child: ListView.builder(
                              itemCount: viewModel.eventsList.length,
                              itemBuilder: (context, index) =>
                                  lowerContainer1(viewModel, index, context),
                            ),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 40, 8, 0),
                    child: Column(children: [
                      upperContainer2(),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.builder(
                          itemCount: viewModel.followUpList.length,
                          itemBuilder: (context, index) =>
                              lowerContainer2(viewModel, index, context),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: EncoreStyles.primaryColor,
          //Floating action button on Scaffold
          onPressed: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateEventScreen(null)))
                .then((value) async {
              if (value != null) {
                await viewModel.getEvents(context);
                await viewModel.getFollowUp(context);
                // viewModel.eventsList.add(value);
                // viewModel.followUpList.addAll([value]);
                // viewModel.notifyListeners();
              }
            });
            //code to execute on button press
          },
          child: SvgPicture.asset(
              'assets/icons/floating_add_icon.svg'), //icon inside button
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
              print('object');
              await viewModel.getEvents(context);
            },
            child: SvgPicture.asset(
              'assets/icons/home.svg',
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }

  Widget container1(Color color, String clockPick) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          child: Container(
            height: 175,
            width: 378,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(width: 30.0, color: color),
                top: BorderSide(width: 3.0, color: color),
                right: BorderSide(width: 3.0, color: color),
                bottom: BorderSide(width: 3.0, color: color),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 12, 0, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(clockPick),
                      const SizedBox(width: 4),
                      Text(
                        '20-Nov-2022 | 02:50PM',
                        style: EncoreStyles.textFieldHint,
                      )
                    ],
                  ),
                  const SizedBox(height: 22),
                  Text('Meeting With CII',
                      style: EncoreStyles.containerTitleText),
                  const SizedBox(height: 4),
                  Text(
                    'Discuss project scope',
                    style: EncoreStyles.containerTitleText
                        .copyWith(color: const Color(0xffD0CDCD)),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    height: 32,
                    width: 200,
                    decoration: BoxDecoration(
                        color: EncoreStyles.whiteColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: color)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Row(
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                                color: color,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
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
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 15)
      ],
    );
  }

  Widget upperContainer1() {
    return Container(
      height: 48,
      decoration: const BoxDecoration(color: Color(0xffF2F2F2)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            // SizedBox(width: 24),
            Expanded(
              flex: 1,
              child: Text('Ticket No.',
                  style: TextStyle(
                      color: Color(0xff1ECB96),
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ),
            // Spacer(flex: 1),
            // SizedBox(width: 18),
            Expanded(
              flex: 1,
              child: Text('DateTime',
                  style: TextStyle(
                      color: Color(0xff1ECB96),
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ),
            // Spacer(flex: 1),
            // SizedBox(width: 18),
            // Expanded(
            //   child: Text('Time',
            //       style: TextStyle(
            //           color: Color(0xff1ECB96),
            //           fontSize: 14,
            //           fontWeight: FontWeight.bold)),
            // ),
            // Spacer(flex: 1),
            // SizedBox(width: 18),
            Expanded(
              flex: 1,
              child: Text('Agent',
                  style: TextStyle(
                      color: Color(0xff1ECB96),
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ),
            // Spacer(flex: 1),
            // SizedBox(width: 18),
            Expanded(
              flex: 1,
              child: Text('Action',
                  style: TextStyle(
                      color: Color(0xff1ECB96),
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  Widget upperContainer2() {
    return Container(
      height: 48,
      decoration: const BoxDecoration(color: Color(0xffF2F2F2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Expanded(
              flex: 2,
              child: Text('Ticket No.',
                  style: TextStyle(
                      color: Color(0xff1ECB96),
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ),
            // SizedBox(width: 18),
            Expanded(
              flex: 2,
              child: Text('DateTime',
                  style: TextStyle(
                      color: Color(0xff1ECB96),
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ),
            // SizedBox(width: 22),
            // Text('Time',
            //     style: TextStyle(
            //         color: Color(0xff1ECB96),
            //         fontSize: 14,
            //         fontWeight: FontWeight.bold)),
            // SizedBox(width: 18),
            Expanded(
              flex: 1,
              child: Text('Agent',
                  style: TextStyle(
                      color: Color(0xff1ECB96),
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ),
            // SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: Text('Action',
                  style: TextStyle(
                      color: Color(0xff1ECB96),
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ),
            // SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: Text('Priority',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color(0xff1ECB96),
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  Widget lowerContainer1(TasksViewModel vm, int index, BuildContext context) {
    vm.eventsList[index].name = vm.getName(vm.eventsList[index].name!);
    vm.eventDateTime = vm.removeLastTwoZerosAndPreviousColumn(
        vm.eventsList[index].followupDateTime!);
    return GestureDetector(
      onTap: () {
        print('event');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateEventScreen(vm.eventsList[index])));
      },
      child: Container(
        // height: 48,
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  Expanded(
                    child: const Text('725615'),
                    flex: 1,
                  ),
                  // Spacer(
                  //   flex: 1,
                  // ),
                  // const Text('[10-02-23 | 15:23]'),
                  Expanded(
                    flex: 1,
                    child: Text(
                      vm.eventDateTime,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  // Spacer(
                  //   flex: 1,
                  // ),
                  Expanded(flex: 1, child: Text(vm.eventsList[index].name!)),
                  // Spacer(
                  //   flex: 1,
                  // ),
                  Expanded(
                      flex: 1,
                      child: Text(
                        vm.eventsList[index].eventOccur!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                  // SizedBox(width: 12),

                  SvgPicture.asset('assets/icons/edit.svg')
                ],
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                vm.eventsList[index].isExpanded =
                    !vm.eventsList[index].isExpanded!;
                vm.notifyListeners();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Row(
                  children: [
                    const Text(
                      'NOTES',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset(!vm.eventsList[index].isExpanded!
                        ? 'assets/icons/up.svg'
                        : 'assets/icons/down.svg')
                  ],
                ),
              ),
            ),
            vm.eventsList[index].isExpanded!
                ? Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(vm.eventsList[index].note!),
                  )
                : const SizedBox.shrink(),
            const Divider(thickness: 2)
          ],
        ),
      ),
    );
  }

  Widget lowerContainer2(TasksViewModel vm, int index, BuildContext context) {
    vm.followUpList[index].name = vm.getName(vm.followUpList[index].name!);
    vm.followUpDateTime = vm.removeLastTwoZerosAndPreviousColumn(
        vm.followUpList[index].followupDateTime!);
    return GestureDetector(
      onTap: () {
        print('follow up');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CreateEventScreen(vm.followUpList[index])));
      },
      child: Container(
          // height: 48,
          decoration: const BoxDecoration(),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 2, child: const Text('725615')),
                  // const SizedBox(width: 22),
                  Expanded(flex: 4, child: Text(vm.followUpDateTime)),
                  // const SizedBox(width: 12),
                  Expanded(flex: 1, child: Text(vm.followUpList[index].name!)),
                  // const SizedBox(width: 32),
                  Expanded(
                    flex: 1,
                    child: Text(
                      vm.followUpList[index].followupOccur!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: 22),
                  Text(
                    vm.followUpList[index].priority!,
                  ),
                  // const SizedBox(width: 18),
                  // Spacer(),
                  SvgPicture.asset('assets/icons/edit.svg')
                ],
              ),
            ),
            const SizedBox(height: 8),
            StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            vm.followUpList[index].isExpanded =
                                !vm.followUpList[index].isExpanded!;
                          },
                        );

                        // vm.notifyListeners();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Row(
                          children: [
                            const Text(
                              'NOTES',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8),
                            SvgPicture.asset(!vm.followUpList[index].isExpanded!
                                ? 'assets/icons/up.svg'
                                : 'assets/icons/down.svg')
                          ],
                        ),
                      ),
                    ),
                    vm.followUpList[index].isExpanded!
                        ? Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Text(
                              vm.followUpList[index].note!,
                              maxLines: 7,
                            ),
                          )
                        : const SizedBox.shrink(),
                    const Divider(thickness: 2)
                  ],
                );
              },
            ),
          ])),
    );
  }

  // Widget container(Color color) {
  //   return Column(
  //     children: [
  //       Container(
  //         decoration: const BoxDecoration(
  //             borderRadius: BorderRadius.only(topRight: Radius.circular(16))),
  //         child: Container(
  //           height: 175,
  //           width: 378,
  //           decoration: BoxDecoration(
  //             color: EncoreStyles.whiteColor,
  //             // borderRadius: BorderRadius.circular(16),
  //             border: Border(
  //                 left: BorderSide(color: color, width: 30),
  //                 top: BorderSide(color: color, width: 1),
  //                 right: BorderSide(color: color, width: 1),
  //                 bottom: BorderSide(color: color, width: 1)),
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.fromLTRB(15, 12, 0, 20),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   children: [
  //                     // SvgPicture.asset('assets/icons/clock_icon.svg'),
  //                     const SizedBox(width: 4),
  //                     Text(
  //                       '20-Nov-2022 | 02:50PM',
  //                       style: EncoreStyles.textFieldHint,
  //                     )
  //                   ],
  //                 ),
  //                 const SizedBox(height: 22),
  //                 Text('Meeting With CII',
  //                     style: EncoreStyles.containerTitleText),
  //                 const SizedBox(height: 4),
  //                 Text(
  //                   'Discuss project scope',
  //                   style: EncoreStyles.containerTitleText
  //                       .copyWith(color: const Color(0xffD0CDCD)),
  //                 ),
  //                 const SizedBox(height: 18),
  //                 Container(
  //                   height: 32,
  //                   width: 200,
  //                   decoration: BoxDecoration(
  //                       color: EncoreStyles.whiteColor,
  //                       borderRadius:
  //                           const BorderRadius.all(Radius.circular(8)),
  //                       border: Border.all(color: color)),
  //                   child: Padding(
  //                     padding: const EdgeInsets.only(left: 6),
  //                     child: Row(
  //                       children: [
  //                         Container(
  //                           width: 18,
  //                           height: 18,
  //                           decoration: BoxDecoration(
  //                               color: color,
  //                               borderRadius: const BorderRadius.all(
  //                                   Radius.circular(15))),
  //                           child: SvgPicture.asset(
  //                             'assets/icons/container_bell.svg',
  //                             fit: BoxFit.scaleDown,
  //                           ),
  //                         ),
  //                         const SizedBox(width: 4),
  //                         Text(
  //                           '20-Nov-2022 | 02:50PM',
  //                           style: EncoreStyles.textFieldHint,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //       const SizedBox(height: 24)
  //     ],
  //   );
  // }

  @override
  TasksViewModel viewModelBuilder(BuildContext context) {
    TasksViewModel vm = TasksViewModel();
    vm.getEvents(context);
    return vm;
  }
}
