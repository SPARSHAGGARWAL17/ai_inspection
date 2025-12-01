import 'package:dio/dio.dart';

class ApiServices {
  late final Dio _dio;
  ApiServices() {
    _dio = Dio();
  }

  Future<bool> generateReport() async {
    try {
      final response = await _dio.request('https://n8n.srv969344.hstgr.cloud/webhook/generate-report', options: Options(method: 'POST'), data: {
        "action": "start",
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
