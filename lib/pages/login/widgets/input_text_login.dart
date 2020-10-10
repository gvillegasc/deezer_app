import 'package:deezer_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputTextLogin extends StatefulWidget {
  final String iconPath;
  final String placeholder;
  final TextInputType keyboardType;
  final String initValue;
  final bool Function(String text) validator;
  final bool obscureText;

  const InputTextLogin(
      {Key key,
      @required this.iconPath,
      @required this.placeholder,
      this.keyboardType = TextInputType.text,
      this.validator,
      this.initValue = '',
      this.obscureText = false})
      : assert(iconPath != null && placeholder != null),
        super(key: key);

  @override
  InputTextLoginState createState() => InputTextLoginState();
}

class InputTextLoginState extends State<InputTextLogin> {
  TextEditingController _controller;
  bool _validationOK = false;

  bool get isOk => _validationOK;
  String get value => _controller.text;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initValue);
    checkValidation();
  }

  void checkValidation() {
    if (widget.validator != null) {
      final isOk = widget.validator(_controller.text);
      if (_validationOK != isOk) {
        setState(() {
          _validationOK = isOk;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: _controller,
      onChanged: (text) => checkValidation(),
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
      prefix: Container(
        width: 40,
        height: 30,
        padding: EdgeInsets.all(2),
        child: SvgPicture.asset(
          this.widget.iconPath,
          color: Color(0xffccccccc),
        ),
      ),
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      suffix: widget.validator != null
          ? Icon(
              Icons.check_circle,
              color: _validationOK ? AppColors.primary : Colors.grey,
            )
          : null,
      placeholder: this.widget.placeholder,
      placeholderStyle: TextStyle(fontFamily: 'Sans', color: Color(0xffcccccc)),
      style: TextStyle(fontFamily: 'Sans'),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: Color(0xffdddddd)))),
    );
  }
}
