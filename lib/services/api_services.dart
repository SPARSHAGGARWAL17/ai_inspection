import 'package:dio/dio.dart';

class ApiServices {
  late final Dio _dio;
  ApiServices() {
    _dio = Dio();
  }

  Future<bool> generateReport() async {
    return false;
    // try {
    //   final response = await _dio.request('https://n8n.srv969344.hstgr.cloud/webhook/crs-report-trigger', options: Options(method: 'GET'));
    //   if (response.statusCode == 200) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // } catch (e) {
    //   return false;
    // }
  }
}
