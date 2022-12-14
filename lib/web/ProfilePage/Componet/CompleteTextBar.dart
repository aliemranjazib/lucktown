import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/Componet/TextBarComponet.dart';
import 'package:flutter_application_lucky_town/web_menue/Drawer.dart';

// ************* for DeskTop ******************//
class CompleteTextBar extends StatelessWidget {
  final String chips;
  final String cash;
  final String coin;
  final String stage;

  const CompleteTextBar({
    Key? key,
    required this.chips,
    required this.cash,
    required this.coin,
    required this.stage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: kMaxWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ProfileTextBarComponet(
            title: 'Chips',
            ImagePath: coin,
            yesicon: false,
          ),
          ProfileTextBarComponet(
            title: 'THB $chips',
            ImagePath: coin,
            yesicon: true,
          ),
          ProfileTextBarComponet(
            title: 'Cash',
            ImagePath: coin,
            yesicon: false,
          ),
          ProfileTextBarComponet(
            title: 'THB $cash',
            ImagePath: coin,
            yesicon: true,
          ),
          ProfileTextBarComponet(
            title: 'Coin',
            ImagePath: coin,
            yesicon: false,
          ),
          ProfileTextBarComponet(
            title: 'THB $coin',
            ImagePath: coin,
            yesicon: true,
          ),
          ProfileTextBarComponet(
            title: 'Stage',
            ImagePath: coin,
            yesicon: false,
          ),
          ProfileTextBarComponet(
            title: '$stage',
            ImagePath: coin,
            yesicon: true,
          ),
        ],
      ),
    );
  }
}

/* for Mobile and Tablet*/

class CompleteTextBarMobileView extends StatelessWidget {
  final String chips;
  final String cash;
  final String coin;
  final String stage;

  const CompleteTextBarMobileView({
    Key? key,
    required this.chips,
    required this.cash,
    required this.coin,
    required this.stage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: kMaxWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProfileTextBarComponet(
                title: 'Chips',
                ImagePath: coin,
                yesicon: false,
              ),
              ProfileTextBarComponet(
                title: 'THB $chips',
                ImagePath: coin,
                yesicon: true,
              ),
              ProfileTextBarComponet(
                title: 'Cash',
                ImagePath: coin,
                yesicon: false,
              ),
              ProfileTextBarComponet(
                title: 'THB $chips',
                ImagePath: coin,
                yesicon: true,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProfileTextBarComponet(
                title: 'Coin',
                ImagePath: coin,
                yesicon: false,
              ),
              ProfileTextBarComponet(
                title: 'THB',
                ImagePath: coin,
                yesicon: true,
              ),
              ProfileTextBarComponet(
                title: 'Stage',
                ImagePath: coin,
                yesicon: false,
              ),
              ProfileTextBarComponet(
                title: '$stage',
                ImagePath: coin,
                yesicon: true,
              ),
            ],
          )
        ],
      ),
    );
  }
}
