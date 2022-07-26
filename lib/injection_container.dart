import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:learn/core/network/network_info.dart';
import 'package:learn/core/util/input_converter.dart';
import 'package:learn/core/web_services/cleint.dart';
import 'package:learn/features/number_trivia/data/datasources/nunmber_trivia_local_data_source.dart';
import 'package:learn/features/number_trivia/data/datasources/nunmber_trivia_remote_data_source.dart';
import 'package:learn/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:learn/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:learn/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:learn/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:learn/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async{
  // Bloc
  sl.registerFactory(
    () => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
      inputConverter: sl(),
    ),
  );

  // use case
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImp(
      sl(),
    ),
  );

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImp(
      sharedPreferences: sl(),
    ),
  );

  // core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoIpm(
      sl(),
    ),
  );

  sl.registerLazySingleton(
    () => InputConverter(),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => ClientBase());
  // sl.registerLazySingleton(() => BaseOptions());
  // sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
