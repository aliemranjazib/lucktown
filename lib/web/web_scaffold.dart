import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/components/select_category.dart';

import '../utils/constants/contants.dart';

class WebScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
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
                SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    logo,
                    width: 428,
                    height: 131,
                  ),
                ),
                SizedBox(height: 30),
                Image.asset(country_picker),
                // silverGradient("Pick Your Country", 24),
                // Image.asset(line, width: double.infinity),
                SizedBox(height: 70),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: select_country
                        .map((e) => InkWell(
                            onTap: () => Navigator.pushNamed(
                                context, web_signin_page,
                                arguments: {"image": e.image, "text": e.text}),
                            child: selectCountry(
                                e.text!,
                                e.image!,
                                MediaQuery.of(context).size.width * 0.02,
                                context)))
                        .toList(),
                  ),
                ),
                // Spacer(),
                SizedBox(height: 170),
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
