import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';

class SocialButton extends StatefulWidget {
  final String title;
  final String image;
  Color? color;

  final Function onPress;
  bool loading;

  SocialButton({
    Key? key,
    required this.title,
    required this.image,
    required this.onPress,
    this.color,
    this.loading = false,
  }) : super(key: key);

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      // width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            // tileMode: TileMode.clamp,
            colors: [
              Color(0xBD8E37).withOpacity(1),
              Color(0xFCD877).withOpacity(1),
              Color(0xFFFFD1).withOpacity(1),
              // Color.fromARGB(0, 248, 248, 133).withOpacity(1),
              Color(0xC1995C).withOpacity(1),
            ]),
      ),
      child: widget.loading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    widget.image,
                    height: 16,
                    width: 16,
                  ),
                  SizedBox(width: 5),
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: widget.color == null ? Colors.black : widget.color,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
