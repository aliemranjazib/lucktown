import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/app_routes/app_routes.dart';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_toast.dart';
import 'dart:io';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/constants/api_constants.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/bankacounts/bank_model.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/bankacounts/bankprovider.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/currency_exchange.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/setting_page.dart';
import 'package:flutter_application_lucky_town/web_menue/Drawer.dart';
import 'package:flutter_application_lucky_town/web_menue/header.dart';
import 'package:provider/provider.dart';
import 'package:darq/darq.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_framework/responsive_framework.dart';

import '../../product_detail_page/all_game_transaction.dart';

class BankTopUpMainPage extends StatefulWidget {
  const BankTopUpMainPage({super.key});

  @override
  State<BankTopUpMainPage> createState() => _BankTopUpMainPageState();
}

class _BankTopUpMainPageState extends State<BankTopUpMainPage> {
  TextEditingController name = TextEditingController();
  String? selectedValue;
  TextEditingController number = TextEditingController();
  final formkey = GlobalKey<FormState>();
  List<BankModelResponseAccounts?> cc = [];
  bool isUploading = false;
  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List bb = [];

  Future requestTopUp(
      context, String bankId, String amount, String imageUrl) async {
    try {
      final response = await http.post(
        Uri.parse('${memberBaseUrl}user/requestTopUp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await um!.response!.authToken!,

          // 'Authorization':
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            "topUpAmount": "$amount",
            "topUpBankId": "$bankId",
            "imageUrl": "$imageUrl",
            "promo": ""
          }
        }),
      );
      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> data = await json.decode(response.body);
          CustomToast.customToast(context, data['msg']);

          break;
        case 400:
          Map<String, dynamic> data = await json.decode(response.body);
          CustomToast.customToast(context, data['msg']);
          // sm = SelectCountryModel.fromJson(item);
          break;
        default:
          Map<String, dynamic> data = await json.decode(response.body);
          CustomToast.customToast(context, data['msg']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future uploadTopUp(String imagedata) async {
    setState(() {
      isUploading = true;
    });
    try {
      final response = await http.post(
        Uri.parse('${memberBaseUrl}upload/topUpReceipt'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await um!.response!.authToken!,

          // 'Authorization':
        },
        body: jsonEncode(<String, dynamic>{
          "data": {"imageData": "$imagedata"}
        }),
      );
      switch (response.statusCode) {
        case 200:
          setState(() {
            isUploading = true;
          });
          Map<String, dynamic> data = await json.decode(response.body);
          print(data['return']['imgUrl']);
          CustomToast.customToast(context, data['msg']);
          requestTopUp(context, cc.first!.bankId!, number.text,
              data['return']['imgUrl']);
          setState(() {
            isUploading = false;
          });
          break;
        case 400:
          Map<String, dynamic> data = await json.decode(response.body);
          CustomToast.customToast(context, data['msg']);
          // sm = SelectCountryModel.fromJson(item);
          setState(() {
            isUploading = false;
          });
          break;
        default:
          Map<String, dynamic> data = await json.decode(response.body);
          CustomToast.customToast(context, data['msg']);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    final p = Provider.of<BankProvider>(context, listen: false);
    p.getBanks(context);

    // p.getExisitngBanks(context);
    super.initState();
  }

  FilePickerResult? pickedFile;
  pickImage() async {
    pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      try {
        setState(() {
          // final logoBase64 = pickedFile!.files.first.bytes;
          final file = pickedFile!.files.first.bytes;
          // print(logoBase64);
          print("pick  file${file}");
          // final bytes = file!.readAsBytesSync();
          String img64 = base64Encode(file!);
          String base64Image = img64;
          print("path ${base64Image}");
          if (base64Image.isNotEmpty) {
            uploadTopUp(base64Image);
          }
        });
      } catch (err) {
        print(err);
      }
    } else {
      print('No Image Selected');
    }
  }

  void chooseImage() async {}
  converty() async {
    final bytes = await File(images.first.path).readAsBytesSync();
    // String base64Image = "data:image/jpeg;base64," + base64Encode(bytes);
    print("img_pan : $bytes");
  }

  @override
  Widget build(BuildContext context) {
    final getBanks = Provider.of<BankProvider>(context);
    if (!getBanks.isloading) {
      getBanks.bm.response!.accounts = getBanks.bm.response!.accounts!
          .distinct((element) => element!.bankId!)
          .toList();
      for (var element in getBanks.bm.response!.accounts!) {
        print(element!.bankId);
      }
    }

    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            topbackbutton(context, RouteCon.profile_page),
            isUploading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: getBanks.isloading
                                ? Center(child: CircularProgressIndicator())
                                : DropdownButtonFormField(
                                    hint: const Text("choose bank"),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                    validator: (value) {
                                      if (value == null) {
                                        return "bank must be selected";
                                      }
                                      return null;
                                    },
                                    value: selectedValue,
                                    items: getBanks.bm.response!.accounts!
                                        .map((e) => DropdownMenuItem<String>(
                                            value: e!.bankId,
                                            child: Text(e.bankName!)))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value.toString();
                                        print(selectedValue);
                                        cc = getBanks.bm.response!.accounts!
                                            .where((element) =>
                                                element!.bankId ==
                                                selectedValue)
                                            .toList();
                                        print("bnabn ${cc.first!.accountName}");
                                      });
                                    }),
                          ),
                          SizedBox(height: 20),
                          cc.isEmpty
                              ? Container()
                              : Column(
                                  children: [
                                    selectedAccount(
                                        "BANK : ", cc.first!.bankName),
                                    selectedAccount("Account Name : ",
                                        cc.first!.accountName),
                                    selectedAccount("Account No. : ",
                                        cc.first!.accountNumber),
                                  ],
                                ),
                          SizedBox(height: 20),
                          CurrencyTextField(
                              title: "Topup Amount",
                              controller: number,
                              validate: (p0) {
                                if (p0!.isEmpty) {
                                  return "amount must enter";
                                }
                                return null;
                              },
                              hintText: "account number"),
                          SizedBox(height: 20),
                          PrimaryButton(
                              title: "SUBMIT",
                              loading: isUploading,
                              onPress: () {
                                if (formkey.currentState!.validate()) {
                                  pickImage();
                                }
                              },
                              width: double.infinity),
                        ],
                      ),
                    ),
                  )
          ],
        ));
  }

  Padding selectedAccount(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: kContainerBg,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(child: Text("$title")),
                Expanded(child: Text(value ?? "")),
                Expanded(flex: 2, child: Container()),
              ],
            ),
          )),
    );
  }
}
