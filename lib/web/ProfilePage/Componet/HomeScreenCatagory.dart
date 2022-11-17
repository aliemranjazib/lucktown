import 'package:flutter/material.dart';
import 'package:news/constants.dart';

class HomeScreenCatagory extends StatelessWidget {
  const HomeScreenCatagory({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 80, right: kMaxWidth / 1.8),
      child: Container(
        width: kMaxWidth / 2,
        height: kDefaultPadding * 2.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '每日签到 / Daily Check-in',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Text(
              '快速行动 / Quick Access',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
