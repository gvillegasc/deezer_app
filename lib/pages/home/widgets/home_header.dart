import 'package:flutter/material.dart';

// Widgets
import 'package:deezer_app/pages/home/widgets/my_avatar.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AspectRatio(
        aspectRatio: 16 / 11,
        child: Stack(
          children: [
            ClipPath(
              clipper: _MyCustomClipper(),
              child: Container(
                color: Color(0xff01579b),
              ),
            ),
            Positioned(
              child: MyAvatar(),
            )
          ],
        ),
      ),
    );
  }
}

class _MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height * 0.9);
    path.arcToPoint(Offset(size.width, size.height * 0.5),
        radius: Radius.circular(size.width), clockwise: false);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
