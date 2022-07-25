import 'package:dio/dio.dart';
import 'package:learn/core/constats/strings.dart';
import 'package:learn/core/error/exceptions.dart';
import 'package:learn/features/number_trivia/data/models/number_trivia_model.dart';
import 'dart:convert';

class Client {
  late Dio _dio;

  Client() {
    BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 30 * 1000,
        receiveTimeout: 60 * 1000);
    _dio = Dio(options);
  }

  Future<NumberTriviaModel> getNumberTriviaResponse(String url) async {
    Response response = await _dio.get(
      url,
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.data));
    } else {
      throw ServerException();
    }
  }
}
