import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/models/product_model.dart';
import 'package:flutter_application_lucky_town/utils/components/gradient_text.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/utils/db_services/share_pref.dart';
import 'package:flutter_application_lucky_town/widgets/banner.dart';
import 'package:flutter_application_lucky_town/widgets/menue_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'dart:convert';
import 'package:flutter_application_lucky_town/models/user_session_model.dart';

import 'package:flutter_application_lucky_town/web/web_signin.dart';
import 'package:http/http.dart' as http;
import '../utils/components/custom_toast.dart';
import '../utils/constants/api_constants.dart';
import 'dart:html';
import '../utils/components/small_button.dart';

List<Products> gProducts = [];
String homeAuthToken =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2Njc0NTIxOTYsImlzcyI6IiIsImV4cCI6MTY2NzUzODU5NiwidXNlclRva2VuIjoidndvWTdLTjVjeTNnYWprWkhpY2xPVjFlM2JHRnQyb1laaUNjTjRuclI4d2RYcmpQelZZTm9TSWtYOTZPdVpUaHVEeWlDQUhJSDFkajQ2dUg5bjl0WFdpdjNzcmpQMHZvVGRlWTVrTTQ2N3YxcmdDU1FiUDk5WEJobnVPTUpkRWJ3aE5SSDFHeWF3Y3paSXZSbjR3eFc0dUs2UXRub1ZkbkRuSWowZUN5TGdOQlE3V1pHQk83UmJTeXR2aWowdjdyQlIzZUloUU8iLCJ1c2VyVHlwZSI6Im1lbWJlciIsInVzZXJBdXRoIjoiUTE0aTZkVnFoTTI2S1daYldmbUt0WEc2ZXVXa3RqVTBwcDZHVXluOFg3M0lPY3l6MEZmTjdMUjRBZkoyazVmaTBRSkRtSU5OQkxmelJjTXdvZW1IdGgxQk9YZFdKNm9uTzVyOFFyMGdwOFFhSkV5UzBhTW5JZGFHR0VSMEJQYVBteXNQOUNNNFllR3pKTkFjWkxVMmdtdll1RU5hTkFoR0xUcmtSQkJzUFBJY2ZXc0lQcmJPWnlhVzJ5ZXF4MEpab1Q3am1mOHAifQ.S1bnOW3aOHeY9CeDknHTGkBRL8jZvxuD2PVUBVq2RyQ";

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
  int count = 8;

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
    setState(() {
      isLoadingProducts = true;
    });
    try {
      final response = await http.post(
        Uri.parse('${memberBaseUrl}game/getProductList'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": homeAuthToken,
        },
        body: jsonEncode(<String, dynamic>{
          "data": {"language": "ch"}
        }),
      );
      switch (response.statusCode) {
        case 200:
          setState(() {
            isLoadingProducts = true;
          });
          final data = json.decode(response.body);

          ProductsModel p = ProductsModel.fromJson(data);

          if (p.response!.products!.isNotEmpty) {
            for (var i in p.response!.products!) {
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
                  productMaintenanceScheduled: i.productMaintenanceScheduled,
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
            }
            setState(() {
              gProducts = resultProducts;
            });
          }

          print("ooo ${resultProducts.first.productImageUrl}");
          // Navigator.pushNamed(context, web_otp_page,
          //     arguments: data['response']['authToken']);

          return Success(ProductsModel.fromJson(data));
        default:
          print(Exception(response.reasonPhrase));
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
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${Exception("SOMETHING WENT WRONG")}")));
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
          "Authorization": homeAuthToken

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

  // getData() {
  //   getProducts().then((Result<Exception, ProductsModel> value) {
  //     value.
  //     print(value.)
  //   });
  // }

  @override
  void initState() {
    getSliderImages();
    getProducts();
    print('ttt ${LuckySharedPef.getAuthToken()}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getProducts();
    // final sw = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: resultProducts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  MenuBar(),
                  BannerArea(gifs),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          // height: 1048,
                          width: 200,
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(color: Color(0xff292929)),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          "kktt005a",
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
                                info(),
                                info(),
                                info(),
                                SizedBox(height: 10),
                                coin_chips(),
                                coin_chips(),
                                coin_chips(),
                                SizedBox(height: 30),

                                home_container(() {}),

                                SizedBox(height: 50),
                                Container(
                                  height: 400,
                                  child: GridView(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
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
                                )
                                // GridView.count(
                                //   crossAxisCount: 5,
                                //   children: [
                                //     selection(),
                                //     selection(),
                                //     selection(),
                                //     selection(),
                                //     selection(),
                                //   ],
                                // ),
                              ],
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
                                                  resultProducts.length
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
                              Container(
                                // width: double.infinity,
                                // height: 300,
                                // decoration: BoxDecoration(color: Color(0xff292929)),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  // padding: EdgeInsets.all(20),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisExtent: 385,
                                    crossAxisSpacing: 120,
                                    // mainAxisSpacing: 160,
                                  ),
                                  itemCount: productsPerPage,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    print(
                                        resultProducts[index].productImageUrl!);
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
                                                resultProducts[index]
                                                    .productImageUrl!,
                                                height: 200,
                                                width: 200,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),

                                          // CachedNetworkImage(
                                          //   imageUrl: resultProducts[index +
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
                                          Text(
                                            resultProducts[index +
                                                    (currentPage *
                                                        productsPerPage)]
                                                .productName!,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontFamily: gotham_light),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              resultProducts[index +
                                                      (currentPage *
                                                          productsPerPage)]
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
                                          home_container(() {
                                            // Navigator.pushNamed(
                                            //   context,
                                            //   web_product_detail,
                                            // );
                                            Navigator.pushNamed(
                                                context, web_product_detail,
                                                arguments:
                                                    resultProducts[index]);
                                          }),
                                        ],
                                      ),
                                    );
                                  },
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
  const coin_chips({
    Key? key,
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
                "Chips",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        silverGradient("THB 0.00 ", 16),
        Image.asset(coin),
        // Container(),
      ],
    );
  }
}

class info extends StatelessWidget {
  const info({
    Key? key,
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
