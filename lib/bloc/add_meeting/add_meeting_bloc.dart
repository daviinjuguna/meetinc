import 'package:bloc/bloc.dart';
import 'package:meetinc/models/meeting_with_contact.dart';
import 'package:meetinc/repo/repository.dart';
import 'package:meta/meta.dart';

part 'add_meeting_event.dart';
part 'add_meeting_state.dart';

class AddMeetingBloc extends Bloc<AddMeetingEvent, AddMeetingState> {
  AddMeetingBloc() : super(AddMeetingInitial()) {
    on<StartAddMeetingEvent>((event, emit) async {
      emit(AddMeetingLoading());
      final _res = await Repository().createMeeting(
        title: event.meetingWithContact.meeting.title,
        date: event.meetingWithContact.meeting.date,
        contacts: event.meetingWithContact.contact,
      );
      emit(_res.fold(
        (l) => AddMeetingError(),
        (r) => AddMeetingSuccess(),
      ));
    });
  }
}
