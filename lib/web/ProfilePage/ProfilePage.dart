import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news/SliverGradient.dart';
import 'package:news/components/web_menu.dart';
import 'package:news/constants.dart';
import 'package:news/screens/main/ProfilePage/Componet/BigBoxComponet.dart';
import 'package:news/screens/main/ProfilePage/Componet/CompleteTextBar.dart';
import 'package:news/screens/main/ProfilePage/Componet/HeaderComponet.dart';
import 'package:news/screens/main/ProfilePage/Componet/HomeScreenCatagory.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kDarkBlackColor,
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // WebMenu(),
                // Spacer(),
                ProfileHeader(),
                CompleteTextBar(),
                HomeScreenCatagory(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BigBOxComponets(),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            smallcontainer(
                                'Top up / WithDraw',
                                Icon(
                                  Icons.account_balance_wallet_rounded,
                                  color: kPrimaryColor,
                                  size: 30,
                                )),
                            SizedBox(
                              width: 12,
                            ),
                            smallcontainer(
                                'Transfer',
                                Icon(
                                  Icons.compare_arrows,
                                  color: kPrimaryColor,
                                  size: 30,
                                )),
                            SizedBox(
                              width: 12,
                            ),
                            smallcontainer(
                                'Bank Account',
                                Icon(
                                  Icons.account_balance_outlined,
                                  color: kPrimaryColor,
                                  size: 30,
                                )),
                            SizedBox(
                              width: 12,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            smallcontainer(
                                'Currency Exchange',
                                Icon(
                                  Icons.currency_bitcoin,
                                  color: kPrimaryColor,
                                  size: 30,
                                )),
                            SizedBox(
                              width: 12,
                            ),
                            smallcontainer(
                                'Help Desk',
                                Icon(
                                  Icons.headphones_outlined,
                                  color: kPrimaryColor,
                                  size: 30,
                                )),
                            SizedBox(
                              width: 12,
                            ),
                            smallcontainer(
                                'Promotion',
                                Icon(
                                  Icons.card_giftcard_outlined,
                                  color: kPrimaryColor,
                                  size: 30,
                                )),
                            SizedBox(
                              width: 12,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            smallcontainer(
                                'VIP',
                                Icon(
                                  Icons.card_giftcard,
                                  color: kPrimaryColor,
                                  size: 30,
                                )),
                            SizedBox(
                              width: 12,
                            ),
                            smallcontainer(
                                'Setting',
                                Icon(
                                  Icons.settings,
                                  color: kPrimaryColor,
                                  size: 30,
                                )),
                            SizedBox(
                              width: 12,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22),
              child: Text(
                '订单记录  / Order',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22),
              child: Row(
                children: [
                  Text(
                    'Top Up',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  SizedBox(
                    width: kDefaultPadding * 3,
                  ),
                  Text(
                    'WithDraw',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    width: double.infinity,
                    height: 5,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    width: kMaxWidth / 15,
                    height: 5,
                    color: Colors.amber,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Container(
                width: kMaxWidth / 3,
                height: 40,
                decoration: BoxDecoration(
                    color: Color(0xff252A2D),
                    borderRadius: BorderRadius.circular(4)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 23, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Record',
                            style:
                                TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          Text(
                            'Status',
                            style:
                                TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          Text(
                            'Top Up',
                            style:
                                TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 18.0,
                right: 18.0,
              ),
              child: Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                    color: Color(0xff252A2D),
                    borderRadius: BorderRadius.circular(4)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RowData(),
                      RowData(),
                        RowData(),
                          RowData(),
                            RowData(),
                              RowData(),
                                RowData(),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget RowData() {
    return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Record',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      Text(
                        'Status',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      Text(
                        'Top Up',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  );
  }

  Widget smallcontainer(String title, Icon icon) {
    return Column(
      children: [
        Container(
          width: kMaxWidth / 4,
          height: kDefaultPadding * 5,
          decoration: BoxDecoration(
              color: Color(0xff252A2D),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              icon,
              silverGradient(title, 20),
            ],
          ),
        ),
        SizedBox(
          height: kDefaultPadding,
          width: kDefaultPadding,
        )
      ],
    );
  }
}
