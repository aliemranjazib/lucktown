import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/components/select_category.dart';
import '../utils/components/gradient_text.dart';
import '../utils/components/logo_work.dart';
import '../utils/constants/contants.dart';

class MobileScaffold extends StatelessWidget {
  const MobileScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(mobilebg),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    logo,
                    width: 202,
                    height: 62,
                  ),
                ),
                SizedBox(height: 30),
                Image.asset(country_picker),
                SizedBox(height: 70),
                AspectRatio(
                  aspectRatio: 1,
                  child: GridView(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    children: select_country
                        .map((e) => InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, mobileSigninPage,
                                    arguments: {
                                      "image": e.image,
                                      "text": e.text
                                    });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    e.image!,
                                    // width: width / 12,
                                    // height: width / 9.5,
                                    fit: BoxFit.contain,
                                  ),
                                  Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: silverGradient(e.text!, 16),
                                  ))
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),

                SizedBox(height: 120),
                // Text("Licensed By"),
                // Image.asset(footerbrand),

                // select_country.map((e) => Text(e.text)).toList(),
              ],
            ),
          ),
        ));
  }
}
