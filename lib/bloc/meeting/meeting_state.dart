part of 'meeting_bloc.dart';

@immutable
abstract class MeetingState {}

class MeetingInitial extends MeetingState {}

class MeetingLoading extends MeetingState {}

class MeetingError extends MeetingState {
  final String message;

  MeetingError(this.message);

  @override
  String toString() => 'MeetingError(message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MeetingError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class MeetingSuccess extends MeetingState {
  final List<MeetingWithContact> model;
  MeetingSuccess({required this.model});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MeetingSuccess && listEquals(other.model, model);
  }

  @override
  int get hashCode => model.hashCode;

  @override
  String toString() => 'MeetingSuccess(model: $model)';
}
