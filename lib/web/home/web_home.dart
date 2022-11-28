import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/models/product_model.dart';
import 'package:flutter_application_lucky_town/models/profile_model.dart';
import 'package:flutter_application_lucky_town/models/user_session_model.dart';
import 'package:flutter_application_lucky_town/utils/components/gradient_text.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/utils/db_services/share_pref.dart';
import 'package:flutter_application_lucky_town/web/home/coin_chips.dart';
import 'package:flutter_application_lucky_town/web/home/info.dart';
import 'package:flutter_application_lucky_town/web/home/siderbar.dart';
import 'package:flutter_application_lucky_town/web/menue_folder/menueProvider.dart';
import 'package:flutter_application_lucky_town/web/sign_in_sign_up/web_signin.dart';
import 'package:flutter_application_lucky_town/web_menue/SideMenu.dart';
import 'package:flutter_application_lucky_town/web_menue/header.dart';
import 'package:flutter_application_lucky_town/widgets/banner.dart';
import 'package:http/http.dart' as http;
import 'package:multiple_result/multiple_result.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../utils/components/custom_toast.dart';
import '../../utils/components/small_button.dart';
import '../../utils/constants/api_constants.dart';

class WebHomePage extends StatefulWidget {
  @override
  State<WebHomePage> createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebHomePage> {
  bool isLoadingGif = false;
  bool isLoadingProducts = false;
  bool isLoadingProfile = false;
  String sIndex = "popular";
  int totalProducts = 100;
  int productsPerPage = 8;
  int currentPage = 0;
  ProductsModel? gProducts;

  // int pageCount = totalProducts ~/ productsPerPage;

  previousPage() {
    //lets not go bellow 0 :-)
    if (currentPage != 0) {
      setState(() {
        currentPage -= 1;
      });
    }
  }

  nextPage() {
    if ((currentPage + 1) < pageCount()) {
      setState(() {
        currentPage += 1;
      });
    }
  }

  num pageCount() {
    return gProducts!.response!.products!.length / productsPerPage;
  }

  List gifs = [];
  // List<Products> resultProducts = [];
  // List<Products> filteredProducts = [];
  ProfileData profileData = ProfileData();
  int count = 8;
  Map<String, dynamic> userInfo = {};

  Future<ProfileData> getProfileInfo() async {
    setState(() {
      isLoadingProfile = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}user/getProfileData'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await um!.response!.authToken!,
        },
        body: jsonEncode(<String, dynamic>{"data": {}}),
      );
      switch (response1.statusCode) {
        case 200:
          Map<String, dynamic> data = json.decode(response1.body);
          setState(() {
            profileData = ProfileData.fromJson(data);
          });
          if (!mounted) ;
          print("coin ${profileData.response!.accounts!.first!.accountName}");
          setState(() {
            isLoadingProfile = false;
          });
          break;
        case 514:
          Navigator.pushNamed(context, web_scaffold_page);
          break;
        case 500:
          Navigator.pushNamed(context, web_scaffold_page);
          break;
        // break;
        default:
          final data = json.decode(response1.body);
          print(response1.statusCode);
          print(data);
          CustomToast.customToast(context, data['msg']);
          setState(() {
            isLoadingProfile = false;
          });
      }
    } catch (e) {
      CustomToast.customToast(context, e.toString());
    }

