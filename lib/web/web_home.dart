import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/models/product_model.dart';
import 'package:flutter_application_lucky_town/models/profile_model.dart';
import 'package:flutter_application_lucky_town/utils/components/gradient_text.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/utils/db_services/share_pref.dart';
import 'package:flutter_application_lucky_town/web/menue_folder/menueProvider.dart';
import 'package:flutter_application_lucky_town/web/product_detail_page.dart';
import 'package:flutter_application_lucky_town/web/sign_in_sign_up/web_signin.dart';
import 'package:flutter_application_lucky_town/web_menue/SideMenu.dart';
import 'package:flutter_application_lucky_town/web_menue/header.dart';
import 'package:flutter_application_lucky_town/widgets/banner.dart';
import 'package:flutter_application_lucky_town/widgets/menue_bar.dart';
import 'package:http/http.dart' as http;
import 'package:multiple_result/multiple_result.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../utils/components/custom_toast.dart';
import '../utils/components/small_button.dart';
import '../utils/constants/api_constants.dart';

List<Products> gProducts = [];

class WebHomePage extends StatefulWidget {
  @override
  State<WebHomePage> createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebHomePage> {
  bool isLoadingGif = false;
  bool isLoadingProducts = false;
  String sIndex = "popular";
  int totalProducts = 100;
  int productsPerPage = 8;
  int currentPage = 0;
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
    return resultProducts.length / productsPerPage;
  }

  List gifs = [];
  List<Products> resultProducts = [];
  List<Products> filteredProducts = [];
  ProfileData profileData = ProfileData();
  int count = 8;
  Future<String> getToken() async {
    return await LuckySharedPef.getAuthToken();
  }

