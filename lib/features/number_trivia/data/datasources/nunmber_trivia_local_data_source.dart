import 'dart:convert';

import 'package:learn/core/error/exceptions.dart';
import 'package:learn/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:learn/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDataSource{
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const cachedNumberTrivia = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImp implements NumberTriviaLocalDataSource{
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImp({required this.sharedPreferences});

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(cachedNumberTrivia);
    if (jsonString != null){
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString(cachedNumberTrivia, json.encode(triviaToCache.toJson()));
  }
}