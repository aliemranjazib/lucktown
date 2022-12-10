import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/app_routes/app_routes.dart';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/models/userSignInModel.dart'
    as user;
import 'package:flutter_application_lucky_town/models/user_session_model.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_toast.dart';
import 'package:flutter_application_lucky_town/utils/components/ecotextfield.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/components/social_buttons.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/utils/db_services/share_pref.dart';
import 'package:flutter_application_lucky_town/web/select_country/viewModel/selectCountry.dart';
import 'package:flutter_application_lucky_town/web/select_country/web_main_page.dart';
import 'package:flutter_application_lucky_town/web/sign_in_sign_up/viewModel.dart';
// import 'package:ftoast/ftoast.dart';
import 'package:http/http.dart' as http;
import 'package:is_first_run/is_first_run.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:go_router/go_router.dart';
import '../../models/user_model.dart';
import '../../utils/components/gradient_text.dart';
import '../../utils/constants/api_constants.dart';
import 'package:client_information/client_information.dart';

String? tempAuthKeyforSignup;
String? temAuth;
String? tokenKey;

class WebSignInPage extends StatefulWidget {
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
  bool isBinding = false;
  String text = "verify";
  bool isPasswordShown = false;
  String? isoCode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController yourIdController = TextEditingController();
  final TextEditingController refferalController = TextEditingController();
  ///////////// login controller ////////////////////////////////////
  final TextEditingController userNameC = TextEditingController();
  final TextEditingController userPasswordC = TextEditingController();
  //////////////////////////////////////////////////////////////
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
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

