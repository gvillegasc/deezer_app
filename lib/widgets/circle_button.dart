import 'package:deezer_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleButton extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final String iconPath;
  const CircleButton(
      {Key key, this.size = 55, this.backgroundColor, @required this.iconPath})
      : assert(iconPath != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      padding: EdgeInsets.all(15),
      child: SvgPicture.asset(
        this.iconPath,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
          color: this.backgroundColor ?? AppColors.primary,
          shape: BoxShape.circle),
    );
  }
}
