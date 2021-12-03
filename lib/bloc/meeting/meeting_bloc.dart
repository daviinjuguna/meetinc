import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:meetinc/models/meeting_with_contact.dart';
import 'package:meetinc/repo/repository.dart';
import 'package:meta/meta.dart';

part 'meeting_event.dart';
part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  MeetingBloc() : super(MeetingInitial()) {
    on<StreamAllMeetingEvent>((event, emit) async {
      await emit.onEach<Either<String, List<MeetingWithContact>>>(
        Repository().watchAllMeerng(date: event.date),
        onData: (data) => add(_AllMeetingEvent(data)),
        onError: (obj, stack) {
          print(obj);
          print(stack);
          emit(MeetingError(obj.toString()));
        },
      );
    });
    on<_AllMeetingEvent>(
      (event, emit) => emit(
        event.data.fold(
          (l) => MeetingError(l),
          (r) => MeetingSuccess(model: r),
        ),
      ),
    );
  }
}
