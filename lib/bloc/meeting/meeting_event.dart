part of 'meeting_bloc.dart';

@immutable
abstract class MeetingEvent {}

class StreamAllMeetingEvent extends MeetingEvent {
  final DateTime? date;
  StreamAllMeetingEvent({
    this.date,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StreamAllMeetingEvent && other.date == date;
  }

  @override
  int get hashCode => date.hashCode;

  @override
  String toString() => 'StreamAllMeetingEvent(date: $date)';
}

class _AllMeetingEvent extends MeetingEvent {
  final Either<String, List<MeetingWithContact>> data;

  _AllMeetingEvent(
    this.data,
  );

  @override
  String toString() => '_AllMeetingEvent(data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _AllMeetingEvent && other.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}
