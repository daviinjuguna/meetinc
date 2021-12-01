// ignore_for_file: avoid_print

import 'package:meetinc/database/app_database.dart';
import 'package:meetinc/database/meetings/meetings.dart';
import 'package:drift/drift.dart';
import 'package:meetinc/database/meetings_entries/meetings_entries.dart';
import 'package:meetinc/models/meeting_with_contact.dart';
import 'package:rxdart/rxdart.dart';

part 'meetings_dao.g.dart';

@DriftAccessor(tables: [Meetings, MeetingsEntries])
class MeetingsDao extends DatabaseAccessor<AppDatabase>
    with _$MeetingsDaoMixin {
  MeetingsDao(AppDatabase attachedDatabase) : super(attachedDatabase);

  Future<MeetingWithContact> createEmptyMeeting(
          {required String title, required DateTime date}) =>
      into(meetings)
          .insert(MeetingsCompanion.insert(
        title: title,
        date: Value.ofNullable(date),
      ))
          .then((id) {
        final _meeting = Meeting(id: id, title: title, date: date);
        return MeetingWithContact(meeting: _meeting, contact: []);
      }).onError((error, stackTrace) {
        print("ERROR CREATE MEETING: $error,$stackTrace");
        throw Exception();
      });

  Future<void> writeMeeting(MeetingWithContact entry) => transaction(() async {
        final _meeting = entry.meeting;

        //we add meeting
        await into(meetings).insert(_meeting, mode: InsertMode.replace);

        //replace entries
        await (delete(meetingsEntries)
              ..where((tbl) => tbl.meeting.equals(_meeting.id)))
            .go();

        //add new contacts
        for (final contact in entry.contact) {
          await into(meetingsEntries).insert(MeetingsEntriesCompanion.insert(
              meeting: _meeting.id, contact: contact.id));
        }
      });

  // Stream<MeetingWithContact> watchMeeting(int id) {}
}
