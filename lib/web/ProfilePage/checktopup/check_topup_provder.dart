import 'dart:convert';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_toast.dart';
import 'package:flutter_application_lucky_town/utils/constants/api_constants.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/checktopup/checktopupmodel.dart';

import '../../../utils/db_services/share_pref.dart';

class CheckTopUpProvider extends ChangeNotifier {
  bool isloading = false;
  // bool isloadingbank = false;
  CheckTopUpModel ctopup = CheckTopUpModel();

  getchecktopUp(context) async {
    isloading = true;
    // ctopup = await checkTopUp(context);
    isloading = false;
    notifyListeners();
  }
}

// Future<CheckTopUpModel> checkTopUp(context) async {
//   CheckTopUpModel? bm;
//   try {
//     final response = await http.post(
//       Uri.parse('${memberBaseUrl}user/checkTopup'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         "Authorization": await um!.response!.authToken!,

//         // 'Authorization':
//       },
//       body: jsonEncode(<String, dynamic>{"data": {}}),
//     );
//     switch (response.statusCode) {
//       case 200:
//         Map<String, dynamic> data = await json.decode(response.body);
//         bm = CheckTopUpModel.fromJson(data);
//         print("OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
//         break;
//       case 201:
//         Map<String, dynamic> data = await json.decode(response.body);
//         bm = CheckTopUpModel.fromJson(data);
//         print("201");
//         break;
//       case 400:
//         Map<String, dynamic> data = await json.decode(response.body);
//         CustomToast.customToast(context, data['msg']);
//         print("OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
//         // sm = SelectCountryModel.fromJson(item);
//         break;
//       default:
//         Map<String, dynamic> data = await json.decode(response.body);
//         CustomToast.customToast(context, data['msg']);
//     }
//   } catch (e) {
//     print(e);

//     CustomToast.customToast(context, e.toString());
//   }
//   return bm!;
// }
