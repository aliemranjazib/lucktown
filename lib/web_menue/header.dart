import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/web_menue/Drawer.dart';
import 'package:flutter_application_lucky_town/web_menue/web_menu.dart';

import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../web/menue_folder/menueProvider.dart';

class Header extends StatefulWidget {
  Header({
    Key? key,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Colors.black,
        child: SafeArea(
          child: Column(children: [
            Container(
              padding: EdgeInsets.all(kDefaultPadding),
              constraints: BoxConstraints(maxWidth: kMaxWidth),
              child: Row(
                children: [
                  // if (!Responsive.isDesktop(context))
                  ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                      ? WebMenu()
                      : IconButton(
                          onPressed: () {
                            Provider.of<MenuProvider>(context, listen: false)
                                .openOrCloseDraw();
                          },
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                          )),
                  Spacer(),

                  // Spacer(),
                  // social()
                ],
              ),
            ),
            //     SizedBox(
            //       height: kDefaultPadding * 2,
            //     ),
            //     Text(
            //       'Welcome to Our Blog',
            //       style: TextStyle(
            //           fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            //       child: Text(
            //         'Stay updated with the newest design and development stories, case studies ;\n and insight shared by DesignDK Team',
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //             color: Colors.white, fontFamily: 'Raleway', height: 1.5),
            //       ),
            //     ),
            //     FittedBox(
            //       child: TextButton(
            //           onPressed: () {},
            //           child: Row(
            //             children: [
            //               Text(
            //                 'Learn More',
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.bold, color: Colors.white),
            //               ),
            //               SizedBox(width: kDefaultPadding / 2),
            //               Icon(
            //                 Icons.arrow_forward,
            //                 color: Colors.white,
            //               )
            //             ],
            //           )),
            //     ),
            //     if (Responsive.isDesktop(context))
            //       SizedBox(
            //         height: kDefaultPadding,
            //       )
            //   ],
            // )
          ]),
        ));
  }
}
