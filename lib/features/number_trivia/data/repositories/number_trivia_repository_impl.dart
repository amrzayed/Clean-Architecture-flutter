import 'package:dartz/dartz.dart';
import 'package:learn/core/error/exceptions.dart';
import 'package:learn/core/error/failure.dart';
import 'package:learn/core/network/network_info.dart';
import 'package:learn/features/number_trivia/data/datasources/nunmber_trivia_local_data_source.dart';
import 'package:learn/features/number_trivia/data/datasources/nunmber_trivia_remote_data_source.dart';
import 'package:learn/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:learn/features/number_trivia/domain/repositories/number_trivia_repository.dart';

typedef _ConcreteOrRandomChooser = Future<NumberTrivia> Function();
class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number,) async{
    return await _getTrivia(() => remoteDataSource.getConcreteNumberTrivia(number));
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async{
    return await _getTrivia(() => remoteDataSource.getRandomNumberTrivia());
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(_ConcreteOrRandomChooser getConcreteOrRandom) async{
    if (await networkInfo.isConnected){
      try{
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    }else{
      try{
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException{
        return Left(CacheFailure());
      }
    }
  }
}
