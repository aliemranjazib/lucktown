import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_toast.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/constants/api_constants.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/web/contact/contactsModel.dart';
import 'package:flutter_application_lucky_town/web_menue/header.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:responsive_framework/responsive_framework.dart';

import '../../web_menue/SideMenu.dart';
import '../menue_folder/menueProvider.dart';

class ContactMainPage extends StatefulWidget {
  @override
  State<ContactMainPage> createState() => _ContactMainPageState();
}

class _ContactMainPageState extends State<ContactMainPage> {
  bool isLoadingGif = false;

  ContactsModel contactsModel = ContactsModel();

  Future<ContactsModel> getContacts() async {
    setState(() {
      isLoadingGif = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}friend/list'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await um!.response!.authToken!,

          // 'Authorization':
        },
        body: jsonEncode(<String, dynamic>{
          "data": {"search": "", "page": 1, "pageSize": 0}
        }),
      );
      switch (response1.statusCode) {
        case 200:
          Map<String, dynamic> data = json.decode(response1.body);
          setState(() {
            contactsModel = ContactsModel.fromJson(data);
          });

          setState(() {
            isLoadingGif = false;
          });

          break;
        default:
          final data = json.decode(response1.body);
          print(response1.statusCode);
          print(data);
          setState(() {
            isLoadingGif = false;
          });

          CustomToast.customToast(context, data['msg']);
        // CustomToast.customToast(context, "WENT WRONG");
      }
    } catch (e) {
      setState(() {
        isLoadingGif = false;
      });
      CustomToast.customToast(context, e.toString());
    }

    return contactsModel;
  }

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        drawer: sideMenu(),
        key: Provider.of<MenuProvider>(context, listen: false).scaffoldkey,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Header(),
              Container(
                child: TabBar(indicatorColor: Colors.yellow, tabs: [
                  Tab(text: "Friend list"),
                  Tab(text: "Friend request"),
                  Tab(text: "Friend deleted"),
                ]),
              ),
              Container(
                //Add this to give height
                height: MediaQuery.of(context).size.height,
                child: TabBarView(children: [
                  Container(
                    child: friendList(),
                  ),
                  Container(
                    child: Text("Friend request"),
                  ),
                  Container(
                    child: Text("Friend deleted"),
                  ),
                ]),
              ),
              // Row(
              //   children: [
              //     Row(
              //       children: [
              //         Text("Friend list"),
              //         Column(
              //           children: [
              //             Container(
              //               child: Text("Friend request"),
              //             ),
              //           ],
              //         ),
              //         Text("Friend deleted"),
              //       ],
              //     ),
              //   ],
              // ),

              // Padding(
              //   padding: const EdgeInsets.all(12.0),
              //   child: Divider(thickness: 3, color: Colors.white),
              // ),
              /////web view//////////
            ],
          ),
        ),
      ),
    );
  }

  friendList() {
    return ResponsiveWrapper.of(context).isLargerThan(MOBILE)
        ? SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 44, 49, 53),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search",
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              prefixIcon: Container(
                                child: Image.asset(contact_search),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      PrimaryButton(
                        title: "+  New Friend",
                        onPress: () {},
                        width: 120,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                contactsModel.response == null
                    ? CircularProgressIndicator()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Row(
                          children: [
                            // Image.asset("name"),
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text("Avatar"),
                              ),
                            ),
                            Expanded(flex: 2, child: Text("Username")),
                            Expanded(flex: 2, child: Text("Phone Number")),
                            Expanded(flex: 2, child: Text("Last Update")),
                            Expanded(flex: 2, child: Text("Transfer Amount")),
                            Expanded(
                                flex: 2, child: Center(child: Text("Action"))),
                          ],
                        ),
                      ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: contactsModel.response!.list!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final contacts = contactsModel.response!.list![index]!;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: contactDetialRow(
                        icon1: Icons.edit,
                        icon2: Icons.delete,
                        imgUrl: contacts.memberAvatarUrl!,
                        lastUpdate: contacts.modifiedDatetime!,
                        phoneNumber: contacts.friendStatus!,
                        userName: contacts.memberUsername!,
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          )

        ///mobile view///////
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: PrimaryButton(
                    title: "title", onPress: () {}, width: double.infinity),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 44, 49, 53),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: Container(
                        child: Image.asset(contact_search),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, i) {
                        return ListTile(
                          // leading: Icon(Icons.arrow_forward_ios),
                          leading: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                100,
                              ),
                              image: DecorationImage(
                                image: AssetImage(contact_avtar_1),
                              ),
                            ),
                          ),
                          title: Text("kktt005a"),
                          trailing: Icon(Icons.arrow_forward_ios_outlined),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}

class contactDetialRow extends StatelessWidget {
  String imgUrl;
  String userName;
  String phoneNumber;
  String lastUpdate;
  IconData icon1;
  IconData icon2;
  contactDetialRow({
    Key? key,
    required this.icon1,
    required this.icon2,
    required this.imgUrl,
    required this.lastUpdate,
    required this.phoneNumber,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    100,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(imgUrl),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(userName),
          ),
          Expanded(
            child: Text(phoneNumber),
          ),
          Expanded(
            child: Text(lastUpdate),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromARGB(255, 44, 49, 53),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Amount",
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Color.fromARGB(255, 44, 49, 53),
                  // image: DecorationImage(
                  //     image: AssetImage(pen), fit: BoxFit.cover),
                ),
                child: Icon(
                  icon1,
                  size: 15,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Color.fromARGB(255, 44, 49, 53),
                ),
                child: Icon(
                  icon2,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
