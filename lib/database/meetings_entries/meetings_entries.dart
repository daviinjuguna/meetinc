import 'package:drift/drift.dart';

@DataClassName("MeetingEntry")
class MeetingsEntries extends Table {
  // id of the meeting that should contain this contact.
  IntColumn get meeting => integer()();
  // id of the contact in this meeting
  IntColumn get contact => integer()();
}
