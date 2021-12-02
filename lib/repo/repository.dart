// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:meetinc/database/app_database.dart';
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

  Future<Either<String, List<Contact>>> getContacts() async {
    try {
      return right(await _appDb.contactsDao.getContact());
    } catch (e, s) {
      print(s);
      return left(e.toString());
    }
  }
}
