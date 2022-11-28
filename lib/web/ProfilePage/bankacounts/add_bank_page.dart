import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/setting_page.dart';
import 'package:flutter_application_lucky_town/web/product_detail_page/all_game_transaction.dart';
import 'package:provider/provider.dart';

import 'bankprovider.dart';

class AddBankPage extends StatefulWidget {
  const AddBankPage({super.key});

  @override
  State<AddBankPage> createState() => _AddBankPageState();
}

class _AddBankPageState extends State<AddBankPage> {
  String? selectedValue;
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    final p = Provider.of<BankProvider>(context, listen: false);
    p.getExisitngBanks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final getBanks = Provider.of<BankProvider>(context);

    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            topbackbutton(context, web_bank_acount_page),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: getBanks.isloadingbank
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
                              items: getBanks.ebm.response!.bankList!
                                  .map((e) => DropdownMenuItem<String>(
                                      value: e!.bank_id,
                                      child: Text(e.bank_name!)))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value.toString();
                                  print(selectedValue);
                                });
                              }),
                    ),
                    SizedBox(height: 20),
                    SettingTextField(
                        title: "account name",
                        controller: name,
                        hintText: "account name"),
                    SizedBox(height: 20),
                    SettingTextField(
                        title: "account number",
                        controller: number,
                        hintText: "account number"),
                    SizedBox(height: 20),
                    PrimaryButton(
                        title: "SUBMIT",
                        onPress: () {
                          if (formkey.currentState!.validate()) {
                            getBanks.addBank(context, selectedValue!,
                                number.text, name.text);
                          }
                        },
                        width: double.infinity)
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
