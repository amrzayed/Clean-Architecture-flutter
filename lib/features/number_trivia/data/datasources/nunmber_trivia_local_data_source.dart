import 'package:learn/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:learn/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaLocalDataSource{
  Future<NumberTrivia> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTrivia triviaToCache);
}