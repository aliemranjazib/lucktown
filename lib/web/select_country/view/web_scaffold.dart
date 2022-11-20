import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/components/select_category.dart';
import 'package:flutter_application_lucky_town/utils/db_services/share_pref.dart';
import 'package:flutter_application_lucky_town/web/select_country/viewModel/selectCountry.dart';
import 'package:flutter_application_lucky_town/web_menue/SideMenu.dart';
import 'package:flutter_application_lucky_town/web_menue/header.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/components/gradient_text.dart';
import '../../../utils/constants/contants.dart';
import '../../menue_folder/menueProvider.dart';

class WebScaffold extends StatefulWidget {
  @override
  State<WebScaffold> createState() => _WebScaffoldState();
}

class _WebScaffoldState extends State<WebScaffold> {
  @override
  Widget build(BuildContext context) {
    // print("mmm ${LuckySharedPef.getAuthToken()}");
    return Scaffold(
        backgroundColor: Colors.black,
        // drawer: sideMenu(),
        // key: Provider.of<MenuProvider>(context, listen: false).scaffoldkey,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xF5F5F5),
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Text(
                //   "token : ${LuckySharedPef.getAuthToken()}",
                //   style: TextStyle(color: Colors.white),
                // ),
                // SizedBox(height: 70),
                // Header(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    logo,
                    width: ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                        ? 428
                        : 202,
                    height: ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                        ? 131
                        : 62,
                  ),
                ),
                SizedBox(height: 30),
                Image.asset(
                  country_picker,
                  width: ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                      ? 265
                      : 183,
                  height: ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                      ? 172
                      : 119,
                ),

                SizedBox(height: 70),

                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  // height: 1000,
                  child: GridView(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.5,
                      crossAxisCount:
                          ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                              ? 4
                              : ResponsiveWrapper.of(context).isTablet
                                  ? 4
                                  : 2,
                      // mainAxisSpacing:
                      //     ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                      //         ? 5
                      //         : 5,
                      // crossAxisSpacing:
                      //     ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                      //         ? 5
                      //         : 5
                      // mainAxisExtent:
                      //     MediaQuery.of(context).size.height * 0.5,
                      // crossAxisSpacing:
                      //     MediaQuery.of(context).size.width * 0.07,
                    ),
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: select_country
                        .map((e) => GestureDetector(
                            onTap: () {
                              setState(() {
                                Provider.of<SelectCountry>(context,
                                        listen: false)
                                    .saveCountry(
                                  {"image": e.image, "text": e.text},
                                );
                              });
                              Navigator.pushNamed(
                                context,
                                web_signin_page,
                              );
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Image.asset(
                                    e.image!,
                                    width: ResponsiveWrapper.of(context)
                                            .isLargerThan(MOBILE)
                                        ? 124
                                        : 84,
                                    height: ResponsiveWrapper.of(context)
                                            .isLargerThan(MOBILE)
                                        ? 124
                                        : 84,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(height: 10),
                                silverGradientRobto(
                                    e.text!,
                                    ResponsiveWrapper.of(context)
                                            .isLargerThan(MOBILE)
                                        ? 24
                                        : 16,
                                    FontWeight.normal)
                              ],
                            )))
                        .toList(),
                  ),
                ),
                // Spacer(),
                SizedBox(height: 140),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Column(
                    children: [
                      Text("Licensed By",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "gotham",
                            fontSize: MediaQuery.of(context).size.height * 0.03,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(footerbrand),
                      ),
                    ],
                  ),
                ),

                // select_country.map((e) => Text(e.text)).toList(),
              ],
            ),
          ),
        ));
  }
}
