part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent {}

class AddContactEvent extends ContactEvent {
  final List<c.Contact> contacts;
  AddContactEvent({
    required this.contacts,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddContactEvent && listEquals(other.contacts, contacts);
  }

  @override
  int get hashCode => contacts.hashCode;

  @override
  String toString() => 'AddContactEvent(contacts: $contacts)';
}

class GetContactEvent extends ContactEvent {}
