// ignore_for_file: avoid_print

import 'package:meetinc/database/app_database.dart';
import 'package:meetinc/database/contacts/contacts.dart';
import 'package:meetinc/database/meetings/meetings.dart';
import 'package:drift/drift.dart';
import 'package:meetinc/database/meetings_entries/meetings_entries.dart';
import 'package:meetinc/models/meeting_with_contact.dart';
import 'package:rxdart/rxdart.dart';

part 'meetings_dao.g.dart';

@DriftAccessor(tables: [Meetings, MeetingsEntries, Contacts])
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
      }).catchError((error, stackTrace) {
        print("ERROR CREATE MEETING\n$error\n$stackTrace");
        // throw Exception();
      });

//#Add contacts to meetings
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

  Stream<MeetingWithContact> watchMeeting(int id) {
    final _meetingQuery = select(meetings)..where((tbl) => tbl.id.equals(id));
    final _contentQuery = select(meetingsEntries).join([
      innerJoin(
        contacts,
        contacts.id.equalsExp(meetingsEntries.contact),
      )
    ])
      ..where(meetingsEntries.meeting.equals(id));

    final _meetingStream = _meetingQuery.watchSingle();
    final _contentStream = _contentQuery
        .watch()
        .map((rows) => rows.map((e) => e.readTable(contacts)).toList());

    return Rx.combineLatest2(
      _meetingStream,
      _contentStream,
      (Meeting meeting, List<Contact> contact) =>
          MeetingWithContact(meeting: meeting, contact: contact),
    );
  }

  Stream<List<MeetingWithContact>> watchAllMeetings({DateTime? date}) {
    Stream<List<Meeting>> _meetingStream = select(meetings).watch();
    if (date != null) {
      _meetingStream = (select(meetings)
            ..where((tbl) => tbl.date.day.equals(date.day)))
          .watch();
    }

    return _meetingStream.switchMap((meetings) {
      final _idToMeeting = {
        for (final meeting in meetings) meeting.id: meeting
      };
      final _ids = _idToMeeting.keys;

      final _contentQuery = select(meetingsEntries).join([
        innerJoin(
          contacts,
          contacts.id.equalsExp(meetingsEntries.contact),
        )
      ])
        ..where(meetingsEntries.meeting.isIn(_ids));

      return _contentQuery.watch().map((rows) {
        final _idToContact = <int, List<Contact>>{};

        for (final row in rows) {
          final _contact = row.readTable(contacts);
          final _id = row.readTable(meetingsEntries).contact;

          _idToContact.putIfAbsent(_id, () => []).add(_contact);
        }

        return [
          for (final id in _ids)
            MeetingWithContact(
              meeting: _idToMeeting[id]!,
              contact: _idToContact[id] ?? [],
            ),
        ];
      });
    });
  }
}
