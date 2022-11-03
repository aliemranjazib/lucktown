import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/components/ecotextfield.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/components/social_buttons.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:http/http.dart' as http;

import '../utils/components/gradient_text.dart';
import '../utils/components/select_category.dart';
import '../utils/constants/api_constants.dart';

class MobileSignInPage extends StatefulWidget {
  // String? image;
  // String? text;
  Map? data;
  MobileSignInPage({this.data});

  @override
  State<MobileSignInPage> createState() => _MobileSignInPageState();
}

class _MobileSignInPageState extends State<MobileSignInPage> {
  int index = 0;
  bool line_visible1 = false;
  bool line_visible = true;
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color(0xBD8E37).withOpacity(1),
      Color(0xFCD877).withOpacity(1),
      Color(0xFFFFD1).withOpacity(1),
      // Color.fromARGB(0, 248, 248, 133).withOpacity(1),
      Color(0xC1995C).withOpacity(1),
    ],
  ).createShader(Rect.fromLTWH(200.0, 0.0, 0.0, 70.0));

  int s() {
    if (index == 0) {
      print("000000000000000");
      setState(() {
        line_visible = true;
        line_visible1 = false;
      });
      return index;
    } else {
      print("11111111111111111111111");
      // line_visible = !line_visible;
      // line_visible = !line_visible;
      setState(() {
        line_visible1 = true;
        line_visible = false;
      });
      return index;
    }
  }

  Future<http.Response> createAlbum() async {
    final response = await http.post(
      Uri.parse('http://lkyhub.xyz/Member/user/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "data": {
          "username": "ali00000",
          "phoneNumber": "1000000111111",
          "countryCode": "+60",
          "password": "123123123",
          "confirmPassword": "123123123",
          "refUsername": "paracha01",
          "countryId": 1
        }
      }),
    );
    if (response.statusCode == 201) {
      print("FINEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
    } else {
      print(response.statusCode);
      throw Exception('Failed to create album.');
    }
    print(response);

    return response;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    s();
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.only(top: 10, right: 0),
          child: SingleChildScrollView(
            child: Container(
              // height: double.infinity,
              color: bgColor,

              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage(tabletrightbar),
              //     fit: BoxFit.cover,
              //     alignment: Alignment.center,
              //   ),
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.navigate_before,
                              color: Colors.white,
                            ),
                            iconSize: 40,
                          ),
                          SizedBox(width: 10),
                          Image.asset(
                            logo,
                            height: 60,
                            width: 195,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                      Image.asset(
                        chat,
                        width: 32,
                        height: 37,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                  // Image.asset(curve),
                  // logoWork(),
                  SizedBox(height: 70),
                  Image.asset(widget.data!['image']),
                  SizedBox(height: 10),
                  silverGradient(widget.data!['text'], 24),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            index = 0;
                          });
                        },
                        child: Column(
                          children: [
                            silverGradient("Sign In", 16),
                            Visibility(
                                visible: line_visible,
                                child: Image.asset(
                                  line,
                                  fit: BoxFit.fitWidth,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                )),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            index = 1;
                          });
                        },
                        child: Column(
                          children: [
                            silverGradient("Sign Up", 16),
                            Visibility(
                                visible: line_visible1,
                                child: Image.asset(
                                  line,
                                  fit: BoxFit.fitWidth,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 70),
                  IndexedStack(
                    index: s(),
                    children: [
                      // silverGradient("Sign In", 24),
                      Visibility(visible: index == 0, child: signIn()),
                      Visibility(visible: index == 1, child: signUp()),
                    ],
                  ),
                  // select_country.map((e) => Text(e.text)).toList(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget signIn() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Column(
          children: [
            // edit(),
            EcoMobileTextField(
              upperText: "Your ID",
              preIcons: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(userIcon),
              ),
            ),
            SizedBox(height: 30),
            EcoMobileTextField(
              isPassword: true,
              upperText: "Password",
              postIcons: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(eye_open),
              ),
              preIcons: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(unlockIcon),
              ),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  child: InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, web_forget_page),
                      child: silverGradientLight("Forget Password?", 16)),
                )),
            PrimaryButton(
                title: "Login",
                width: double.infinity,
                onPress: () async {
                  await createAlbum();
                }),
            SizedBox(height: 10),
            Container(
              // margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 0),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    child: SocialButton(
                        title: "Google", image: google, onPress: () {}),
                  )),
                  SizedBox(width: 10),
                  Expanded(
                      child: Container(
                    child: SocialButton(
                      title: "Facebook",
                      image: facebook,
                      onPress: () {},
                      // color: Color(0x262261),
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget signUp() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
        children: [
          // edit(),
          EcoMobileTextField(
            upperText: "Your ID",
            preIcons: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(userIcon),
            ),
          ),
          SizedBox(height: 30),
          EcoMobileTextField(
            isPassword: true,
            upperText: "Password",
            postIcons: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(eye_open),
            ),
            preIcons: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(unlockIcon),
            ),
          ),
          passwordConditions(Icons.done, "contains at least 8 characters"),
          passwordConditions(
              Icons.done, "contains both lowercase and uppercase letters"),
          passwordConditions(
              Icons.done, "contains at least one number (0-9) or a symbol"),
          passwordConditions(Icons.done, "does not contain your email address"),

          SizedBox(height: 30),

          EcoMobileTextField(
            isPassword: true,
            upperText: "Confirm Password",
            postIcons: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(eye_open),
            ),
            preIcons: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(unlockIcon),
            ),
          ),

          SizedBox(height: 30),

          EcoMobileTextField(
            upperText: "Your Full Name",
            preIcons: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(userIcon),
            ),
          ),
          SizedBox(height: 30),

          EcoMobileTextField(
            upperText: "Referral Code",
            preIcons: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(userIcon),
            ),
          ),
          SizedBox(height: 30),
          Container(
              padding: EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 0),
              child: Center(
                child: RichText(
                  text: TextSpan(
                      text:
                          'By signing up you have read and agree to the LuckyTown ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: gotham_light),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Term & Conditions',
                            style: TextStyle(
                                color: Color(0xFFFCC201), fontSize: 16),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // navigate to desired screen
                              })
                      ]),
                ),
              )),

          PrimaryButton(
              title: "Sign Up",
              width: double.infinity,
              onPress: () {
                print("OKKKKK");
                Navigator.pushNamed(context, web_otp_page);
              })
        ],
      ),
    );
  }

  Widget passwordConditions(IconData icon, String text) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 1,
          ),
          Expanded(
            child: Text(
              text,
              style:
                  TextStyle(color: Color(0xFFEEF2F5), fontFamily: gotham_light),
            ),
          ),
        ],
      ),
    );
  }

  Widget edit() {
    return Container(
      height: 30,
      // margin: EdgeInsets.all(
      //   10.0,
      // ),
      child: Stack(
        children: <Widget>[
          TextField(
            cursorColor: Color(0xBD8E37),
            style: TextStyle(
                // color: Colors.white,
                foreground: Paint()..shader = linearGradient),
            decoration: InputDecoration(
              hintText: "Sign In",
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 0, style: BorderStyle.none)),
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Image.asset(
                  userIcon,
                  height: 20,
                  width: 20,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 15.0,
              ),
            ),
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
    );
  }
}
