import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetinc/bloc/contact/contact_bloc.dart';
import 'package:meetinc/database/app_database.dart';
import 'package:meetinc/utils/const.dart';
import 'package:meetinc/utils/debouncer.dart';

class AddContactsPage extends StatefulWidget {
  const AddContactsPage({Key? key}) : super(key: key);
  static const route = "/add_contacts";

  @override
  _AddContactsPageState createState() => _AddContactsPageState();
}

class _AddContactsPageState extends State<AddContactsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ContactBloc>(context).add(GetContactEvent());
  }

  List<Contact> _contacts = [];
  List<Contact> _selectedContacts = [];
  late final _debouncer = Debouncer(milliseconds: 500);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.zero,
          child: TextField(
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
            onChanged: (value) {
              _debouncer.run(
                action: () => {
                  BlocProvider.of<ContactBloc>(context)
                      .add(GetContactEvent(query: value))
                },
              );
            },
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white24,
              hintText: "Search Contacts",
              errorStyle: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Colors.red),
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ),
      ),
      body: BlocConsumer<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state is ContactSuccess) {
            _contacts = state.contacts;
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: state is Contactloading
                    ? Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : _contacts.isEmpty
                        ? Container()
                        : ListView.builder(
                            itemCount: _contacts.length,
                            itemBuilder: (_, i) {
                              final _isSelected =
                                  _selectedContacts.contains(_contacts[i]);
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      strToColor(_contacts[i].name),
                                  child:
                                      Text(_contacts[i].name.substring(0, 1)),
                                ),
                                title: Text(_contacts[i].name),
                                onTap: () {
                                  if (_isSelected) {
                                    setState(() {
                                      _selectedContacts.remove(_contacts[i]);
                                    });
                                  } else {
                                    setState(() {
                                      _selectedContacts.add(_contacts[i]);
                                    });
                                  }
                                },
                                tileColor: _isSelected
                                    ? Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.1)
                                    : null,
                              );
                            },
                          ),
              ),
              Center(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(_selectedContacts);
                  },
                  child: Text(
                    "Add contacts",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
