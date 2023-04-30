import 'package:encore/constants/constants.dart';
import 'package:flutter/material.dart';
import '../buttons/action_button.dart';
import 'package:google_fonts/google_fonts.dart';

//ignore: must_be_immutable
class EncoreAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool addBackButton;
  final Widget? leading;
  final List<Widget>? actions;
  final VoidCallback? onBackPress;
  final bool search;
  final Widget? searchWidget;
  const EncoreAppBar({
    super.key,
    required this.title,
    this.actions,
    this.onBackPress,
    this.leading,
    this.addBackButton = true,
    this.search = false,
    this.searchWidget,
  });

  @override
  State<EncoreAppBar> createState() => _EncoreAppBarState();

  @override
  Size get preferredSize => const Size(65, 65);
}

class _EncoreAppBarState extends State<EncoreAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: EncoreStyles.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.addBackButton
                ? ActionButton(
                    icon: 'assets/icons/back.svg',
                    onTap: widget.onBackPress ?? () => Navigator.pop(context))
                : const SizedBox(
                    width: 32,
                  ),
            Text(widget.title,
                style: GoogleFonts.oswald(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: EncoreStyles.whiteColor)
                // TextStyle(color: EncoreStyles.whiteColor, fontSize: 30),
                ),
            Row(children: widget.actions ?? [const SizedBox()])
          ],
        ),
      ),
    );
  }
}
