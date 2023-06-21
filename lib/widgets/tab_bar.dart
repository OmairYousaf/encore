import 'package:flutter/material.dart';

class EncoreTabBar extends StatelessWidget {
  final int length;
  final List<String> tabs;
  final List<Widget> children;
  int mSelectedIndex = 0;
  EncoreTabBar(
      {Key? key,
      required this.length,
      required this.tabs,
      required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState) => DefaultTabController(
              length: length,
              child: Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    labelStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    indicatorColor: const Color(0xff000000),
                    labelColor: const Color(0xff282828),
                    unselectedLabelColor: const Color(0xffC2C2C2),
                    tabs: tabs
                        .map((tab) => Align(
                            alignment: Alignment.center, child: Tab(text: tab)))
                        .toList(),
                    onTap: (index) {
                      setState(() {
                        mSelectedIndex = index;
                      });
                    },
                  ),
                  Expanded(
                    child: IndexedStack(
                      alignment: AlignmentDirectional.center,
                      index: mSelectedIndex,
                      children: children,
                    ),
                  )
                ],
              ),
            ));
  }
}
