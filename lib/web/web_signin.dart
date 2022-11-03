import 'dart:convert';
import 'dart:html';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_toast.dart';
import 'package:flutter_application_lucky_town/utils/components/ecotextfield.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/components/small_button.dart';
import 'package:flutter_application_lucky_town/utils/components/social_buttons.dart';
import 'package:flutter_application_lucky_town/utils/components/verify_button.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
// import 'package:ftoast/ftoast.dart';
import 'package:http/http.dart' as http;
import 'package:multiple_result/multiple_result.dart';

import '../models/user_model.dart';
import '../utils/components/gradient_text.dart';
import '../utils/constants/api_constants.dart';
import 'package:client_information/client_information.dart';

String? tempAuthKey;

class WebSignInPage extends StatefulWidget {
  // String? image;
  // String? text;
  Map? data;
  WebSignInPage({this.data});

  @override
  State<WebSignInPage> createState() => _WebSignInPageState();
}

class _WebSignInPageState extends State<WebSignInPage> {
  int index = 0;
  bool line_visible1 = false;
  bool line_visible = true;
  String? selectedvalue = "+60";
  bool isLoading = false;
  bool isValidatingUserName = false;

  bool isPasswordShown = false;
  String? isoCode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController yourIdController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController refferalController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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

  Future<ClientInformation> getDeviceId() async {
    return (await ClientInformation.fetch());
  }

  @override
  void initState() {
    super.initState();
    getDeviceId().then((value) => print("www ${value.deviceName}"));
  }

  saveData() {
    if (_formKey.currentState!.validate()) {
      // print("OKKKKK");
      if (passwordController.text != confirmPasswordController.text) {
        CustomToast.customToast(
            context, "password and retype password is not matched");
      } else {
        signupUser();
      }
    }
  }

