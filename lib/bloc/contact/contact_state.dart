part of 'contact_bloc.dart';

@immutable
abstract class ContactState {}

class ContactInitial extends ContactState {}

class Contactloading extends ContactState {}

class ContactError extends ContactState {
  final String message;

  ContactError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'ContactError(message: $message)';
}

class ContactSuccess extends ContactState {
  final List<Contact> contacts;

  ContactSuccess(
    this.contacts,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactSuccess && listEquals(other.contacts, contacts);
  }

  @override
  int get hashCode => contacts.hashCode;

  @override
  String toString() => 'ContactSuccess(contacts: $contacts)';
}
