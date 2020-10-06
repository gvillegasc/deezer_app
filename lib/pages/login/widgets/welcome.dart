import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/responsive.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return AspectRatio(
        aspectRatio: 16 / 11,
        child: LayoutBuilder(
          builder: (_, constraints) {
            return Container(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: constraints.maxHeight * 0.7,
                    child: Column(
                      children: [
                        Container(
                          height: 3,
                          width: constraints.maxWidth,
                          color: Color(0xffeeeeee),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Welcome Back!",
                          style: TextStyle(
                              fontSize: responsive.ip(2.5),
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Raleway'),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SvgPicture.asset(
                      "assets/pages/login/clouds.svg",
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * 0.7,
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.28,
                    child: SvgPicture.asset(
                      "assets/pages/login/woman.svg",
                      width: constraints.maxWidth * 0.35,
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.32,
                    right: 10,
                    child: SvgPicture.asset(
                      "assets/pages/login/man.svg",
                      width: constraints.maxWidth * 0.25,
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
