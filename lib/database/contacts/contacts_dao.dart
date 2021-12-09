// ignore_for_file: avoid_print

import 'package:drift/drift.dart';
import 'package:meetinc/database/app_database.dart';
import 'package:meetinc/database/contacts/contacts.dart';

part 'contacts_dao.g.dart';

@DriftAccessor(tables: [Contacts])
class ContactsDao extends DatabaseAccessor<AppDatabase>
    with _$ContactsDaoMixin {
  ContactsDao(AppDatabase attachedDatabase) : super(attachedDatabase);

  Future<Contact> addContactsToDb(String name) => into(contacts)
          .insert(
            ContactsCompanion.insert(name: name),
            mode: InsertMode.insertOrIgnore,
          )
          .then((id) => Contact(id: id, name: name))
          .catchError((e, s) {
        print("ERROR INSERT CONTACT");
        print(e);
        print(s);
      });

  Future<List<Contact>> getContact({String? query}) =>
      (select(contacts)..where((tbl) => tbl.name.like("%${query ?? ""}%")))
          .get();
}