  Future<ProfileData> getProfileInfo() async {
    if (getToken().toString().isNotEmpty) {
      try {
        final response1 = await http.post(
          Uri.parse('${memberBaseUrl}user/getProfileData'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": await getToken(),

            // 'Authorization':
          },
          body: jsonEncode(<String, dynamic>{"data": {}}),
        );
        switch (response1.statusCode) {
          case 200:
            setState(() {
              isLoadingGif = true;
            });
            Map<String, dynamic> data = json.decode(response1.body);
            setState(() {
              profileData = ProfileData.fromJson(data);
            });
            print("coin ${profileData.response!.accounts!.first.accountName}");

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
    }
    return profileData;
  }

  filterProducts(String category) {
    for (var i in resultProducts) {
      if (i.productCategory == category) {
        filteredProducts.add(Products(
            inGameStatus: i.inGameStatus,
            pingWithCron: i.pingWithCron,
            productAvengerDirect: i.productAvengerDirect,
            productImageUrl: i.productImageUrl,
            productCategory: i.productCategory,
            productCategoryGroup: i.productCategoryGroup,
            productCoinEntitled: i.productCoinEntitled,
            productCountry: i.productCountry,
            productCreatedDatetime: i.productCreatedDatetime,
            productCurrency: i.productCurrency,
            productDesc: i.productDesc,
            productDownBy: i.productDownBy,
            productDownTime: i.productDownTime,
            productDownTimedAt: i.productDownTimedAt,
            productGrouping: i.productGrouping,
            productId: i.productId,
            productImageUrlGrey: i.productImageUrlGrey,
            productMainCommissionPercentage: i.productMainCommissionPercentage,
            productMaintenanceScheduled: i.productMaintenanceScheduled,
            productMaintenanceScheduledFrom: i.productMaintenanceScheduledFrom,
            productMaintenanceScheduledTo: i.productMaintenanceScheduledTo,
            productName: i.productName,
            productPercentage: i.productPercentage,
            productProvider: i.productProvider,
            termText: i.termText,
            productRewardEntitled: i.productRewardEntitled,
            productSelfCommissionPercentage: i.productSelfCommissionPercentage,
            productSequence: i.productSequence,
            productStatus: i.productStatus,
            productTest: i.productTest,
            productType: i.productType,
            productUpBy: i.productUpBy,
            productUpTime: i.productUpTime,
            productUpTimedAt: i.productUpTimedAt,
            productUplineCommissionPercentage:
                i.productUplineCommissionPercentage,
            termStatus: i.termStatus));

        // print(filteredProducts.c);
        for (var element in filteredProducts) {
          print(element.productCategory);
        }
      } else if (category.isEmpty) {
        filteredProducts.add(Products(
            inGameStatus: i.inGameStatus,
            pingWithCron: i.pingWithCron,
            productAvengerDirect: i.productAvengerDirect,
            productImageUrl: i.productImageUrl,
            productCategory: i.productCategory,
            productCategoryGroup: i.productCategoryGroup,
            productCoinEntitled: i.productCoinEntitled,
            productCountry: i.productCountry,
            productCreatedDatetime: i.productCreatedDatetime,
            productCurrency: i.productCurrency,
            productDesc: i.productDesc,
            productDownBy: i.productDownBy,
            productDownTime: i.productDownTime,
            productDownTimedAt: i.productDownTimedAt,
            productGrouping: i.productGrouping,
            productId: i.productId,
            productImageUrlGrey: i.productImageUrlGrey,
            productMainCommissionPercentage: i.productMainCommissionPercentage,
            productMaintenanceScheduled: i.productMaintenanceScheduled,
            productMaintenanceScheduledFrom: i.productMaintenanceScheduledFrom,
            productMaintenanceScheduledTo: i.productMaintenanceScheduledTo,
            productName: i.productName,
            productPercentage: i.productPercentage,
            productProvider: i.productProvider,
            termText: i.termText,
            productRewardEntitled: i.productRewardEntitled,
            productSelfCommissionPercentage: i.productSelfCommissionPercentage,
            productSequence: i.productSequence,
            productStatus: i.productStatus,
            productTest: i.productTest,
            productType: i.productType,
            productUpBy: i.productUpBy,
            productUpTime: i.productUpTime,
            productUpTimedAt: i.productUpTimedAt,
            productUplineCommissionPercentage:
                i.productUplineCommissionPercentage,
            termStatus: i.termStatus));

        // print(filteredProducts.c);
        for (var element in filteredProducts) {
          print(element.productCategory);
        }
      }
    }
  }

  Future<Result<Exception, ProductsModel>> getProducts() async {
    if (getToken().toString().isNotEmpty) {
      setState(() {
        isLoadingProducts = true;
      });
      try {
        final response = await http.post(
          Uri.parse('${memberBaseUrl}game/getProductList'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": await getToken(),
          },
          body: jsonEncode(<String, dynamic>{
            "data": {"language": "my"}
          }),
        );
        switch (response.statusCode) {
          case 200:
            setState(() {
              isLoadingProducts = false;
            });
            print("okkk ${response.statusCode}");

            final data = json.decode(response.body);
            ProductsModel p = ProductsModel.fromJson(data);
            print("ppp ${p.msg}");

            // var m=Products.fromJson(json)
            if (p.response!.products!.isNotEmpty) {
              for (var i in p.response!.products!) {
                print(i.productName);
                setState(() {
                  resultProducts.add(Products(
                      inGameStatus: i.inGameStatus,
                      pingWithCron: i.pingWithCron,
                      productAvengerDirect: i.productAvengerDirect,
                      productImageUrl: i.productImageUrl,
                      productCategory: i.productCategory,
                      productCategoryGroup: i.productCategoryGroup,
                      productCoinEntitled: i.productCoinEntitled,
                      productCountry: i.productCountry,
                      productCreatedDatetime: i.productCreatedDatetime,
                      productCurrency: i.productCurrency,
                      productDesc: i.productDesc,
                      productDownBy: i.productDownBy,
                      productDownTime: i.productDownTime,
                      productDownTimedAt: i.productDownTimedAt,
                      productGrouping: i.productGrouping,
                      productId: i.productId,
                      productImageUrlGrey: i.productImageUrlGrey,
                      productMainCommissionPercentage:
                          i.productMainCommissionPercentage,
                      productMaintenanceScheduled:
                          i.productMaintenanceScheduled,
                      productMaintenanceScheduledFrom:
                          i.productMaintenanceScheduledFrom,
                      productMaintenanceScheduledTo:
                          i.productMaintenanceScheduledTo,
                      productName: i.productName,
                      productPercentage: i.productPercentage,
                      productProvider: i.productProvider,
                      termText: i.termText,
                      productRewardEntitled: i.productRewardEntitled,
                      productSelfCommissionPercentage:
                          i.productSelfCommissionPercentage,
                      productSequence: i.productSequence,
                      productStatus: i.productStatus,
                      productTest: i.productTest,
                      productType: i.productType,
                      productUpBy: i.productUpBy,
                      productUpTime: i.productUpTime,
                      productUpTimedAt: i.productUpTimedAt,
                      productUplineCommissionPercentage:
                          i.productUplineCommissionPercentage,
                      termStatus: i.termStatus));
                });
              }
              setState(() {
                gProducts = resultProducts;
              });
            }

            print("ooo ${gProducts.first.productImageUrl}");
            // Navigator.pushNamed(context, web_otp_page,
            //     arguments: data['response']['authToken']);

            return Success(ProductsModel.fromJson(data));
          default:
            print(Exception(response.reasonPhrase));
            print("status code${response.statusCode}");
            final data = json.decode(response.body);
            //Interactive toast, set [isIgnoring] false.
            setState(() {
              isLoadingProducts = false;
            });
            CustomToast.customToast(context, "${data['msg']}");

            return Error(Exception(response.reasonPhrase));
        }
      } catch (e) {
        // catch all exceptions (not just SocketException)
        // 4. return Error here too

        CustomToast.customToast(context, e.toString());
        print(Error(Exception()));
        return Error(Exception("NOT OK"));
      }
    } else {
      CustomToast.customToast(context, "auth token is empty");
      print(Error(Exception()));
      return Error(Exception("NOT OK"));
    }
  }

  getSliderImages() async {
    setState(() {
      isLoadingGif = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}Banner/list'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await getToken(),

          // 'Authorization':
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            "language": "en",
            // "language": widget.data!['language'],
          }
        }),
      );
      switch (response1.statusCode) {
        case 200:
          setState(() {
            isLoadingGif = true;
          });
          Map<String, dynamic> data = json.decode(response1.body);
          for (var i in data['response']['banners']) {
            print(i['banner_url']);
            gifs.add(i['banner_url']);
          }
          // print(data['response']['banners'][0]['banner_url']);

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
  }

