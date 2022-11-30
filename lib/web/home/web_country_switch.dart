import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_toast.dart';
import 'package:flutter_application_lucky_town/utils/constants/api_constants.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/web/select_country/viewModel/selectCountry.dart';
import 'package:flutter_application_lucky_town/web_menue/Drawer.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:http/http.dart' as http;

import '../../utils/components/gradient_text.dart';

class Countries {
  String? name;
  String? image;
  Countries({this.name, this.image});
}

class CountrySwitch extends StatefulWidget {
  // final String? selectCountry;
  // const CountrySwitch({super.key, this.selectCountry});

  @override
  State<CountrySwitch> createState() => _CountrySwitchState();
}

class _CountrySwitchState extends State<CountrySwitch> {
  @override
  void initState() {
    final p = Provider.of<SelectCountry>(context, listen: false);
    p.getCountry(context);
    super.initState();
  }

  bool isLoading = false;

  // getData() {
  //   List<Countries> countries = [];
  //   final getCountries = Provider.of<SelectCountry>(context);
  //   for (var element in getCountries.sm.response!.list!) {
  //     countries.add(Countries(name: element!.name, image: element.iconUrl));
  //   }
  // }
  Future countrySwitchCall(String code) async {
    setState(() {
      isLoading = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}country/switch'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await um!.response!.authToken!
        },
        body: jsonEncode(<String, dynamic>{
          "data": {"countryCode": "$code"}
        }),
      );
      switch (response1.statusCode) {
        case 200:
          Map<String, dynamic> data = json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);
          setState(() {
            isLoading = false;
          });
          break;
        case 400:
          Map<String, dynamic> data = json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);
          setState(() {
            isLoading = false;
          });
          break;
        case 514:
          Map<String, dynamic> data = json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);
          setState(() {
            isLoading = false;
          });
          break;
        case 500:
          Map<String, dynamic> data = json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);
          setState(() {
            isLoading = false;
          });
          break;
        default:
          final data = json.decode(response1.body);
          print(response1.statusCode);
          CustomToast.customToast(context, data['msg']);
          setState(() {
            isLoading = false;
          });
      }
    } catch (e) {
      CustomToast.customToast(context, e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // getData();
    final getCountries = Provider.of<SelectCountry>(context);
    return AlertDialog(
      actionsPadding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      // backgroundColor: Color.fromARGB(255, 46, 45, 45),
      backgroundColor: kContainerBg,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              logo,
              height: 100,
              width: 100,
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close))
          ],
        ),
        Center(
          child: getCountries.isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ...List.generate(
                                  getCountries.sm.response!.list!.length,
                                  (index) {
                                final data =
                                    getCountries.sm.response!.list![index]!;

                                return InkWell(
                                  onTap: () {
                                    print(data.code);
                                    countrySwitchCall(data.code!).then(
                                        (value) =>
                                            Navigator.of(context).pop(true));

                                    // getCountries.saveSelection({
                                    //   "name": data.name,
                                    //   "icon": data.iconUrl,
                                    //   "countrycode": data.code,
                                    // });
                                    // Navigator.pushReplacementNamed(
                                    //     context, web_signin_page);
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        // decoration: BoxDecoration(
                                        //     shape: BoxShape.circle,
                                        //     gradient: LinearGradient(
                                        //       begin: Alignment.bottomLeft,
                                        //       end: Alignment.topRight,
                                        //       colors: [
                                        //         Color(0xffBD8E37).withOpacity(1),
                                        //         Color(0xffFCD877).withOpacity(1),
                                        //         Color(0xffFFFFD1).withOpacity(1),
                                        //         // Color.fromARGB(0, 248, 248, 133).withOpacity(1),
                                        //         Color(0xffC1995C).withOpacity(1),
                                        //       ],
                                        //     )),
                                        child: CircleAvatar(
                                          // radius: 47,
                                          minRadius: 47,
                                          maxRadius: 47,
                                          backgroundColor: Colors.transparent,
                                          child: Image.network(
                                            data.iconUrl!,
                                            width: ResponsiveWrapper.of(context)
                                                    .isLargerThan(MOBILE)
                                                ? 50
                                                : 40,
                                            height:
                                                ResponsiveWrapper.of(context)
                                                        .isLargerThan(MOBILE)
                                                    ? 50
                                                    : 40,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      silverGradientRobto(
                                          data.name!,
                                          ResponsiveWrapper.of(context)
                                                  .isLargerThan(MOBILE)
                                              ? 18
                                              : 14,
                                          FontWeight.bold),
                                    ],
                                  ),
                                );
                              })
                            ],
                          ),
                        )),
        ),
      ],
    );
  }
}
