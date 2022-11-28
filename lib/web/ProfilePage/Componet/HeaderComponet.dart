import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/web_menue/Drawer.dart';

class ProfileHeader extends StatelessWidget {
  final String title;
  final String lid;
  final String nick;
  final String reffercal;
  final String imageUrl;

  const ProfileHeader({
    Key? key,
    required this.title,
    required this.lid,
    required this.nick,
    required this.reffercal,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: kMaxWidth / 7,
          color: kDarkBlackColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                child: Image.network(
                  imageUrl,
                  scale: 2,
                ),
              ),
              SizedBox(
                width: kDefaultPadding,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name $title',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text('LID:$lid', style: TextStyle(color: Colors.white)),
                  Text('Nickname:$nick', style: TextStyle(color: Colors.white)),
                  Text('Referral:$reffercal',
                      style: TextStyle(color: Colors.white)),
                ],
              )
            ],
          ),
        ),
        Container(
          height: kMaxWidth / 7,
          width: kMaxWidth / 5,
          color: kDarkBlackColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 70,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(malaysia),
                    )),
              ),
              Container(
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        image: AssetImage('assets/images/barcode.png'),
                        scale: 2)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
