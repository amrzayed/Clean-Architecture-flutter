import 'package:dartz/dartz.dart';
import 'package:learn/core/error/failure.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedIntegers(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw const FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
