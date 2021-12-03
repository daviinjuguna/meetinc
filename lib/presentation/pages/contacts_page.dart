import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetinc/bloc/contact/contact_bloc.dart';
import 'package:meetinc/database/app_database.dart';
import 'package:meetinc/utils/const.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);
  static const route = "/dashboard/contacts";

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> _contact = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ContactBloc>(context).add(GetContactEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: BlocConsumer<ContactBloc, ContactState>(
        listener: (_, state) {
          if (state is ContactSuccess) {
            _contact = state.contacts;
          }
        },
        builder: (context, state) {
          if (state is Contactloading) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return ListView.separated(
            separatorBuilder: (_, __) => SizedBox(height: 10),
            itemCount: _contact.length,
            padding: EdgeInsets.all(10),
            itemBuilder: (_, i) => ListTile(
              leading: CircleAvatar(
                backgroundColor: strToColor(_contact[i].name),
                child: Text(_contact[i].name.substring(0, 1)),
              ),
              title: Text(_contact[i].name),
            ),
          );
        },
      ),
    );
  }
}