  @override
  void initState() {
    getSliderImages();
    // print('ttt ${LuckySharedPef.getAuthToken()}');
    getToken();
    // print(getToken());
    getProducts();
    getProfileInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getProducts();
    print('iii ${LuckySharedPef.getAuthToken()}');

    // final sw = MediaQuery.of(context).size.width;
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
            gifs.isNotEmpty
                ? BannerArea(gifs)
                : Center(child: CircularProgressIndicator()),
            SizedBox(height: 12),
            gProducts.isEmpty
                ? Center(child: CircularProgressIndicator())
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
                                          // Text(
                                          //   userModel!.memberUsername!,
                                          //   style: TextStyle(fontSize: 16),
                                          // ),
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
                                  // info(
                                  //     title: "Referral",
                                  //     value: userModel!.refMemberName!),
                                  // SizedBox(height: 10),
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
                                  sidebar(context)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 4,
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    silverGradient(
                                        "Popular Games ${currentPage + 1}", 32),
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
                                                    BorderRadius.circular(10)),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        InkWell(
                                          onTap: ((currentPage + 1) *
                                                      productsPerPage) <
                                                  gProducts.length
                                              ? nextPage
                                              : null,
                                          child: Container(
                                            height: 55,
                                            width: 55,
                                            child: Center(
                                                child:
                                                    Icon(Icons.navigate_next)),
                                            decoration: BoxDecoration(
                                                color: Color(0xff252A2D),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
                                  itemCount: gProducts.length,
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
                                                gProducts[index]
                                                        .productImageUrl ??
                                                    "https://scontent.flhe11-1.fna.fbcdn.net/v/t39.30808-1/291321322_378298201059895_267225053697338827_n.png?stp=dst-png_p120x120&_nc_cat=106&ccb=1-7&_nc_sid=dbb9e7&_nc_ohc=K04AqBLJi9oAX9_zEh4&_nc_ht=scontent.flhe11-1.fna&oh=00_AfAerzR76y4VCuovsw2gGXiskoTUMvRSL57Awb720voYcw&oe=6378128B",
                                                height: 200,
                                                width: 200,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),

                                          // CachedNetworkImage(
                                          //   imageUrl: gProducts[index +
                                          //           (currentPage * productsPerPage)]
                                          //       .productImageUrl!,
                                          //   placeholder: (context, url) =>
                                          //       CircularProgressIndicator(),
                                          //   errorWidget: (context, url, error) =>
                                          //       Icon(Icons.error),
                                          //   height: 200,
                                          //   width: 200,
                                          //   fit: BoxFit.contain,
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              gProducts[index].productName ??
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
                                              gProducts[index]
                                                      .productCategory ??
                                                  "no category",
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
                                            // Navigator.pushNamed(
                                            //   context,
                                            //   web_product_detail,
                                            // );
                                            Navigator.pushNamed(
                                                context, web_product_detail,
                                                arguments: gProducts[index]);
                                          }),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              ResponsiveVisibility(
                                visible: true,
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
                                                  gProducts[index +
                                                              (currentPage *
                                                                  productsPerPage)]
                                                          .productImageUrl ??
                                                      "https://scontent.flhe11-1.fna.fbcdn.net/v/t39.30808-1/291321322_378298201059895_267225053697338827_n.png?stp=dst-png_p120x120&_nc_cat=106&ccb=1-7&_nc_sid=dbb9e7&_nc_ohc=K04AqBLJi9oAX9_zEh4&_nc_ht=scontent.flhe11-1.fna&oh=00_AfAerzR76y4VCuovsw2gGXiskoTUMvRSL57Awb720voYcw&oe=6378128B",
                                                  height: 200,
                                                  width: 200,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),

