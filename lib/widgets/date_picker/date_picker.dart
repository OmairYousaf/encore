import 'package:encore/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EncoreDatePicker extends StatefulWidget {
  final DateTime? lastDate;
  final String title;
  final DateTime? firstDate;
  final Function(int? data) onGetDate;
  final String? dateFormate;
  final String? icon;
  const EncoreDatePicker({
    super.key,
    this.lastDate,
    required this.title,
    this.icon,
    this.dateFormate,
    required this.onGetDate,
    this.firstDate,
  });

  @override
  State<EncoreDatePicker> createState() => _EncoreDatePickerState();
}

class _EncoreDatePickerState extends State<EncoreDatePicker> {
  DateTime? sDate;
  String? pickedDate;
  Future<DateTime> datePicker(BuildContext context,
      {DateTime? lastDate,
      required bool isDark,
      required DateTime selectedDate,
      DateTime? firstDate}) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime.now(),
      builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme: isDark
                ? ColorScheme.dark(
                    primary: EncoreStyles.primaryColor,
                    onPrimary: EncoreStyles.whiteColor,
                    onSurface: Colors.white,
                  )
                : ColorScheme.light(
                    primary: EncoreStyles.primaryColor,
                    onPrimary: EncoreStyles.whiteColor,
                    onSurface: EncoreStyles.primaryColor,
                  ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: EncoreStyles.primaryColor,
              ),
            ),
          ),
          child: child!),
    );
    if (selected != null && selected != selectedDate) {
      selectedDate = selected;
    }
    return selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return EncoreCard(
      height: 53,
      width: 184,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Text(
              pickedDate ?? widget.title,
              style: EncoreStyles.textFieldHint
                  .copyWith(color: const Color(0xffAFAEAE)),
            ),
          ),
          SvgPicture.asset(widget.icon ?? '', fit: BoxFit.scaleDown),
        ],
      ),
      onTap: () async {
        sDate = await datePicker(
          context,
          lastDate: widget.lastDate,
          // isDark: isDark,
          selectedDate: sDate ?? DateTime.now(), isDark: false,
        );
        widget.onGetDate(sDate!.millisecondsSinceEpoch);
        debugPrint(pickedDate);
        setState(() {});
      },
    );
  }
}

class EncoreCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? color;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  const EncoreCard({
    super.key,
    required this.child,
    this.onTap,
    this.color,
    this.height,
    this.borderRadius,
    this.padding,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: padding ?? const EdgeInsets.all(12),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? EncoreStyles.whiteColor,
          border: EncoreStyles.cardBorder,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          boxShadow: EncoreStyles.cardShadow,
        ),
        child: child,
      ),
    );
  }
}
