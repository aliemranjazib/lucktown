import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/components/gradient_text.dart';
import 'package:flutter_application_lucky_town/web_menue/Drawer.dart';

class HomeScreenCatagory extends StatelessWidget {
  const HomeScreenCatagory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, right: kMaxWidth / 1.8),
      child: Container(
        width: kMaxWidth / 2,
        height: kDefaultPadding * 2.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            silverGradientRobto(
              '每日签到 / Daily Check-in',
              16,
              FontWeight.normal,
            ),
            silverGradientRobto(
              '快速行动 / Quick Access',
              16,
              FontWeight.normal,
            ),
          ],
        ),
      ),
    );
  }
}