    return profileData;
  }

  Future<ProductsModel> getAllProducts() async {
    setState(() {
      isLoadingProducts = true;
    });

    try {
      final response = await http.post(
        Uri.parse('${memberBaseUrl}game/getProductList'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": um!.response!.authToken!,
        },
        body: jsonEncode(<String, dynamic>{
          "data": {"language": "my"}
        }),
      );
      switch (response.statusCode) {
        case 200:
          print(response.statusCode);
          final data = json.decode(response.body);
          gProducts = ProductsModel.fromJson(data);
          print(
              "first game status ${gProducts!.response!.products!.first!.productName}");
          setState(() {
            isLoadingProducts = false;
          });
          break;
        case 514:
          Navigator.pushNamed(context, web_scaffold_page);
          break;
        case 500:
          Navigator.pushNamed(context, web_scaffold_page);
          break;
        default:
          print(response.statusCode);
          setState(() {
            isLoadingProducts = false;
          });
      }
    } catch (e) {
      print(e);
      CustomToast.customToast(context, e.toString());
    }
    return gProducts!;
  }

  getSliderImages() async {
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}Banner/list'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await um!.response!.authToken!
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            "language": "en",
          }
        }),
      );
      switch (response1.statusCode) {
        case 200:
          Map<String, dynamic> data = json.decode(response1.body);
          for (var i in data['response']['banners']) {
            gifs.add(i['banner_url']);
          }
          break;
        case 514:
          Navigator.pushNamed(context, web_scaffold_page);
          break;
        case 500:
          Navigator.pushNamed(context, web_scaffold_page);
          break;
        default:
          final data = json.decode(response1.body);
          print(response1.statusCode);
          CustomToast.customToast(context, data['msg']);
      }
    } catch (e) {
      CustomToast.customToast(context, e.toString());
    }
  }

  bool isGettingToken = false;
  Future<UserSessionModel> getToken() async {
    String aa = await LuckySharedPef.getAuthToken();
    Map<String, dynamic> decodedata = jsonDecode(aa);

    setState(() {
      um = UserSessionModel.fromJson(decodedata);
      print("tttt ${um!.response!.user!.memberUsername}");
    });

    return await um!;
  }

  getAllData() async {
    setState(() {
      isGettingToken = true;
    });
    await getToken();
    print("www ${um!.response!.authToken!.length}");
    getSliderImages();
    getProfileInfo();
    getAllProducts();
    setState(() {
      isGettingToken = false;
    });
    // getAllProducts();
  }

  @override
  void initState() {
    // Future.delayed(Duration(seconds: 0), () {
    //   getSliderImages();
    // });
    // getAllProducts();
    // getProfileInfo();
    // print(um!.response!.authToken);
    getAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getProducts();
    // print('iii ${LuckySharedPef.getAuthToken()}');
    // getAllData();
    // final sw = MediaQuery.of(context).size.width;
    print("authtoken ${um!.response!.authToken}");
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: sideMenu(),
      key: Provider.of<MenuProvider>(context, listen: false).scaffoldkey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // MenuBar(),
            Header(),
            // Text(profileData.response.)
            isGettingToken ? Text("Aaaaaaaaaaaa") : BannerArea(gifs),
            SizedBox(height: 12),
            isLoadingProfile
                ? Text("loaaaa")
                : Row(
                    children: [
                      ResponsiveVisibility(
                        visible: true,
                        hiddenWhen: const [Condition.smallerThan(name: TABLET)],
                        child: Expanded(
                          child: Container(
                            // height: 1048,
                            width: 200,
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(color: Color(0xff292929)),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(avatar),
                                          SizedBox(width: 10),
                                          Text(
                                            "${um!.response!.user!.memberUsername}",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(qrIcon),
                                          SizedBox(width: 10),
                                          Image.asset(malaysia,
                                              height: 35, width: 35),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  // info(
                                  //     title: "LID",
                                  //     value: userModel!.memberUsername!),
                                  // info(title: "Nickname", value: "oooo"),
                                  Info(
                                      title: "Referral",
                                      value:
                                          "${um!.response!.user!.refMemberName}"),
                                  SizedBox(height: 10),
                                  coin_chips(
                                    title: "Chips",
                                    value: profileData.response!.coinBalance!,
                                  ),
                                  coin_chips(
                                    title: "Cash",
                                    value: profileData.response!.walletBalance!,
                                  ),
                                  coin_chips(
                                    title: "Coin",
                                    value:
                                        profileData.response!.interestBalance!,
                                  ),
                                  SizedBox(height: 30),
                                  join_nowButton(() {}),
                                  SizedBox(height: 50),
                                  // sidebar(context, sIndex)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      ///////////
                      Expanded(
                        flex: 4,
                        child: Container(
                          child: Column(
                            children: [
                              ResponsiveVisibility(
                                visible: false,
                                visibleWhen: [
                                  Condition.largerThan(name: MOBILE)
                                ],
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 8, 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      silverGradient(
                                          "Popular Games ${currentPage + 1}",
                                          32),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: (currentPage - 1) >= 0
                                                ? previousPage
                                                : null,
                                            child: Container(
                                              height: 55,
                                              width: 55,
                                              child: Center(
                                                  child: Icon(
                                                      Icons.navigate_before)),
                                              decoration: BoxDecoration(
                                                  color: Color(0xff252A2D),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          InkWell(
                                            onTap: ((currentPage + 1) *
                                                        productsPerPage) <
                                                    gProducts!.response!
                                                        .products!.length
                                                ? nextPage
                                                : null,
                                            child: Container(
                                              height: 55,
                                              width: 55,
                                              child: Center(
                                                  child: Icon(
                                                      Icons.navigate_next)),
                                              decoration: BoxDecoration(
                                                  color: Color(0xff252A2D),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ResponsiveVisibility(
                                visible: true,
                                hiddenWhen: [
                                  Condition.largerThan(name: MOBILE)
                                ],
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent:
                                        MediaQuery.of(context).size.height *
                                            0.5,
                                    crossAxisSpacing:
                                        MediaQuery.of(context).size.width *
                                            0.07,
                                  ),
                                  itemCount:
                                      gProducts!.response!.products!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      // height: 134,
                                      // width: 200,
                                      constraints:
                                          BoxConstraints(maxWidth: 200),
                                      child: Column(
                                        children: [
                                          // NetworkImage(url)
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                20), // Image border
                                            child: SizedBox.fromSize(
                                              size: Size.square(
                                                  200), // Image radius
                                              child: Image.network(
                                                gProducts!
                                                        .response!
                                                        .products![index]!
                                                        .productImageUrl ??
                                                    "https://scontent.flhe11-1.fna.fbcdn.net/v/t39.30808-1/291321322_378298201059895_267225053697338827_n.png?stp=dst-png_p120x120&_nc_cat=106&ccb=1-7&_nc_sid=dbb9e7&_nc_ohc=K04AqBLJi9oAX9_zEh4&_nc_ht=scontent.flhe11-1.fna&oh=00_AfAerzR76y4VCuovsw2gGXiskoTUMvRSL57Awb720voYcw&oe=6378128B",
                                                height: 200,
                                                width: 200,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              gProducts!
                                                      .response!
                                                      .products![index]!
                                                      .productName!
                                                      .isEmpty
                                                  ? "no name"
                                                  : gProducts!
                                                      .response!
                                                      .products![index]!
                                                      .productName!,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontFamily: gotham_light),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              gProducts!
                                                      .response!
                                                      .products![index]!
                                                      .productCategory!
                                                      .isNotEmpty
                                                  ? "no category"
                                                  : gProducts!
                                                      .response!
                                                      .products![index]!
                                                      .productCategory!,
                                              style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                  fontSize: 16,
                                                  fontFamily: gotham_light),
                                            ),
                                          ),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.spaceBetween,
                                          //   children: [
                                          //     Row(
                                          //       children: [
                                          //         Text(
                                          //           "4.5",
                                          //           style: TextStyle(
                                          //               color: Colors.white,
                                          //               fontSize: 16,
                                          //               fontFamily:
                                          //                   gotham_light),
                                          //         ),
                                          //         RatingBar.builder(
                                          //           initialRating: 3,
                                          //           minRating: 1,
                                          //           itemSize: 20,
                                          //           direction: Axis.horizontal,
                                          //           allowHalfRating: true,
                                          //           itemCount: 5,
                                          //           itemPadding:
                                          //               EdgeInsets.symmetric(
                                          //                   horizontal: 0.0),
                                          //           itemBuilder: (context, _) =>
                                          //               Icon(
                                          //             Icons.star,
                                          //             size: 14,
                                          //             color: Colors.amber,
                                          //           ),
                                          //           onRatingUpdate: (rating) {
                                          //             print(rating);
                                          //           },
                                          //         ),
                                          //       ],
                                          //     ),
                                          //     ResponsiveVisibility(
                                          //         visible: true,
                                          //         hiddenWhen: const [
                                          //           Condition.smallerThan(
                                          //               name: TABLET)
                                          //         ],
                                          //         child: Padding(
                                          //           padding:
                                          //               const EdgeInsets.all(
                                          //                   5.0),
                                          //           child: Container(
                                          //             height: 34,
                                          //             width: 34,
                                          //             decoration: BoxDecoration(
                                          //                 color:
                                          //                     Color(0xff252A2D),
                                          //                 shape:
                                          //                     BoxShape.circle,
                                          //                 image:
                                          //                     DecorationImage(
                                          //                   scale: 1,
                                          //                   // fit: BoxFit.contain,
                                          //                   image: AssetImage(
                                          //                     favourite,
                                          //                   ),
                                          //                 )),
                                          //           ),
                                          //         )),
                                          //   ],
                                          // ),

                                          SizedBox(height: 5),
                                          join_nowButton(() {
                                            Navigator.pushNamed(
                                                context, web_product_detail,
                                                arguments: gProducts!.response!
                                                    .products![index]);
                                          }),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              ResponsiveVisibility(
                                visible: false,
                                visibleWhen: [
                                  Condition.largerThan(name: MOBILE)
                                ],
                                child: Container(
                                  // width: double.infinity,
                                  // height: 300,
                                  // decoration: BoxDecoration(color: Color(0xff292929)),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    // padding: EdgeInsets.all(20),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      mainAxisExtent:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      crossAxisSpacing:
                                          MediaQuery.of(context).size.width *
                                              0.07,
                                      // mainAxisSpacing: 160,
                                    ),
                                    itemCount: productsPerPage,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // print(gProducts[index].productImageUrl!);
                                      return Container(
                                        // height: 134,
                                        // width: 200,
                                        constraints:
                                            BoxConstraints(maxWidth: 200),
                                        child: Column(
                                          children: [
                                            // NetworkImage(url)
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      20), // Image border
                                              child: SizedBox.fromSize(
                                                size: Size.square(
                                                    200), // Image radius
                                                child: Image.network(
                                                  gProducts!
                                                          .response!
                                                          .products![index +
                                                              (currentPage *
                                                                  productsPerPage)]!
                                                          .productImageUrl!
                                                          .isEmpty
                                                      ? "https://scontent.flhe11-1.fna.fbcdn.net/v/t39.30808-1/291321322_378298201059895_267225053697338827_n.png?stp=dst-png_p120x120&_nc_cat=106&ccb=1-7&_nc_sid=dbb9e7&_nc_ohc=K04AqBLJi9oAX9_zEh4&_nc_ht=scontent.flhe11-1.fna&oh=00_AfAerzR76y4VCuovsw2gGXiskoTUMvRSL57Awb720voYcw&oe=6378128B"
                                                      : gProducts!
                                                          .response!
                                                          .products![index +
                                                              (currentPage *
                                                                  productsPerPage)]!
                                                          .productImageUrl!,
                                                  height: 200,
                                                  width: 200,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),

                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                gProducts!
                                                        .response!
                                                        .products![index +
                                                            (currentPage *
                                                                productsPerPage)]!
                                                        .productName ??
                                                    "no name",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontFamily: gotham_light),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                gProducts!
                                                        .response!
                                                        .products![index +
                                                            (currentPage *
                                                                productsPerPage)]!
                                                        .productCategory ??
                                                    "no category",
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                    fontSize: 16,
                                                    fontFamily: gotham_light),
                                              ),
                                            ),

                                            SizedBox(height: 5),
                                            join_nowButton(() {
                                              Navigator.pushNamed(
                                                  context, web_product_detail,
                                                  arguments: gProducts!
                                                      .response!
                                                      .products![index]);
                                            }),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