  validateUserName() async {
    setState(() {
      isValidatingUserName = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}user/validateUsername'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',

          // 'Authorization':
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            // "tokenKey": widget.data,
            "username": yourIdController.text,
            // "language": widget.data!['language'],
          }
        }),
      );
      switch (response1.statusCode) {
        case 200:
          setState(() {
            isValidatingUserName = true;
          });
          Map<String, dynamic> data = json.decode(response1.body);
          if (data['msg'] == 'Member Not Found!') {
            CustomToast.customToast(context, 'user does not exist');
          } else if (data['msg'] == 'Member Not Found!') {
            CustomToast.customToast(context, 'user does not exist');
          }
          print(response1.statusCode);

          setState(() {
            isValidatingUserName = false;
          });
          break;
        default:
          final data = json.decode(response1.body);
          print(response1.statusCode);
          print(data);
          setState(() {
            isValidatingUserName = false;
          });

          CustomToast.customToast(context, data['msg']);
        // CustomToast.customToast(context, "WENT WRONG");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      CustomToast.customToast(context, e.toString());
    }
  }

  Future<Result<Exception, UserModel>> signupUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.post(
        Uri.parse('${memberBaseUrl}user/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            "username": yourIdController.text,
            "phoneNumber": phoneController.text,
            "countryCode": isoCode,
            "password": passwordController.text,
            "confirmPassword": confirmPasswordController.text,
            "refUsername": refferalController.text,
            "countryId": 1
          }
        }),
      );
      switch (response.statusCode) {
        case 200:
          setState(() {
            isLoading = true;
          });
          final data = json.decode(response.body);
          // 2. return Success with the desired value
          print("successs");
          // print(Success());
          print(data['response']['authToken']);
          try {
            tempAuthKey = data['response']['authToken'];
            final response1 = await http.post(
              Uri.parse('${memberBaseUrl}user/sendRegisterOtp'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': data['response']['authToken']
              },
              body: jsonEncode(<String, dynamic>{
                "data": {
                  "phone": phoneController.text,
                  "countryCode": isoCode,
                }
              }),
            );
            switch (response1.statusCode) {
              case 200:
                CustomToast.customToast(context, "OTP SENT SUCCESSFULLY");
                print("token key of user : ${data['response']['userToken']}");
                Navigator.pushNamed(context, web_otp_page,
                    arguments: data['response']['userToken']);
                break;
              default:
                CustomToast.customToast(context, "WENT WRONG");
            }
          } catch (e) {}
          setState(() {
            // index = 0;
            isLoading = false;
          });

          // Navigator.pushNamed(context, web_otp_page,
          //     arguments: data['response']['authToken']);

          return Success(UserModel.fromJson(data));
        default:
          print(Exception(response.reasonPhrase));
          final data = json.decode(response.body);
          //Interactive toast, set [isIgnoring] false.
          setState(() {
            isLoading = false;
          });
          CustomToast.customToast(context, "${data['msg']}");

          // FToast.toast(
          //   context,
          //   msg: "${data['msg']}",
          //   // subMsg: "Welcome to use FToast. This is subMsg!",
          //   color: Color(0xff3F3F3F),
          //   image: Image.asset(info),
          //   imageDirection: AxisDirection.left,
          // );
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(content: Text("${data['msg']}")));
          return Error(Exception(response.reasonPhrase));
      }
    } catch (e) {
      // catch all exceptions (not just SocketException)
      // 4. return Error here too
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${Exception("SOMETHING WENT WRONG")}")));
      print(Error(Exception()));
      return Error(Exception("NOT OK"));
    }
  }

  @override
  Widget build(BuildContext context) {
    s();
    return Scaffold(
        backgroundColor: Colors.black,
        body: Row(
          children: [
            Expanded(
              // child: Image.asset(bg),
              // child: Container(
              //   color: Colors.black,
              // ),
              child: Container(
                // width: double.infinity,
                decoration: BoxDecoration(
                  color: bgColor,
                  image: DecorationImage(
                    image: AssetImage(tabletsidebar),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
                child: Center(child: Image.asset(logo)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 50, right: 60),
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
                                  silverGradient("Sign In", 24),
                                  Visibility(
                                      visible: line_visible,
                                      child: Image.asset(line)),
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
                                  silverGradient("Sign Up", 24),
                                  Visibility(
                                      visible: line_visible1,
                                      child: Image.asset(line)),
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
              ),
            ),
          ],
        ));
  }

  Widget signIn() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 0),
        child: Column(
          children: [
            // edit(),
            EcoTextField(
              upperText: "Your ID",
              preIcons: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(userIcon),
              ),
            ),
            SizedBox(height: 30),
            EcoTextField(
              isPassword: isPasswordShown,
              upperText: "Password",
              postIcons: IconButton(
                icon: isPasswordShown
                    ? Icon(Icons.visibility_off, color: primaryColor)
                    : Icon(Icons.visibility, color: primaryColor),
                onPressed: () {
                  setState(() {
                    isPasswordShown = !isPasswordShown;
                  });
                },
              ),
              // postIcons: Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Image.asset(eye_open),
              // ),
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
                title: "Login", width: double.infinity, onPress: () {}),
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
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    RegExp reguser = RegExp(r'^[a-zA-Z0-9]+$');
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 0),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: EcoTextField(
                    upperText: "Your ID",
                    controller: yourIdController,
                    onChanged: (v) {
                      print(yourIdController.text);
                    },
                    validate: (p) {
                      if (p!.isEmpty) {
                        return "text should not be empty";
                      } else {
                        return null;
                      }
                    },
                    preIcons: Image.asset(
                      userIcon,
                    ),
                  ),
                ),
                PrimaryButton(
                  title: "verify",
                  loading: isValidatingUserName,
                  onPress: () {
                    validateUserName();
                  },
                  width: 100,
                ),
              ],
            ),
            SizedBox(height: 30),
            EcoTextField(
              isPassword: false,
              upperText: "Password",
              controller: passwordController,
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Please enter password';
                } else {
                  if (!regex.hasMatch(value)) {
                    return 'Enter valid password';
                  } else {
                    return null;
                  }
                }
              },
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
            passwordConditions(
                Icons.done, "does not contain your email address"),
            SizedBox(height: 30),
            EcoTextField(
              isPassword: false,
              upperText: "Confirm Password",
              controller: confirmPasswordController,
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Please enter password';
                } else {
                  if (!regex.hasMatch(value)) {
                    return 'Enter valid password';
                  } else {
                    return null;
                  }
                }
              },
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
              upperText: "Mobile Number",
              controller: phoneController,
              isoCode: isoCode,
              onChanged: (p) {
                print("okk ${p!.dialCode}");
                isoCode = p.dialCode;
              },
            ),
            SizedBox(height: 30),
            EcoTextField(
              upperText: "Your Full Name",
              controller: nameController,
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Please enter full name';
                } else {
                  return null;
                }
              },
              preIcons: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(userIcon),
              ),
            ),
            SizedBox(height: 30),
            EcoTextField(
              upperText: "Referral Code",
              controller: refferalController,
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Please enter valid referral code';
                } else {
                  return null;
                }
              },
              preIcons: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(userIcon),
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Checkbox(value: true, onChanged: (v) {}),
                Expanded(
                  child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.330),
                      padding: EdgeInsets.all(10),
                      // margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 0),
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
                ),
              ],
            ),
            PrimaryButton(
                title: "Sign Up",
                width: double.infinity,
                loading: isLoading,
                onPress: () async {
                  print("OKKKKK");
                  // await saveUsers();
                  print(phoneController.text);
                  print(isoCode);
                  saveData();
                  // setState(() {
                  //   index = 0;
                  // });

                  // Navigator.pushNamed(context, web_otp_page);
                }),
            SizedBox(height: 20),
          ],
        ),
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
            size: 16,
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
