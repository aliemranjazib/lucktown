import 'package:flutter/material.dart';

Widget join_nowButton(VoidCallback click) {
  return InkWell(
    onTap: () {
      click();
    },
    child: Container(
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: 60, minHeight: 50),
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.clamp,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.4, 0.7, 0.9],
          colors: [
            Color(0xffFFFFD1),
            Color(0xffF0BC2F),
            // Color(0xff835919),
            Color(0xffF0BC2F),
            Color(0xffF0BC2F),

            // Color(0xffFFFFD1),

            // Color(0xffBD8E37),
          ],
        ),
      ),
      child: Text(
        'Join Now',
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
    ),
  );
}

class MyElevatedButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  // final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final Widget child;

  const MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    // this.width,
    this.height = 44.0,
    this.gradient = const LinearGradient(colors: [Colors.cyan, Colors.indigo]),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0);
    return Container(
      // width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: child,
      ),
    );
  }
}
