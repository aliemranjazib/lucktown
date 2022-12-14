import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/components/gradient_text.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:google_fonts/google_fonts.dart';

class TopUpMethodScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, web_product_detail);
                        // Navigator.pop(context);
                      },
                      padding: EdgeInsets.all(0),
                      icon: Icon(Icons.navigate_before, size: 28)),
                  SizedBox(width: 20),
                  Center(
                      child: Text("Back",
                          style: GoogleFonts.roboto(fontSize: 24))),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(38.0),
                    child: Image.asset(logo, width: 202, height: 62),
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(58.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: silverGradientRobto(
                          'Top Up USDT', 24, FontWeight.bold)),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: silverGradientRobto(
                                'Top Up Amount', 16, FontWeight.normal)),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Minimum Top Up Amount = USDT 100"),
                            Text("Maximum Top Up Amount = USDT 50,000"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Amount (THB)    0.00',
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(height: 30),
                  Align(
                      alignment: Alignment.topLeft,
                      child: silverGradientRobto(
                          'Platform', 16, FontWeight.normal)),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'balance',
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  // Spacer(),
                  SizedBox(height: 60),

                  PrimaryButton(
                      title: 'Next', onPress: () {}, width: double.infinity)
                ],
              ),
            ),
          ],
        ));
  }
}
