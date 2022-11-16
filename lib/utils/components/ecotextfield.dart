import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/components/gradient_text.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'gradient_text_style.dart';

class EcoTextField extends StatelessWidget {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color(0xBD8E37).withOpacity(1),
      Color(0xFCD877).withOpacity(1),
      Color(0xFFFFD1).withOpacity(1),
      // Color.fromARGB(0, 248, 248, 133).withOpacity(1),
      Color(0xC1995C).withOpacity(1),
    ],
  ).createShader(Rect.fromLTWH(0.0, 20.0, 0.0, 70.0));
  String? hinttext;
  TextEditingController? controller;
  String? Function(String?)? validate;
  String? Function(String?)? onChanged;

  int? maxlines;
  bool isPassword;
  bool check;
  Widget? preIcons;
  Widget? postIcons;
  bool? enable;
  TextInputType? keyboardType;
  String? upperText;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;
  EcoTextField({
    this.hinttext,
    this.controller,
    this.enable = true,
    this.validate,
    this.keyboardType,
    this.maxlines,
    this.isPassword = false,
    this.check = false,
    this.preIcons,
    this.postIcons,
    this.upperText,
    this.inputAction,
    this.focusNode,
    this.onChanged,
  });

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
            child: Text(
              upperText!,
              style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffFCD877),
                  fontFamily: "gotham-light",
                  fontWeight: FontWeight.w400),
            ),
            // child: GradientText(
            //   upperText!,
            //   style: TextStyle(
            //       fontSize: 18,
            //       fontFamily: "gotham-light",
            //       fontWeight: FontWeight.w400),
            //   gradient: LinearGradient(
            //       begin: Alignment.bottomCenter,
            //       end: Alignment.topCenter,
            //       // tileMode: TileMode.clamp,
            //       colors: [
            //         Color(0xffBD8E37).withOpacity(1),
            //         Color(0xffFCD877).withOpacity(1),
            //         Color(0xFffFFFD1).withOpacity(1),
            //         // Color.fromARGB(0, 248, 248, 133).withOpacity(1),
            //         Color(0xffC1995C).withOpacity(1),
            //       ]),
            // ),
          ),
          TextFormField(
            cursorColor: Color(0xffFCD877),
            onChanged: onChanged,
            style: TextStyle(
              // color: Colors.white,
              fontSize: 18,
              // foreground: Paint()..shader = linearGradient,
              color: Color(0xffFCD877),
            ),
            enabled: enable == true ? true : enable,
            maxLines: maxlines == null ? 1 : maxlines,
            focusNode: focusNode,
            textInputAction: inputAction,
            keyboardType:
                keyboardType == null ? TextInputType.name : keyboardType,
            controller: controller,
            validator: validate,
            obscureText: isPassword == false ? false : isPassword,
            decoration: InputDecoration(
                // errorBorder:
                //     OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffFCD877),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffFCD877),
                  ),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffFCD877),
                  ),
                ),
                // border: OutlineInputBorder(
                //     borderSide: BorderSide(width: 0, style: BorderStyle.none)),
                alignLabelWithHint: true,
                hintText: hinttext ?? "Hint text......",
                hintMaxLines: 1,
                hintStyle: TextStyle(),
                suffixIcon: postIcons,
                prefixIcon: preIcons,
                contentPadding: EdgeInsets.only(top: 15)),
          ),
          // Container(
          //   height: 1.5,
          //   width: MediaQuery.of(context).size.width - 20,
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [
          //         Color(0xBD8E37).withOpacity(1),
          //         Color(0xFCD877).withOpacity(1),
          //         Color(0xFFFFD1).withOpacity(1),
          //         // Color.fromARGB(0, 248, 248, 133).withOpacity(1),
          //         Color(0xC1995C).withOpacity(1),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class EcoMobileTextField extends StatelessWidget {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color(0xffBD8E37).withOpacity(1),
      Color(0xffFCD877).withOpacity(1),
      Color(0xffFFFFD1).withOpacity(1),
      // Color.fromARGB(0, 248, 248, 133).withOpacity(1),
      Color(0xffC1995C).withOpacity(1),
    ],
  ).createShader(Rect.fromLTWH(0.0, 20.0, 0.0, 70.0));
  String? hinttext;
  TextEditingController? controller;
  String? Function(String?)? validate;
  String? Function(PhoneNumber?)? onChanged;

  int? maxlines;
  bool isPassword;
  bool check;
  Widget? preIcons;
  Widget? postIcons;
  bool? enable;
  TextInputType? keyboardType;
  String? upperText;
  String? isoCode;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;
  EcoMobileTextField({
    this.hinttext,
    this.controller,
    this.onChanged,
    this.enable = true,
    this.validate,
    this.keyboardType,
    this.maxlines,
    this.isPassword = false,
    this.check = false,
    this.preIcons,
    this.postIcons,
    this.upperText,
    this.inputAction,
    this.focusNode,
    this.isoCode,
  });

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
          InternationalPhoneNumberInput(
            inputDecoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFCD877),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFCD877),
                ),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFCD877),
                ),
              ),
            ),
            onInputChanged: onChanged,
            // onInputChanged: (PhoneNumber number) {
            //   // print(number.phoneNumber);
            //   isoCode = number.phoneNumber;
            // },
            onInputValidated: (bool value) {
              print(value);
            },
            selectorConfig: SelectorConfig(
              selectorType: PhoneInputSelectorType.DROPDOWN,
            ),
            ignoreBlank: false,
            countries: ['MY', 'PK', 'SG', 'TH', 'KH'],
            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
            initialValue: PhoneNumber(isoCode: 'MY'),
            textFieldController: controller,
            formatInput: false,
            keyboardType:
                TextInputType.numberWithOptions(signed: true, decimal: true),
            inputBorder: OutlineInputBorder(),
            onSaved: (PhoneNumber number) {
              print('On Saved: $number');
            },
          ),
        ],
      ),
    );
  }
}


// Positioned(
//                 bottom: 1,
//                 child: Container(
//                   height: 1.5,
//                   width: MediaQuery.of(context).size.width - 20,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Color(0xBD8E37).withOpacity(1),
//                         Color(0xFCD877).withOpacity(1),
//                         Color(0xFFFFD1).withOpacity(1),
//                         // Color.fromARGB(0, 248, 248, 133).withOpacity(1),
//                         Color(0xC1995C).withOpacity(1),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),