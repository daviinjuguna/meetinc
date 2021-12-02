import 'package:drift/drift.dart';

@DataClassName("Contact")
class Contacts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 2)();
}
