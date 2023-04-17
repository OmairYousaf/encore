import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class EncoreCard extends StatelessWidget {
  /// A generic Card used in whole app
  ///
  final Widget child;
  final VoidCallback? onTap;
  final Color? color;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final List<BoxShadow>? boxShadow;
  const EncoreCard({
    super.key,
    required this.child,
    this.onTap,
    this.color,
    this.height,
    this.borderRadius,
    this.padding,
    this.width,
    this.boxShadow,
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
          color: color ?? EncoreStyles.cardColor,
          border: EncoreStyles.cardBorder,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          boxShadow: boxShadow ?? EncoreStyles.cardShadow,
        ),
        child: child,
      ),
    );
  }
}
