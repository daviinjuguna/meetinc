import 'package:drift/drift.dart';

@DataClassName("Meeting")
class Meetings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 2, max: 32)();
  DateTimeColumn get date => dateTime().withDefault(Constant(DateTime.now()))();
}
