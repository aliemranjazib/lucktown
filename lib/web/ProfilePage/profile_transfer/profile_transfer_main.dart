import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/app_routes/app_routes.dart';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_dialogue.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_toast.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/constants/api_constants.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/settings/setting_page.dart';
import 'package:flutter_application_lucky_town/web/contact/contactsModel.dart';
import 'package:flutter_application_lucky_town/web/contact/searchfriendmodel.dart';
import 'package:flutter_application_lucky_town/web_menue/Drawer.dart';
import 'package:flutter_application_lucky_town/web_menue/header.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/db_services/share_pref.dart';

class ProfileTransferPage extends StatefulWidget {
  @override
  State<ProfileTransferPage> createState() => _ProfileTransferPageState();
}

class _ProfileTransferPageState extends State<ProfileTransferPage> {
  bool isLoadingGif = false;
  bool isSearching = false;
  bool isAdding = false;

  ContactsModel contactsModel = ContactsModel();
  SearchFriendModel sm = SearchFriendModel();
  String buttonText = "+ New Friend";
  TextEditingController searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  TextEditingController addController = TextEditingController();

  Future<String> getToken() async {
    String aa = await LuckySharedPef.getOnlyAuthToken();
    setState(() {});
    return await aa;
  }

  getAllDate() async {
    setState(() {
      isLoadingGif = false;
    });
    await getToken();
    await getContacts();
  }

