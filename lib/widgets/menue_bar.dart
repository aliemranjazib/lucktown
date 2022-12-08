import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/app_routes/app_routes.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/utils/db_services/share_pref.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:go_router/go_router.dart';

class MenuBar extends StatelessWidget {
  // const MenuBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 56,
        alignment: Alignment.centerLeft,
        color: Colors.black,
        padding: ResponsiveValue<EdgeInsets>(context,
            defaultValue: const EdgeInsets.symmetric(
              horizontal: 35,
              // vertical: 10,
            ),
            valueWhen: [
              const Condition.smallerThan(
                  name: TABLET, value: EdgeInsets.symmetric(horizontal: 0))
            ]).value,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ResponsiveVisibility(
              visible: true,
              // hiddenWhen: const [Condition.smallerThan(name: TABLET)],
              child: Container(
                  // height: 56,
                  child: Center(
                      child: Image.asset(
                navbar_logo,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ))),
            ),
            SizedBox(width: 20),
            ResponsiveVisibility(
              visible: true,
              hiddenWhen: const [Condition.smallerThan(name: TABLET)],
              child: Expanded(
                child: Center(
                  child: Container(
                      child: Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child:
                            Text("HOME", style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("CONTACT",
                            style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("TRANSACTION",
                            style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("PROFILE",
                            style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(),
                      ),
                    ],
                  )),
                ),
              ),
            ),
            // ResponsiveVisibility(
            //   visible: true,
            //   hiddenWhen: const [Condition.smallerThan(name: TABLET)],
            //   child: TextButton(
            //     onPressed: () {},
            //     style: TextButton.styleFrom(
            //         padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            //         foregroundColor: Colors.amber),
            //     child: const Text(
            //       'Sign in',
            //       style: TextStyle(fontSize: 14, color: Colors.amber),
            //     ),
            //   ),
            // ),
            ResponsiveVisibility(
                visible: true,
                hiddenWhen: const [Condition.smallerThan(name: TABLET)],
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Color(0xff252A2D),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          scale: 1,
                          // fit: BoxFit.contain,
                          image: AssetImage(navbar_gift),
                        )),
                  ),
                )),
            ResponsiveVisibility(
                visible: true,
                // hiddenWhen: const [Condition.smallerThan(name: TABLET)],
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 50,
                    width: 50,
                    child: IconButton(
                        onPressed: () {
                          LuckySharedPef.removeAuthToken().then((value) =>
                              context.goNamed(RouteCon.scaffold_page));
                        },
                        icon: Icon(Icons.logout)),
                    decoration: BoxDecoration(
                      color: Colors.amberAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                )),
            ResponsiveVisibility(
                visible: true,
                hiddenWhen: const [Condition.smallerThan(name: TABLET)],
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Color(0xff252A2D),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          scale: 1,
                          // fit: BoxFit.contain,
                          image: AssetImage(navbar_search),
                        )),
                  ),
                )),

            ResponsiveVisibility(
              visible: false,
              visibleWhen: const [Condition.smallerThan(name: TABLET)],
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu, color: Colors.white, size: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
