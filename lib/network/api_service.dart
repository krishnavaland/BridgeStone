import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/string_constants.dart';

class ApiProvider {

  static Future get(String url, {Map<String, dynamic>? queryParam}) async {
    var dio = Dio();
    var _response;
    print('get ki url++++$baseUrl$url');
    if (queryParam == null) {
      try {
        _response = await dio.get(
          '$baseUrl$url',
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
            // headers: {
            //   "Content-type": "application/json",
            //   "authorization": token,
            // },
          ),
        );
      } on DioError catch (e) {
        return {'status': e.response!.statusCode, 'body': e.response!.data};
      }
    } else {
      try {
        _response = await dio.get('$baseUrl$url', queryParameters: queryParam);

        print("printing _response");
        print(_response);
      } on DioError catch (e) {
        return {'status': e.response!.statusCode, 'body': e.response!.data};
      }
    }

    return {'status': _response.statusCode, 'body': _response.data};
  }

  static Future post({
    String? url,
    Map<String, dynamic> body = const {},
    String token = '',
  }) async {
    var dio = Dio();
    print('qwerty');
    print(url);
    print(body);

    var response = await dio.post(
      '$baseUrl$url',
      data: body,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        // headers: {
        //   "Content-type": "application/json",
        //   "Authorization": _token,
        // },
      ),
    );

    return {'status': response.statusCode, 'body': response.data};
  }

  static Future postForm({
    String? url,
    Map<String, dynamic> body = const {},
    String token = '',
  }) async {
    final pref = await SharedPreferences.getInstance();

    var dio = Dio();
    // FormData formData = FormData.fromMap(body);
    print('qwerty');
    print(url);
    FormData formData = FormData.fromMap(body);
    print(body);
    // if (!await Connection.isConnected()) {
    //   return {'status': 'No Connection', 'body': 'No Internet Connection'};
    // }
    String _token = pref.getString("token") ?? '';

    var _response = await dio.post(
      '$baseUrl$url',
      data: formData,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {
          "Content-type": "application/json",
          "authorization": _token,
        },
      ),
    );
    return {'status': _response.statusCode, 'body': _response.data};
  }

  static Future delete({
    String? url,
    Map<String, dynamic> body = const {},
    String token = '',
  }) async {
    final pref = await SharedPreferences.getInstance();
    String _token = pref.getString("token") ?? '';
    var dio = Dio();
    print('qwerty');
    print(url);
    print(body);
    var _response = await dio.delete(
      '$baseUrl$url',
      data: body,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {
          "Content-type": "application/json",
          "Authorization": _token,
        },
      ),
    );
    return {'status': _response.statusCode, 'body': _response.data};
  }
}
