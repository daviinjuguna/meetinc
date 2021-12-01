import 'package:meetinc/database/app_database.dart';
import 'package:meetinc/database/contacts/contacts.dart';
import 'package:drift/drift.dart';

part 'contacts_dao.g.dart';

@DriftAccessor(tables: [Contacts])
class ContactsDao extends DatabaseAccessor<AppDatabase>
    with _$ContactsDaoMixin {
  ContactsDao(AppDatabase attachedDatabase) : super(attachedDatabase);
}
