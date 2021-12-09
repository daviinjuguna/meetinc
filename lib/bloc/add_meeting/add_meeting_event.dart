part of 'add_meeting_bloc.dart';

@immutable
abstract class AddMeetingEvent {}

class StartAddMeetingEvent extends AddMeetingEvent {
  final MeetingWithContact meetingWithContact;

  StartAddMeetingEvent(this.meetingWithContact);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StartAddMeetingEvent &&
        other.meetingWithContact == meetingWithContact;
  }

  @override
  int get hashCode => meetingWithContact.hashCode;

  @override
  String toString() =>
      'StartAddMeetingEvent(meetingWithContact: $meetingWithContact)';
}
