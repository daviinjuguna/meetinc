// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:meetinc/database/app_database.dart';
import 'package:meetinc/models/meeting_with_contact.dart';
import 'package:rxdart/rxdart.dart';

class Repository {
  final _appDb = AppDatabase();

  Future<Either<String, List<Contact>>> addContactsToDb(
      List<String> names) async {
    try {
      List<Contact> _contacts = [];
      for (String name in names) {
        final _contact = await _appDb.contactsDao.addContactsToDb(name);
        _contacts.add(_contact);
      }

      return right(_contacts);
    } catch (e, s) {
      print(s);
      return left(e.toString());
    }
  }

  Future<Either<String, List<Contact>>> getContacts({String? query}) async {
    try {
      return right(await _appDb.contactsDao.getContact(query: query));
    } catch (e, s) {
      print(s);
      return left(e.toString());
    }
  }

  Stream<Either<String, MeetingWithContact>> watchSingleMeeting(int id) async* {
    yield* _appDb.meetingsDao
        .watchMeeting(id)
        .map((meetingWithContact) =>
            right<String, MeetingWithContact>(meetingWithContact))
        .onErrorReturnWith(
          (error, stackTrace) => left<String, MeetingWithContact>("Error"),
        );
  }

  Stream<Either<String, List<MeetingWithContact>>> watchAllMeerng(
      {DateTime? date}) async* {
    yield* _appDb.meetingsDao
        .watchAllMeetings(date: date)
        .map((meetingWithContact) =>
            right<String, List<MeetingWithContact>>(meetingWithContact))
        .onErrorReturnWith(
          (error, stackTrace) =>
              left<String, List<MeetingWithContact>>("Error"),
        );
  }

  Future<Either<String, MeetingWithContact>> createMeeting({
    required String title,
    required DateTime date,
    List<Contact> contacts = const [],
  }) async {
    try {
      return right(await _appDb.meetingsDao
          .createEmptyMeeting(title: title, date: date, contacts: contacts));
    } catch (e, s) {
      print(s);
      return left(e.toString());
    }
  }

  Future<Either<String, String>> addContactsToMeeting(
    MeetingWithContact meetingWithContact,
  ) async {
    try {
      await _appDb.meetingsDao.writeMeeting(meetingWithContact);
      return right("Success");
    } catch (e, s) {
      print(s);
      return left(e.toString());
    }
  }
}
