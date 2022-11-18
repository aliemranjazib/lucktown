import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/components/gradient_text.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/web_menue/Drawer.dart';

class BigBOxComponets extends StatelessWidget {
  const BigBOxComponets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 150,
          width: kMaxWidth/2.58,
          decoration: BoxDecoration(
            color: Color(0xff252A2D),
            borderRadius: BorderRadius.circular(20)
          ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding),
                  child:
                      silverGradientRobto('Check-in: Day 5', 20, FontWeight.normal),
                ),

             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                  Column(
                    children: [
                      Image.asset(Hnadcoin, scale: 1,),
                      silverGradientRobto('50 MYR', 15, FontWeight.normal)
                    ],
                  ),
                  SizedBox(width: 30,),
                  Image.asset(
                    'assets/images/spin.png', scale: 1.5,)
             ],)
            ],),
          Image.asset(gift, scale: 1.5,)
          ],
          
        ),
        ),
      ),
      
      
      ]
    ,);
  }
}


class BigBOxComponetsDeskTopView extends StatelessWidget {
  const BigBOxComponetsDeskTopView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 350,
          width: kMaxWidth/4,
          decoration: BoxDecoration(
            color: Color(0xff252A2D),
            borderRadius: BorderRadius.circular(20)
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
              Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding),
                  child:
                      silverGradientRobto('Check-in: Day 5', 20, FontWeight.normal),
                ),

             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                  Column(
                    children: [
                      Image.asset(Hnadcoin, scale: 1,),
                      silverGradientRobto('50 MYR', 15, FontWeight.normal)
                    ],
                  ),
                  SizedBox(width: 30,),
                  Image.asset(
                    'assets/images/spin.png', scale: 1.5,)
             ],)
            ],),
          Image.asset(gift, scale: 1.5,)
          ],
          
        ),
        ),
      ),
      
      
      ]
    ,);
  }
}
