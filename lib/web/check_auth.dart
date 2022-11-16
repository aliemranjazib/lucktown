import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:is_first_run/is_first_run.dart';

import '../utils/db_services/share_pref.dart';

class CheckAuth extends StatefulWidget {
  const CheckAuth({super.key});

  @override
  State<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  // Future<bool> isFirstTime() async {
  //   bool firstRun = await IsFirstRun.isFirstRun();
  //   return firstRun;
  // }

  decide() async {
    await LuckySharedPef.getAuthToken().toString().isEmpty
        ? Navigator.pushNamed(context, web_scaffold_page)
        : Navigator.pushNamed(context, web_home_Page);
  }

  @override
  void initState() {
    decide();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
