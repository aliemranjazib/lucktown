import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final String title;
  final Function onPress;
  final double width;
  bool loading;

  PrimaryButton({
    Key? key,
    required this.title,
    required this.onPress,
    required this.width,
    this.loading = false,
  }) : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPress();
      },
      child: Container(
        height: 50,
        width: widget.width,
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
                  color: Colors.black,
                ),
              )
            : Center(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
      ),
    );
  }
}