  ClientInformation cli = ClientInformation();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => check());
    getDeviceId().then((value) {
      cli = value;
    });
  }

  saveData(String countryId) async {
    if (_formKey.currentState!.validate()) {
      // print("OKKKKK");
      if (passwordController.text != confirmPasswordController.text) {
        CustomToast.customToast(
            context, "password and retype password is not matched");
      } else {
        await signupUser(countryId);
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
          print("not ${data['msg']}");
          if (data['msg'] == 'Member Not Found!') {
            CustomToast.customToast(context, 'user does not exist');
          } else if (data['msg'] == 'Member exists!') {
            CustomToast.customToast(
                context, 'user exist. choose any other userId');
          }
          print(response1.statusCode);

          setState(() {
            isValidatingUserName = false;
          });
          break;
        case 400:
          Map<String, dynamic> data = json.decode(response1.body);
          if (data['msg'] == '[username] is Empty') {
            CustomToast.customToast(context, 'username is Empty');
          } else if (data['msg'] == 'Member Not Found!') {
            CustomToast.customToast(context, 'userId available');
            setState(() {
              text = "✓";
            });
          }
          setState(() {
            isValidatingUserName = false;
          });
          break;
        default:
          Map<String, dynamic> data = json.decode(response1.body);
          if (data['msg'] == 'Member Not Found!') {
            CustomToast.customToast(context, 'user does not exist');
          } else if (data['msg'] == 'Member exists!') {
            CustomToast.customToast(
                context, 'user exist. choose any other name');
          }
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

  bindOtp() async {
    setState(() {
      isBinding = true;
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
          } else if (data['msg'] == 'Member exists!') {
            CustomToast.customToast(
                context, 'user exist. choose any other name');
          }
          print(response1.statusCode);

          setState(() {
            isValidatingUserName = false;
          });
          break;
        default:
          Map<String, dynamic> data = json.decode(response1.body);
          if (data['msg'] == 'Member Not Found!') {
            CustomToast.customToast(context, 'user does not exist');
          } else if (data['msg'] == 'Member exists!') {
            CustomToast.customToast(
                context, 'user exist. choose any other name');
          }
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

  signInUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}user/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            "username": userNameC.text,
            "push_noti_token":
                "d8jZfHNsk0EKkxuFZEbVQO:APA91bHsQUQjMpLKadIdktX-y-0doGvJLskp4NgbAjcru4jWuAanZ4BcsjmwBlrEXcQC5Ltm8cLxqTv0U5R3zoftqjX8szjSyE3bhj6wUphhXpDVytKjMEpB5OgEB9lFj3laGxVV5_Tx",
            "password": userPasswordC.text,
            "language": "EN",
            "authSession": "",
            "deviceInfo": {
              "deviceId": "${cli.deviceId}",
              "userAgent": "${cli.applicationName}",
              "model": "${cli.deviceId}",
              "manufacturer": "${cli.softwareName}",
              "host": "21DJ6B24",
              "hardware": "${cli.applicationBuildCode}",
              "firstTimeInstall": 1629221041434,
              "deviceName": "${cli.deviceName}",
              "display": "RP1A.200720.012.G780FXXS3CUD7",
              "device": "r8s",
              "carrier": "MY ONEXOX",
              "apiLevel": "${cli.osVersion}",
              "version": "${cli.osVersion}",
              "uniqueId": "58c549bc790a5ed4",
              "id": "58c549bc790a5ed4",
              "platform": "${cli.osName}",
            },
            "version": "4.0.1"
          }
        }),
      );
      switch (response1.statusCode) {
        case 200:
          setState(() {
            isLoading = true;
          });
          Map<String, dynamic> data = json.decode(response1.body);
          setState(() {
            // userModel = user.User.fromJson(data['response']['user']);
          });
          CustomToast.customToast(context, data['msg']);

          Future.delayed(
              Duration(
                seconds: 1,
              ), () {
            LuckySharedPef.saveAuthToken(response1.body);
            // LuckySharedPef.saveOnlyAuthToken(data['response']['authSession']);
            // LuckySharedPef.saveOnlyAuthToken(data['response']['authToken']);
            print("only auth ${data['response']['authToken']}");
          });
          // String? otp = data['response']['userToken'];
          // LuckySharedPef.saveOnlyAuthToken(data['response']['authToken']);
          Future.delayed(
              Duration(
                seconds: 1,
              ), () {
            String aa = LuckySharedPef.getAuthToken();
            // String bb = LuckySharedPef.getOnlyAuthToken();

            // String bb = LuckySharedPef.getOnlyAuthToken();
            // print("get only auth ${bb}");

            Map<String, dynamic> decodedata = jsonDecode(aa);
            setState(() {
              um = UserSessionModel.fromJson(decodedata);
              LuckySharedPef.saveOnlyAuthToken(um!.response!.authToken!);
              // print("tttt ${um!.response!.user!.}");
              // print("only auth is here${bb}");
            });

            context.goNamed(RouteCon.home_Page);
            // print()
          });
          setState(() {
            isLoading = false;
          });
          break;
        case 303:
          CustomToast.customToast(context, "Please bind your account first");
          Map<String, dynamic> data = json.decode(response1.body);
          setState(() {
            temAuth = data['response']['authToken'];
            tokenKey = data['response']['userToken'];
          });
          context.goNamed(RouteCon.bind_otp_page);

          break;
        default:
          final data = json.decode(response1.body);
          print(response1.statusCode);
          print(data);
          setState(() {
            isLoading = false;
          });
          CustomToast.customToast(context, data['msg']);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      CustomToast.customToast(context, e.toString());
    }
  }

  Future<Result<Exception, UserModel>> signupUser(String countryId) async {
    // final getCountries = await Provider.of<SelectCountry>(context);
    // print("selection ${getCountries.getSelection['countrycode']}");
    setState(() {
      isLoading = true;
    });
    // final id = Provider.of<SelectCountry>(context).getSelection[''];
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
            "countryId": "$countryId",
          }
        }),
      );
      switch (response.statusCode) {
        case 200:
          setState(() {
            isLoading = true;
          });
          Map<String, dynamic> data = json.decode(response.body);
          if (data['msg'] == 'Username Existing.') {
            CustomToast.customToast(context, 'user already exist');
          }
          // 2. return Success with the desired value
          print("successs");
          // print(Success());
          print("aaauuttthh ${data['response']['authToken']}");
          setState(() {
            temAuth = data['response']['authToken'];
          });
          try {
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
                context.goNamed(RouteCon.signup_otp_page);
                setState(() {
                  tempAuthKeyforSignup = "${data['response']['userToken']}";
                });
                break;
              default:
                CustomToast.customToast(context, "WENT WRONG");
            }
          } catch (e) {}
          setState(() {
            // index = 0;
            isLoading = false;
          });

          return Success(UserModel.fromJson(data));
        default:
          Map<String, dynamic> data = json.decode(response.body);
          if (data['msg'] == 'Username Existing.') {
            CustomToast.customToast(context, 'user already exist');
          }
          setState(() {
            isLoading = false;
          });

          return Error(Exception(response.reasonPhrase));
      }
    } catch (e) {
      // catch all exceptions (not just SocketException)
      // 4. return Error here too
      CustomToast.customToast(context, e.toString());

      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text("${Exception("SOMETHING WENT WRONG")}")));
      print(Error(Exception()));
      return Error(Exception("NOT OK"));
    }
  }

  check() {
    if (Provider.of<SelectCountry>(context).getSelection['countrycode'] ==
        null) {
      print("done");
    }
  }

  @override
  Widget build(BuildContext context) {
    s();
    if (Provider.of<SelectCountry>(context).getSelection['countrycode'] ==
        null) {
      context.goNamed(RouteCon.scaffold_page);
    }
    // print(
    //     "opop ${Provider.of<SelectCountry>(context).getSelection['countrycode']}");
    // print("bbbb ${jsonDecode(LuckySharedPef.getAuthToken())['msg']}");
    // Provider.of<SelectCountry>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          ResponsiveVisibility(
            visible: true,
            hiddenWhen: [Condition.smallerThan(name: TABLET)],
            child: Expanded(
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
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 0, right: 10, left: 10),
              child: SingleChildScrollView(
                child: Container(
                  // height: double.infinity,
                  color: bgColor,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BackButton(
                            onPressed: () {
                              context.goNamed(RouteCon.scaffold_page);
                            },
                          ),
                          // SizedBox(width: 10),
                          Expanded(
                            child: Center(
                              child: Image.asset(
                                logo,
                                height: 60,
                                width: 195,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 70),
                      Consumer<SelectCountry>(
                        builder: (context, value, child) {
                          return Column(
                            children: [
                              value.getSelection['icon'] == null
                                  ? CircularProgressIndicator(
                                      backgroundColor: Color(0xffBD8E37),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xffFCD877)),
                                    )
                                  : Container(
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
                                        minRadius: 47,
                                        maxRadius: 47,
                                        backgroundColor: Colors.transparent,
                                        child: Image.network(
                                          value.getSelection['icon'],
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
                              value.getSelection['name'] == null
                                  ? CircularProgressIndicator(
                                      backgroundColor: Color(0xffBD8E37),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xffFCD877)),
                                    )
                                  : silverGradientRobto(
                                      value.getSelection['name'],
                                      ResponsiveWrapper.of(context)
                                              .isLargerThan(MOBILE)
                                          ? 24
                                          : 16,
                                      FontWeight.bold)
                            ],
                          );
                        },
                      ),

                      // Provider.of<SelectCountry>(context)
                      //             .getSelection['image'] ==
                      //         null
                      //     ? CircularProgressIndicator()
                      //     : Image.asset(
                      //         Provider.of<SelectCountry>(context)
                      //             .getSelection['image'],
                      //       ),
                      // SizedBox(height: 10),
                      // Provider.of<SelectCountry>(context)
                      //             .getSelection['text'] ==
                      //         null
                      //     ? CircularProgressIndicator()
                      //     : silverGradient(
                      //         Provider.of<SelectCountry>(context)
                      //             .getSelection['text'],
                      //         24),
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
                                silverGradient(
                                    "Sign In",
                                    ResponsiveWrapper.of(context)
                                            .isLargerThan(MOBILE)
                                        ? 24
                                        : 16),
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
                                silverGradient(
                                    "Sign Up",
                                    ResponsiveWrapper.of(context)
                                            .isLargerThan(MOBILE)
                                        ? 24
                                        : 16),
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
                          Visibility(
                              visible: index == 1, child: signUp(context)),
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
      ),
    );
  }

  Widget signIn() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            // edit(),
            EcoTextField(
              controller: userNameC,
              upperText: "Your ID",
              preIcons: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(userIcon),
              ),
            ),
            SizedBox(height: 30),
            EcoTextField(
              controller: userPasswordC,
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
                      onTap: () => context.goNamed(RouteCon.forget_page),
                      child: silverGradientLight("Forget Password?", 16)),
                )),
            PrimaryButton(
                title: "Login",
                width: double.infinity,
                loading: isLoading,
                onPress: () {
                  signInUser();
                }),
            SizedBox(height: 10),
            // Container(
            //   // margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 0),
            //   child: Row(
            //     children: [
            //       Expanded(
            //           child: Container(
            //         child: SocialButton(
            //             title: "Google", image: google, onPress: () {}),
            //       )),
            //       SizedBox(width: 10),
            //       Expanded(
            //           child: Container(
            //         child: SocialButton(
            //           title: "Facebook",
            //           image: facebook,
            //           onPress: () {},
            //           // color: Color(0x262261),
            //         ),
            //       )),
            //     ],
            //   ),
            // ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget signUp(BuildContext context) {
    final getCountries = Provider.of<SelectCountry>(context);

    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    // RegExp reguser = RegExp(r'^[a-zA-Z0-9]+$');
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                      if (yourIdController.text.isEmpty) {
                        setState(() {
                          text = "verify";
                        });
                      }
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
                  title: "$text",
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
                Checkbox(
                    activeColor: primaryColor, value: true, onChanged: (v) {}),
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
                                        color: primaryColor, fontSize: 16),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {})
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
                  saveData(getCountries.getSelection['countryId']);
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
