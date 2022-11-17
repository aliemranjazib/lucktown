import 'package:flutter/material.dart';
import 'package:news/constants.dart';
import 'package:news/screens/main/ProfilePage/Componet/TextBarComponet.dart';

class CompleteTextBar extends StatelessWidget {
  const CompleteTextBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: kMaxWidth ,
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
            title: 'THB 10000.00',
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
            title: 'THB 10000.00',
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
            title: 'THB 900.00',
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
            title: 'VIP 0',
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


