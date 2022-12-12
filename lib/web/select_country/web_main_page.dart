// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/app_routes/app_routes.dart';
import 'package:flutter_application_lucky_town/web/select_country/viewModel/selectCountry.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:go_router/go_router.dart';
import '../../utils/components/gradient_text.dart';
import '../../utils/constants/contants.dart';
import "dart:html";

class WebScaffold extends StatefulWidget {
  @override
  State<WebScaffold> createState() => _WebScaffoldState();
}

class _WebScaffoldState extends State<WebScaffold> {
  @override
  void initState() {
    final p = Provider.of<SelectCountry>(context, listen: false);
    p.getCountry(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final getCountries = Provider.of<SelectCountry>(context);

    return Scaffold(
        backgroundColor: Colors.black,
        // drawer: sideMenu(),
        // key: Provider.of<MenuProvider>(context, listen: false).scaffoldkey,
        body: Container(
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
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text(
              //   "token : ${LuckySharedPef.getAuthToken()}",
              //   style: TextStyle(color: Colors.white),
              // ),
              // SizedBox(height: 70),
              // Header(),
              Column(
                children: [
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
                  Image.asset(
                    country_picker,
                    width: ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                        ? 265
                        : 183,
                    height: ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                        ? 172
                        : 119,
                  ),
                ],
              ),
              // SizedBox(height: 30),

              // SizedBox(height: 70),
              getCountries.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      backgroundColor: Color(0xffBD8E37),
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xffFCD877)),
                    ))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ...List.generate(getCountries.sm.response!.list!.length,
                            (index) {
                          final data = getCountries.sm.response!.list![index]!;
                          return GestureDetector(
                            onTap: () {
                              window.localStorage['tok'] = "okkk";

                              print("okkk");
                              getCountries.saveSelection({
                                "name": data.name,
                                "icon": data.iconUrl,
                                "countrycode": data.code,
                                "countryId": data.countryId,
                              });
                              // context.push('/oooooooooooo');
                              // context.replace('/login');
                              context.goNamed(
                                RouteCon.signin_page,
                                // extra: data.name!,
                              );
                              // GoRouter.of(context).go('/login');
                              // context.pushNamed('login');
                              // context.goNamed(RouteCon.web_signin_page);
                              // GoRouter.of(context)
                              //     .goNamed(RouteCon.web_signin_page);
                              // context.pushNamed(web_signin_page);
                            },
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          Color(0xffBD8E37).withOpacity(1),
                                          Color(0xffFCD877).withOpacity(1),
                                          Color(0xffFFFFD1).withOpacity(1),
                                          // Color.fromARGB(0, 248, 248, 133).withOpacity(1),
                                          Color(0xffC1995C).withOpacity(1),
                                        ],
                                      )),
                                  child: CircleAvatar(
                                    // radius: 47,
                                    minRadius: 47,
                                    maxRadius: 47,
                                    backgroundColor: Colors.transparent,
                                    child: Image.network(
                                      data.iconUrl!,
                                      width: ResponsiveWrapper.of(context)
                                              .isLargerThan(MOBILE)
                                          ? 90
                                          : 88,
                                      height: ResponsiveWrapper.of(context)
                                              .isLargerThan(MOBILE)
                                          ? 90
                                          : 88,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                silverGradientRobto(
                                    data.name!,
                                    ResponsiveWrapper.of(context)
                                            .isLargerThan(MOBILE)
                                        ? 24
                                        : 16,
                                    FontWeight.bold),
                              ],
                            ),
                          );
                        })
                      ],
                    ),

              // Container(
              //   width: MediaQuery.of(context).size.width * 0.8,
              //   // height: 1000,
              //   child: GridView(
              //     shrinkWrap: true,
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       childAspectRatio: 0.5,
              //       crossAxisCount:
              //           ResponsiveWrapper.of(context).isLargerThan(MOBILE)
              //               ? 4
              //               : ResponsiveWrapper.of(context).isTablet
              //                   ? 4
              //                   : 2,
              //       // mainAxisSpacing:
              //       //     ResponsiveWrapper.of(context).isLargerThan(MOBILE)
              //       //         ? 5
              //       //         : 5,
              //       // crossAxisSpacing:
              //       //     ResponsiveWrapper.of(context).isLargerThan(MOBILE)
              //       //         ? 5
              //       //         : 5
              //       // mainAxisExtent:
              //       //     MediaQuery.of(context).size.height * 0.5,
              //       // crossAxisSpacing:
              //       //     MediaQuery.of(context).size.width * 0.07,
              //     ),
              //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: select_country
              //         .map((e) => GestureDetector(
              //             onTap: () {
              //               // setState(() {
              //               //   Provider.of<SelectCountry>(context,
              //               //           listen: false)
              //               //       .saveCountry(
              //               //     {"image": e.image, "text": e.text},
              //               //   );
              //               // });
              //               // Navigator.pushNamed(
              //               //   context,
              //               //   web_signin_page,
              //               // );
              //             },
              //             child: Column(
              //               children: [
              //                 Padding(
              //                   padding:
              //                       const EdgeInsets.fromLTRB(0, 0, 0, 0),
              //                   child: Image.asset(
              //                     e.image!,
              //                     width: ResponsiveWrapper.of(context)
              //                             .isLargerThan(MOBILE)
              //                         ? 124
              //                         : 84,
              //                     height: ResponsiveWrapper.of(context)
              //                             .isLargerThan(MOBILE)
              //                         ? 124
              //                         : 84,
              //                     fit: BoxFit.contain,
              //                   ),
              //                 ),
              //                 SizedBox(height: 10),
              //                 silverGradientRobto(
              //                     e.text!,
              //                     ResponsiveWrapper.of(context)
              //                             .isLargerThan(MOBILE)
              //                         ? 24
              //                         : 16,
              //                     FontWeight.normal)
              //               ],
              //             )))
              //         .toList(),
              //   ),
              // ),
              // // Spacer(),

              // SizedBox(height: 140),
              // Spacer(),AQ
              Column(
                children: [
                  Text("Licensed By",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "gotham",
                        fontSize:
                            ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                                ? 24
                                : 16,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(footerbrand),
                  ),
                ],
              ),

              // select_country.map((e) => Text(e.text)).toList(),
            ],
          ),
        ));
  }
}
