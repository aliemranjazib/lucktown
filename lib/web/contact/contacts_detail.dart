import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_dialogue.dart';
import 'package:flutter_application_lucky_town/utils/components/gradient_text.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/currency_exchange.dart';
import 'package:flutter_application_lucky_town/web/product_detail_page/all_game_transaction.dart';
import 'package:flutter_application_lucky_town/web_menue/Drawer.dart';

class ContactsDetailPage extends StatelessWidget {
  TextEditingController amountC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            topbackbutton(context, web_contact_main_page),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(avatar),
                          SizedBox(width: 10),
                          Text("aaaaa"),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: kContainerBg,
                                  borderRadius: BorderRadius.circular(5)),
                              child: IconButton(
                                  onPressed: () {}, icon: Icon(Icons.edit))),
                          SizedBox(width: 10),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: kContainerBg,
                                borderRadius: BorderRadius.circular(5)),
                            child: IconButton(
                                onPressed: () {}, icon: Icon(Icons.delete)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  tile("Phone Number", "aaaaaa"),
                  SizedBox(height: 5),
                  tile("Available Transfer", "aaaaaa"),
                  SizedBox(height: 5),
                  tile("Transfer (THB)", "aaaaaa"),
                  SizedBox(height: 5),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                onTap: () {
                  print("OKKKKKKKKKKKKKKK");
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialog(
                        memberUniqueKey: "memberUniqueKey",
                        name: "aaaa",
                        amount: "aaaa",
                        avatar: "",
                      );
                    },
                  );
                },
                child: Container(
                  height: 60,
                  child: Center(
                      child: Text(
                    "Enter Amount  (THB)",
                    style: TextStyle(fontSize: 16),
                  )),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kContainerBg,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
              // child: EnterAmountTextField(
              //     title: "Enter Amount  (THB)",
              //     controller: amountC,
              //     hintText: "Enter Amount  (THB)    00"),
            ),
            SizedBox(height: 20),
          ],
        ));
  }

  Row tile(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title",
          style: TextStyle(fontSize: 14),
        ),
        Text(
          "$value",
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}

class EnterAmountTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validate;
  const EnterAmountTextField({
    Key? key,
    required this.title,
    required this.controller,
    this.validate,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: silverGradientRobto("$title", 16, FontWeight.normal)),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "$hintText",
            hintStyle: TextStyle(color: Colors.white),
            fillColor: kContainerBg,
            filled: true,
            border: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ],
    );
  }
}
