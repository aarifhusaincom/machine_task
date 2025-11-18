import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonSmall extends StatelessWidget {
  final bool isBorder;
  final bool isIcon;
  final String label;
  final String iconPath;
  final EdgeInsets padding;
  final double borderRadius;
  final VoidCallback? onTap;
  final Widget icon;

  /// color
  final Color borderColor;
  final Color labelColor;
  final Color backgroundColor;
  final Color iconColor;

  const ButtonSmall({
    super.key,
    this.isBorder = false,
    this.isIcon = true,
    this.label = 'Label',
    this.padding = const EdgeInsets.symmetric(horizontal: 2, vertical: 2),

    /// Colors
    this.borderColor = const Color(0xFFD2008F),
    this.labelColor = const Color(0xFFC0BEBD),
    this.backgroundColor = const Color(0xFFFFAF00),
    this.iconColor = const Color(0xFFC0BEBD),
    this.borderRadius = 4,
    this.iconPath = "assets/icons/add_cart.svg",
    this.onTap,
    this.icon = const Icon(Icons.account_circle_sharp),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 30,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: isBorder ? Border.all(color: borderColor, width: 1) : null,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            SvgPicture.asset("assets/icons/add_cart.svg"),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