                                            // CachedNetworkImage(
                                            //   imageUrl: gProducts[index +
                                            //           (currentPage * productsPerPage)]
                                            //       .productImageUrl!,
                                            //   placeholder: (context, url) =>
                                            //       CircularProgressIndicator(),
                                            //   errorWidget: (context, url, error) =>
                                            //       Icon(Icons.error),
                                            //   height: 200,
                                            //   width: 200,
                                            //   fit: BoxFit.contain,
                                            // ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                gProducts[index +
                                                            (currentPage *
                                                                productsPerPage)]
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
                                                gProducts[index +
                                                            (currentPage *
                                                                productsPerPage)]
                                                        .productCategory ??
                                                    "no category",
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
                                              // Navigator.pushNamed(
                                              //   context,
                                              //   web_product_detail,
                                              // );
                                              Navigator.pushNamed(
                                                  context, web_product_detail,
                                                  arguments: gProducts[index]);
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
                  ),
          ],
        ),
      ),
    );
  }

  Container sidebar(BuildContext context) {
    return Container(
      height: 400,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              ResponsiveWrapper.of(context).isLargerThan(MOBILE) ? 2 : 1,
        ),
        children: [
          selection(popular, 'popular', () {
            sIndex = 'popular';
            print(sIndex);
          }),
          selection(favourite, 'favourite', () {
            sIndex = 'favourite';
            print(sIndex);
          }),
          selection(LiveCasino, 'Live Casino', () {
            sIndex = 'casino';
            filterProducts("LIVECASINO");
            print(sIndex);
          }),
          selection(egame, 'Egame', () {
            sIndex = 'egame';
            filterProducts("EGAMES");
          }),
          selection(sport, 'Sport', () {
            sIndex = 'sport';
            filterProducts("SPORT");
          }),
          selection(lottery, 'Lottery', () {
            sIndex = 'lottery';
          }),
        ],
      ),
    );
  }

  GestureDetector selection(
      String image, String text, GestureTapCallback? onTap) {
    return GestureDetector(
      onTap: onTap!,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(image, height: 20, width: 20),
          ),
          silverGradientLight(
            "$text",
            18,
          ),
        ],
      ),
    );
  }
}

class coin_chips extends StatelessWidget {
  final String title;
  final String value;

  const coin_chips({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              // SizedBox(width: 5),
              Text(
                "$title",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        silverGradient("$value", 16),
        Image.asset(coin),
        // Container(),
      ],
    );
  }
}

class info extends StatelessWidget {
  final String title;
  final String value;
  const info({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "LID :",
          style: TextStyle(fontSize: 16),
        ),
        Text(
          "903",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
