import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/components/gradient_text.dart';
import 'package:flutter_application_lucky_town/web_menue/Drawer.dart';


class BigBOxComponets extends StatelessWidget {
  const BigBOxComponets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 350,
      decoration: BoxDecoration(
        color: Color(0xff252A2D),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding),
            child: silverGradient('Check-in: Day 5', 20),
          ),
         SizedBox(height: kDefaultPadding,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/cap.png',),
              Image.asset('assets/images/spin.png', )
            ],
          ),
          Center(child: Image.asset('assets/images/gift.png', ))

        ],
      ),
    );
  }
}
