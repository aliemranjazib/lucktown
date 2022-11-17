import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/web_menue/Drawer.dart';
import 'package:provider/provider.dart';

import '../web/menue_folder/menueProvider.dart';

// ignore: camel_case_types
class sideMenu extends StatefulWidget {
  @override
  State<sideMenu> createState() => _sideMenuState();
}

// ignore: camel_case_types
class _sideMenuState extends State<sideMenu> {
  // final MenuController _controller = Get.put(MenuController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: kDarkBlackColor,
        child: ListView(
          children: [
            Image.asset(
              logo,
            ),
            ...List.generate(
                Provider.of<MenuProvider>(context, listen: false)
                    .menuItems
                    .length,
                // _controller.menuItems.length,
                (index) => DrawerTitle(
                      isActive: index ==
                          Provider.of<MenuProvider>(context, listen: false)
                              .selectedIndex,
                      title: Provider.of<MenuProvider>(context, listen: false)
                          .menuItems[index],
                      menuIcon:
                          Provider.of<MenuProvider>(context, listen: false)
                              .menuIcons[index],
                      press: () {
                        setState(() {
                          if (Provider.of<MenuProvider>(context, listen: false)
                                  .menuItems[index] ==
                              "Home") {
                            Navigator.pushNamed(context, web_scaffold_page);
                          } else if (Provider.of<MenuProvider>(context,
                                      listen: false)
                                  .menuItems[index] ==
                              "Profile") {
                            Navigator.pushNamed(context, web_profile_page);
                          }
                          Provider.of<MenuProvider>(context, listen: false)
                              .saveIndex(
                            index,
                            () {},
                          );
                          print(
                              Provider.of<MenuProvider>(context, listen: false)
                                  .selectedIndex);
                        });
                      },
                    )),
            SizedBox(
              height: kDefaultPadding,
            ),
            Container(
              // color: Colors.amber,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        logo,
                        scale: 4,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(malaysia), fit: BoxFit.fill),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  Container(
                    width: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(logo), fit: BoxFit.fill),
                    ),
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  sideMenubottomText('kktt05a', Colors.white),
                  sideMenubottomText('LID:903', Colors.white),
                  sideMenubottomText('Nickname:kktt00005', Colors.white),
                  sideMenubottomText('Referral:kktt00004', Colors.white),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  Row(
                    children: [Icon(Icons.handshake)],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget sideMenubottomText(String t, Color c) => Padding(
        padding: const EdgeInsets.only(left: 17),
        child: Text(
          t,
          style: TextStyle(
            color: c,
          ),
        ),
      );
}
