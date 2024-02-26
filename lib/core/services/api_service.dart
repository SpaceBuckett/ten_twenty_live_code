import 'package:dio/dio.dart';

class ApiService {
  final String _baseUrl = "https://newsapi.org";
  Future<Dio> launchDio({
    bool? isMultiform = false,
  }) async {
    // String accessToken =
    //     'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhNTliMjJjODFmY2I5ZTkxNDc1YzZhMThkMDk3NGE2ZSIsInN1YiI6IjY1YmJlNmViZDdjZDA2MDE3YjU0MmQzZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.nhqASXJuVAisfbDozb15ulYDx2bf7lKdBn6eIO3u5NQ';
    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    dio.options.headers['Content-Type'] =
        isMultiform == true ? 'multipart/form-data' : 'application/json';
    dio.options.headers["accept"] = 'application/json';
    // dio.options.headers["Authorization"] = 'Bearer $accessToken';

    dio.options.followRedirects = false;
    dio.options.validateStatus = (status) {
      if (status != null) {
        return status < 500;
      } else {
        return false;
      }
    };
    return dio;
  }

  Future<Response<dynamic>?> get({
    required String endPoint,
    Map<String, dynamic>? params,
  }) async {
    params = _addApiKeyToParams(params);
    try {
      Dio dio = await launchDio();
      final response = await dio.get(
        '$_baseUrl/$endPoint&apiKey=746056277f6d497d9120a5e2484bcfef',
        queryParameters: params,
      );
      return response;
    } catch (e) {
      return null;
    }
  }

  _addApiKeyToParams(Map<String, dynamic>? params) {
    if (params != null) {
      params['api_key'] = '746056277f6d497d9120a5e2484bcfef';
    }
    return params;
  }
}
