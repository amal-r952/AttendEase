import 'package:dio/dio.dart';
import 'package:attendance_tracker/src/utils/constants.dart';
import 'package:attendance_tracker/src/utils/object_factory.dart';

class ApiClient {
  Future<Response> getCurrencyRates({required String currencyCode}) {
    return ObjectFactory().appDio.get(
        url:
            "https://api.freecurrencyapi.com/v1/latest?apikey=${Constants.currencyApiKey}&currencies=$currencyCode&base_currency=INR");
  }
}