  showBoxDialogue() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.symmetric(horizontal: 40),
          // backgroundColor: Color.fromARGB(255, 46, 45, 45),
          backgroundColor: kContainerBg,

          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  logo,
                  height: 100,
                  width: 150,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close))
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: SettingTextField(
                      title: "add friend",
                      controller: addController,
                      hintText: "search by name"),
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 30,
                ),
                PrimaryButton(
                    title: "confirm",
                    loading: isAdding,
                    onPress: () async {
                      await searchFriend();

                      // if (sm.response!.friend!.memberUniqueKey!.isNotEmpty) {
                      //   await addFriend();
                      // }
                      // searchFriend().then((value) {
                      //   print(
                      //       "member unique key${value.response!.friend!.memberUniqueKey!}");
                      //   // addFriend();
                      //   if (value
                      //       .response!.friend!.memberUniqueKey!.isNotEmpty) {
                      //     addFriend();
                      //   }
                      // });
                    },
                    width: double.infinity),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<ContactsModel> getContacts() async {
    setState(() {
      isLoadingGif = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}friend/list'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await getToken(),

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

  deleteFriend(String key) async {
    try {
      final response =
          await http.post(Uri.parse('${memberBaseUrl}friend/delete'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                "Authorization": await um!.response!.authToken!,
              },
              body: jsonEncode(
                <String, dynamic>{
                  "data": {
                    "friendKey": key,
                  }
                },
              ));
      switch (response.statusCode) {
        case 200:
          CustomToast.customToast(context, "friend deleted");
          getContacts();
          break;
        case 400:
          CustomToast.customToast(context, "something went wrong");
          break;
        default:
      }
    } catch (e) {
      print(e);
    }
  }

  Future<SearchFriendModel> searchFriend() async {
    setState(() {
      isSearching = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}friend/search'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await um!.response!.authToken!,

          // 'Authorization':
        },
        body: jsonEncode(<String, dynamic>{
          "data": {"search": "${addController.text}"}
        }),
      );

      switch (response1.statusCode) {
        case 200:
          Map<String, dynamic> data = json.decode(response1.body);
          setState(() {
            sm = SearchFriendModel.fromJson(data);
          });
          setState(() {
            isSearching = false;
            // buttonText = "Send Request";
          });
          addFriend();
          print("${sm.msg} ${response1.statusCode}");

          break;
        case 400:
          Map<String, dynamic> data = json.decode(response1.body);
          CustomToast.customToast(context, "${data['msg']}");
          setState(() {
            isSearching = false;
          });

          break;
        default:
          Map<String, dynamic> data = json.decode(response1.body);
          CustomToast.customToast(context, "${data['msg']}");

          setState(() {
            isSearching = false;
          });

        // CustomToast.customToast(context, "WENT WRONG");
      }
    } catch (e) {
      setState(() {
        isSearching = false;
      });
      CustomToast.customToast(context, e.toString());
    }

    return sm;
  }

  addFriend() async {
    setState(() {
      isAdding = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}friend/add'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await um!.response!.authToken!,
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            "friendKey": sm.response!.friend!.memberUniqueKey!,
            "amount": "2"
          }
        }),
      );
      switch (response1.statusCode) {
        case 200:
          Map<String, dynamic> data = json.decode(response1.body);
          setState(() {
            isAdding = false;
          });
          // print("${sm.msg} ${response1.statusCode}");
          CustomToast.customToast(context, "${data['msg']}");
          Navigator.pop(context);

          break;
        case 400:
          Map<String, dynamic> data = json.decode(response1.body);
          CustomToast.customToast(context, "${data['msg']}");

          setState(() {
            isAdding = false;
          });

          break;
        default:
          Map<String, dynamic> data = json.decode(response1.body);
          CustomToast.customToast(context, "${data['msg']}");

          setState(() {
            isAdding = false;
          });

          CustomToast.customToast(context, data['msg']);
        // CustomToast.customToast(context, "WENT WRONG");
      }
    } catch (e) {
      setState(() {
        isAdding = false;
      });
      CustomToast.customToast(context, e.toString());
    }
  }

  @override
  void initState() {
    getAllDate();
    super.initState();
  }

  filterData(String query) {
    var dummySearch = contactsModel.response!.list;
    dummySearch!.addAll(contactsModel.response!.list!);
    if (query.isNotEmpty) {
      var dummyData = contactsModel.response!.list!;
      dummySearch.forEach((element) {
        if (element!.memberUsername!
            .toLowerCase()
            .contains(query.toLowerCase())) {
          dummyData.add(element);
        }
      });
      setState(() {
        contactsModel.response!.list!.clear();
        contactsModel.response!.list!.addAll(dummyData);
      });
      return;
    } else {
      setState(() {
        contactsModel.response!.list!.clear();
        contactsModel.response!.list!.addAll(contactsModel.response!.list!);
      });
      // return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        // drawer: sideMenu(),
        // key: Provider.of<MenuProvider>(context, listen: false).scaffoldkey,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header(),
              Row(
                children: [
                  Container(
                    height: 50,
                    color: Colors.black,
                    child: Row(
                      children: [
                        BackButton(
                          onPressed: () {
                            // GoRouter.of(context).goNamed(RouteCon.profile_page);
                            GoRouter.of(context).pop();
                          },
                        ),
                        ResponsiveVisibility(
                            visible: true,
                            hiddenWhen: const [
                              Condition.smallerThan(name: TABLET)
                            ],
                            child: Text("Back"))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        logo,
                        width:
                            ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                                ? 202
                                : 101,
                        height:
                            ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                                ? 62
                                : 31,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),

              contactsModel.response == null
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Color(0xffBD8E37),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xffFCD877)),
                      ),
                    )
                  : friendList(),
            ],
          ),
        ),
      ),
    );
  }

  friendList() {
    return ResponsiveWrapper.of(context).isLargerThan(MOBILE)
        ? SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 44, 49, 53),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextFormField(
                                controller: searchController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "should not be empty";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  // filterData(searchController.text);
                                  setState(() {
                                    contactsModel.response!.list = contactsModel
                                        .response!.list!
                                        .where((element) => element!
                                            .memberUniqueKey!
                                            .contains(searchController.text))
                                        .toList();
                                  });
                                  // print(mm);
                                  // var dummy = contactsModel.response!.list;

                                  // contactsModel.response!.list = contactsModel
                                  //     .response!.list!
                                  //     .where((element) =>
                                  //         element!.memberUsername ==
                                  //         searchController.text)
                                  //     .toList();
                                  // print(contactsModel
                                  //     .response!.list!.first!.memberId!);
                                },
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    contactsModel.response == null
                        ? CircularProgressIndicator()
                        : SingleChildScrollView(
                            child: Container(
                              color: Color(0xff121519),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20),
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
                                    Expanded(
                                        flex: 2, child: Text("Phone Number")),
                                    Expanded(
                                        flex: 2, child: Text("Last Update")),
                                    Expanded(
                                        flex: 2,
                                        child: Text("Transfer Amount")),
                                    Expanded(
                                        flex: 2,
                                        child: Center(child: Text("Action"))),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: contactsModel.response!.list!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final contacts = contactsModel.response!.list![index]!;
                        return Container(
                          color: Color(0xff212631),
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: contactDetialRow(
                              icon1: Icons.edit,
                              onPress: () {
                                print(contactsModel
                                    .response!.list![index]!.friendUniqueKey);
                              },
                              icon2: Icons.delete,
                              onPressDelete: () {
                                print(contactsModel
                                    .response!.list![index]!.friendUniqueKey);
                                deleteFriend(contactsModel
                                    .response!.list![index]!.friendUniqueKey!);
                              },
                              imgUrl: contacts.memberAvatarUrl!,
                              lastUpdate: contacts.modifiedDatetime!,
                              phoneNumber: contacts.friendStatus!,
                              userName: contacts.memberUsername!,
                              onPressAmount: () {
                                print(contacts.friendId);
                                print("Aaaaa");
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialog(
                                      name: contacts.memberUsername,
                                      memberUniqueKey:
                                          contacts.memberUniqueKey!,
                                      amount: "0.0",
                                      avatar: contacts.memberAvatarUrl ??
                                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973461_960_720.png",
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
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
                      itemCount: contactsModel.response!.list!.length,
                      itemBuilder: (context, index) {
                        final contacts = contactsModel.response!.list![index]!;

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
                                  image: NetworkImage(
                                contacts.memberAvatarUrl!,
                              )),
                            ),
                          ),
                          title: Text(contacts.memberUsername!),
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
  GestureTapCallback onPress;
  GestureTapCallback? onPressAmount;

  GestureTapCallback onPressDelete;
  TextEditingController? controller;
  String? Function()? onSumbit;

  contactDetialRow({
    Key? key,
    required this.icon1,
    required this.icon2,
    required this.imgUrl,
    required this.lastUpdate,
    required this.phoneNumber,
    required this.userName,
    required this.onPress,
    this.onPressAmount,
    this.onSumbit,
    this.controller,
    required this.onPressDelete,
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
              child: GestureDetector(
                onTap: () {
                  onPressAmount!();
                },
                child: Container(
                  height: 43,
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff252A2D)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Enter amount",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.white60),
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
                child: IconButton(
                  icon: Icon(icon1),
                  // icon1,
                  iconSize: 15,
                  onPressed: () {
                    onPress();
                  },
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
                child: IconButton(
                  icon: Icon(icon2),
                  // icon1,
                  iconSize: 15,
                  onPressed: () {
                    onPressDelete();
                  },
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
