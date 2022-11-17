import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/Componet/TextBarComponet.dart';
import 'package:flutter_application_lucky_town/web_menue/Drawer.dart';

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileTextBarComponet(
            title: 'Chips',
            icon: Icon(
              Icons.handshake,
              color: kPrimaryColor,
            ),
            yesicon: false,
          ),
          ProfileTextBarComponet(
            title: 'THB $chips',
            icon: Icon(
              Icons.handshake,
              color: kPrimaryColor,
            ),
            yesicon: true,
          ),
          ProfileTextBarComponet(
            title: 'Cash',
            icon: Icon(
              Icons.handshake,
              color: kPrimaryColor,
            ),
            yesicon: false,
          ),
          ProfileTextBarComponet(
            title: 'THB $cash',
            icon: Icon(
              Icons.handshake,
              color: kPrimaryColor,
            ),
            yesicon: true,
          ),
          ProfileTextBarComponet(
            title: 'Coin',
            icon: Icon(
              Icons.handshake,
              color: kPrimaryColor,
            ),
            yesicon: false,
          ),
          ProfileTextBarComponet(
            title: 'THB $coin',
            icon: Icon(
              Icons.handshake,
              color: kPrimaryColor,
            ),
            yesicon: true,
          ),
          ProfileTextBarComponet(
            title: 'Stage',
            icon: Icon(
              Icons.handshake,
              color: kPrimaryColor,
            ),
            yesicon: false,
          ),
          ProfileTextBarComponet(
            title: '$stage',
            icon: Icon(
              Icons.handshake,
              color: kPrimaryColor,
            ),
            yesicon: true,
          ),
        ],
      ),
    );
  }
}
