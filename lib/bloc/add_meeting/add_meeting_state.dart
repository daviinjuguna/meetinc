part of 'add_meeting_bloc.dart';

@immutable
abstract class AddMeetingState {}

class AddMeetingInitial extends AddMeetingState {}

class AddMeetingLoading extends AddMeetingState {}

class AddMeetingSuccess extends AddMeetingState {}

class AddMeetingError extends AddMeetingState {}
