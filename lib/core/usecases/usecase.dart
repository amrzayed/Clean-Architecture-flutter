
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:learn/core/error/failure.dart';
import 'package:learn/features/number_trivia/domain/entities/number_trivia.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
class NoParams extends Equatable{}