import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../constants/contants.dart';

class CustomToast {
  static ToastFuture customToast(BuildContext context, String data) {
    return showToastWidget(
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          margin: EdgeInsets.symmetric(horizontal: 50.0),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            color: Color(0xff3F3F3F),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Image.asset(info, height: 19, width: 19, fit: BoxFit.cover),
                SizedBox(
                  width: 10,
                ),
                Text(
                  data,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                // IconButton(
                //   onPressed: () {
                //     ToastManager().dismissAll(showAnim: true);
                //     //  Navigator.push(context,
                //     //      MaterialPageRoute(builder: (context) {
                //     //      return SecondPage();
                //     //  }));
                //   },
                //   icon: Icon(
                //     Icons.add_circle_outline_outlined,
                //     color: Colors.white,
                //   ),
                // ),
              ],
              mainAxisAlignment: MainAxisAlignment.start,
            ),
          ),
        ),
        context: context,
        isIgnoring: true,
        duration: Duration(seconds: 3),
        animation: StyledToastAnimation.fade,
        reverseAnimation: StyledToastAnimation.fade,
        position: StyledToastPosition(align: Alignment.topCenter));
  }
}
