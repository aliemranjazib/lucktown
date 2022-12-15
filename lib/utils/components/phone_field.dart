import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'gradient_text_style.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: GradientText(
              "Mobile Number",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "gotham-light",
                  fontWeight: FontWeight.w400),
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  // tileMode: TileMode.clamp,
                  colors: [
                    Color(0xffBD8E37).withOpacity(1),
                    Color(0xffFCD877).withOpacity(1),
                    Color(0xffFFFFD1).withOpacity(1),
                    // Color.fromARGB(0, 248, 248, 133).withOpacity(1),
                    Color(0xffC1995C).withOpacity(1),
                  ]),
            ),
          ),
          Stack(
            children: [
              InternationalPhoneNumberInput(
                inputDecoration: InputDecoration(
                  border: InputBorder.none,
                ),
                onInputChanged: (PhoneNumber number) {
                  print(number.phoneNumber);
                },
                onInputValidated: (bool value) {
                  print(value);
                },
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.DROPDOWN,
                ),
                ignoreBlank: false,
                countries: ['MY', 'PK', 'SG', 'TH', 'KH'],
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle:
                    TextStyle(color: Colors.white.withOpacity(0.6)),
                initialValue: PhoneNumber(isoCode: 'MY'),
                textFieldController: controller,
                formatInput: false,
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                inputBorder: OutlineInputBorder(),
                onSaved: (PhoneNumber number) {
                  print('On Saved: $number');
                },
              ),
              Positioned(
                bottom: 1,
                child: Container(
                  height: 1.5,
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xBD8E37).withOpacity(1),
                        Color(0xFCD877).withOpacity(1),
                        Color(0xFFFFD1).withOpacity(1),
                        // Color.fromARGB(0, 248, 248, 133).withOpacity(1),
                        Color(0xC1995C).withOpacity(1),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
