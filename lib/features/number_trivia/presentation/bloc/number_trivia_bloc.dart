import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learn/features/number_trivia/domain/entities/number_trivia.dart';

part 'number_trivia_event.dart';

part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc() : super(NumberTriviaInitial()) {
    on<NumberTriviaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  @override
  // TODO: implement initialState
  NumberTriviaState get initialState => throw UnimplementedError();

  @override
  Stream<NumberTriviaState> mapEventToState(NumberTriviaEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
