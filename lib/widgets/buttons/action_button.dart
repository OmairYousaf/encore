import 'package:encore/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EncoreButton extends StatelessWidget {
  final VoidCallback? onTap;
  final double? height;
  final bool disabled;
  final String btnLabel;
  final bool expanded;
  final Color? color;
  const EncoreButton(
      {Key? key,
      this.onTap,
      this.height,
      required this.btnLabel,
      this.color,
      this.disabled = false,
      this.expanded = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: !expanded ? MediaQuery.of(context).size.width * 0.5 : null,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        height: height ?? 48,
        decoration: BoxDecoration(
          color: color ??
              (disabled
                  ? EncoreStyles.primaryTextColorLight
                  : EncoreStyles.primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: Text(btnLabel, style: EncoreStyles.buttonText)),
      ),
    );
  }
}

class ButtonWithSuffix extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final bool disabled;
  final String btnLabel;
  final bool expanded;
  final Color? color;
  const ButtonWithSuffix(
      {Key? key,
      this.onTap,
      this.suffixIcon,
      required this.btnLabel,
      this.color,
      this.disabled = false,
      this.expanded = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: !expanded ? MediaQuery.of(context).size.width * 0.5 : null,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        height: 47,
        decoration: BoxDecoration(
          color: color ??
              (disabled
                  ? EncoreStyles.primaryTextColorLight
                  : EncoreStyles.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            children: [
              Text(btnLabel, style: EncoreStyles.buttonText),
              const Spacer(),
              suffixIcon ?? const SizedBox.shrink()
            ],
          ),
        )),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final Color? color;
  final Color? iconColor;
  final String icon;
  final VoidCallback? onTap;
  Widget? profileImage;
  ActionButton(
      {super.key,
      this.color,
      required this.icon,
      this.iconColor,
      this.onTap,
      this.profileImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xff1caa7f),
          borderRadius: BorderRadius.circular(25),
        ),
        child: ClipOval(
          child: SizedBox.fromSize(
              size: Size.fromRadius(20),
              child: profileImage ??
                  SvgPicture.asset(icon, fit: BoxFit.scaleDown)),
        ),
      ),
    );
  }
}
