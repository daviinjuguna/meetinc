import 'package:flutter/foundation.dart';

import 'package:meetinc/database/app_database.dart';

class MeetingWithContact {
  final Meeting meeting;
  final List<Contact> contact;

  MeetingWithContact({
    required this.meeting,
    required this.contact,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MeetingWithContact &&
        other.meeting == meeting &&
        listEquals(other.contact, contact);
  }

  @override
  int get hashCode => meeting.hashCode ^ contact.hashCode;

  MeetingWithContact copyWith({
    Meeting? meeting,
    List<Contact>? contact,
  }) {
    return MeetingWithContact(
      meeting: meeting ?? this.meeting,
      contact: contact ?? this.contact,
    );
  }

  @override
  String toString() =>
      'MeetingWithContact(meeting: $meeting, contact: $contact)';
}
