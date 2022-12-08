import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/web_menue/Drawer.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class ProfileHeader extends StatelessWidget {
  final String title;
  final String lid;
  final String nick;
  final String reffercal;
  final String imageUrl;
  final String countryUrl;
  final String qrUrl;

  const ProfileHeader({
    Key? key,
    required this.title,
    required this.lid,
    required this.nick,
    required this.reffercal,
    required this.imageUrl,
    required this.countryUrl,
    required this.qrUrl,
  }) : super(key: key);

  showQRDialogue(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          // backgroundColor: Color.fromARGB(255, 46, 45, 45),
          backgroundColor: kContainerBg,

          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  logo,
                  height: 100,
                  width: 150,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close))
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.network(
                  qrUrl,
                  height: ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                      ? 450
                      : 150,
                  width: ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                      ? 450
                      : 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

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
                      image: NetworkImage(countryUrl),
                    )),
              ),
              InkWell(
                onTap: () {
                  showQRDialogue(context);
                },
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: NetworkImage('assets/images/barcode.png'),
                          scale: 2)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
