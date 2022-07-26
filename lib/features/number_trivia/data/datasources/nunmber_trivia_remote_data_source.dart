
import 'package:dio/dio.dart';
import 'package:learn/core/constats/strings.dart';
import 'package:learn/core/web_services/cleint.dart';
import 'package:learn/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:learn/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRemoteDataSource{
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImp implements NumberTriviaRemoteDataSource{
  final ClientBase _client;

  NumberTriviaRemoteDataSourceImp(this._client);

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async{
    NumberTriviaModel triviaModel = await _client.getNumberTriviaResponse(number.toString());
    return triviaModel;
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async{
    NumberTriviaModel triviaModel = await _client.getNumberTriviaResponse(randomTrivia);
    return triviaModel;
  }

}