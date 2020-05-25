import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reviews_event.dart';
part 'reviews_state.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  @override
  ReviewsState get initialState => ReviewsInitial();

  @override
  Stream<ReviewsState> mapEventToState(
    ReviewsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}