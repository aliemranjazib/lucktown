import 'package:flutter/material.dart';
import 'package:news/constants.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: kDefaultPadding),
          child: Container(
            height: kMaxWidth / 7,
            
            color: kDarkBlackColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/Mask group.png',
                  scale: 2,
                ),
                SizedBox(width: kDefaultPadding,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('kktt005a',style: TextStyle(color: Colors.white),),
                    Text('LID:903',style: TextStyle(color: Colors.white)),
                    Text('Nickname:kktt00005',style: TextStyle(color: Colors.white)),
                    Text('Referral:kktt0004',style: TextStyle(color: Colors.white)),
                  ],
                )
              ],
            ),
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
                image: DecorationImage(image: AssetImage('assets/images/Flag_of_Malaysia 1.png',), )
              ),),
            Container(
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(image: AssetImage('assets/images/barCode.png'), scale: 2)
              ),),
           
              
          ],),
        ),
      ],
    );
  }
}
