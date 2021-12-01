import 'package:drift/native.dart';
import 'package:meetinc/database/contacts/contacts.dart';
import 'package:meetinc/database/contacts/contacts_dao.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'dart:io';

import 'meetings/meetings.dart';
import 'meetings/meetings_dao.dart';
import 'meetings_entries/meetings_entries.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Meetings, Contacts, MeetingsEntries],
  daos: [MeetingsDao, ContactsDao],
  queries: {},
  include: {},
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection()) {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (detailt) async =>
            await customStatement('PRAGMA foreign_keys = ON'),
        onCreate: (m) {
          return m.createAll();
        },
      );
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file, logStatements: true);
  });
}
