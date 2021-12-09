import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart' as c;
import 'package:flutter/foundation.dart';
import 'package:meetinc/database/app_database.dart';
import 'package:meetinc/repo/repository.dart';
import 'package:meta/meta.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactInitial()) {
    on<AddContactEvent>((event, emit) async {
      emit(Contactloading());
      final _res = await Repository().addContactsToDb(
        event.contacts
            .map((e) => e.displayName ?? e.givenName ?? e.familyName ?? "")
            .toList(),
      );
      emit(_res.fold(
        (error) => ContactError(error),
        (contacts) => ContactSuccess(contacts),
      ));
    });
    on<GetContactEvent>((event, emit) async {
      emit(Contactloading());
      final _res = await Repository().getContacts(query: event.query);
      emit(_res.fold(
        (error) => ContactError(error),
        (contacts) => ContactSuccess(contacts),
      ));
    });
  }
}
