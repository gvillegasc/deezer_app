import 'package:deezer_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const RoundedButton(
      {Key key,
      @required this.label,
      @required this.onPressed,
      this.backgroundColor})
      : assert(label != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Container(
        child: Text(
          this.label,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Sans',
              letterSpacing: 1,
              fontSize: 17),
        ),
        decoration: BoxDecoration(
            color: (this.backgroundColor ?? AppColors.primary)
                .withOpacity(this.onPressed != null ? 1 : 0.4),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)]),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      ),
      onPressed: this.onPressed,
    );
  }
}
