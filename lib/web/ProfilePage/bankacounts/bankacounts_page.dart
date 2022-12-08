import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/app_routes/app_routes.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/bankacounts/bank_model.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/bankacounts/bankprovider.dart';
import 'package:flutter_application_lucky_town/web/product_detail_page/all_game_transaction.dart';
import 'package:flutter_application_lucky_town/web_menue/Drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class BankAcountsPage extends StatefulWidget {
  const BankAcountsPage({super.key});

  @override
  State<BankAcountsPage> createState() => _BankAcountsPageState();
}

class _BankAcountsPageState extends State<BankAcountsPage> {
  @override
  void initState() {
    final p = Provider.of<BankProvider>(context, listen: false);
    p.getBanks(context);
    // p.getExisitngBanks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final getBanks = Provider.of<BankProvider>(context);

    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              topbackbutton(context),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(RouteCon.add_bank_acount_page);
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(color: kContainerBg),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text("+ Add Bank Account"),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "EXISTING BANK DETAIL",
                        style: TextStyle(fontSize: 20),
                      ),
                      getBanks.isloading
                          ? CircularProgressIndicator(
                              backgroundColor: Color(0xffBD8E37),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xffFCD877)),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  ...List.generate(
                                      getBanks.bm.response!.accounts!.length,
                                      (index) {
                                    final data =
                                        getBanks.bm.response!.accounts![index]!;
                                    return SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Image.network(
                                                data.bankIconUrl ??
                                                    "https://cdn-icons-png.flaticon.com/512/5347/5347826.png",
                                                height: 50,
                                                width: 50,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text("Bank Name :   "),
                                              Text(data.bankName!),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text("Bank Type   "),
                                              Text(data.bankType!),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text("Bank Country :   "),
                                              Text(data.bankCountry!),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text("Account name :   "),
                                              Text(data.accountName!),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text("Account Number :   "),
                                              Text(data.accountNumber!),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Row topbackbutton(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          color: Colors.black,
          child: Row(
            children: [
              BackButton(
                onPressed: () {
                  context.pop();

                  // Navigator.pushNamed(context, path);
                  // Navigator.pop(context);
                },
              ),
              ResponsiveVisibility(
                  visible: true,
                  hiddenWhen: const [Condition.smallerThan(name: TABLET)],
                  child: Text("Back"))
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Image.asset(
              logo,
              width: ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                  ? 202
                  : 101,
              height:
                  ResponsiveWrapper.of(context).isLargerThan(MOBILE) ? 62 : 31,
            ),
          ),
        ),
      ],
    );
  }
}
