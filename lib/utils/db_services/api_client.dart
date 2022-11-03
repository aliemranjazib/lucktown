import 'package:dio/dio.dart';

import '../constants/api_constants.dart';

class ApiClient {
  final Dio _dio = Dio();
  Future<Response> registerUser() async {
    try {
      Response response =
          await _dio.post('$memberBaseUrl/user/register', //ENDPONT URL
              data: {
            {
              "data": {
                "username": "ali004",
                "phoneNumber": "1000000111111",
                "countryCode": "+60",
                "password": "123123123",
                "confirmPassword": "123123123",
                "refUsername": "paracha01",
                "countryId": 1
              }
            }
          } //REQUEST BODY
              // queryParameters: {'apikey': 'YOUR_API_KEY'}, //QUERY PARAMETERS
              );
      //returns the successful json object
      return response.data;
    } on DioError catch (e) {
      //returns the error object if there is
      return e.response!.data;
    }
  }
}
