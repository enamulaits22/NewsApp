import 'package:dio/dio.dart';
import 'package:news_app/config/utils/constants.dart';

class BaseHttpClient {
  final _client = Dio();

  static String get baseURL {
    return Constants.baseUrl;
  }

  Dio get client {
    _client.options.baseUrl = baseURL;
    _client.options.headers = {
      'Accept': 'application/json',
    };
    return _client;
  }

  Dio get authenticatedClient {
    final httpClient = client;
    String token = Constants.apiKey;
    httpClient.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    return httpClient;
  }
}
