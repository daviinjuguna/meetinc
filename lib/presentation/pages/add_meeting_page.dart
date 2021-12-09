import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meetinc/bloc/add_meeting/add_meeting_bloc.dart';
import 'package:meetinc/database/app_database.dart';
import 'package:meetinc/models/meeting_with_contact.dart';
import 'package:meetinc/presentation/pages/add_contacts.dart';
import 'package:meetinc/presentation/widgets/snackbar.dart';
import 'package:meetinc/presentation/widgets/textfield_container.dart';
import 'package:meetinc/utils/const.dart';

class AddMeetingPage extends StatefulWidget {
  AddMeetingPage({Key? key}) : super(key: key);
  static const route = "/add_meeting";

  @override
  _AddMeetingPageState createState() => _AddMeetingPageState();
}

class _AddMeetingPageState extends State<AddMeetingPage> {
  late final _defaultFormat = DateFormat.yMMMEd().add_jm();
  late final _nameController = TextEditingController();
  late TextEditingController _dateController = TextEditingController();
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddMeetingBloc, AddMeetingState>(
          listener: (context, state) {
            if (state is AddMeetingLoading) {
              SnackBarWidget.loadingSnackBar(context);
            }
            if (state is AddMeetingSuccess) {
              SnackBarWidget.successSnackBar(context, "Added");
              Navigator.pop(context);
            }
            if (state is AddMeetingError) {
              SnackBarWidget.errorSnackBar(context, "fail to add");
            }
          },
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add meeting"),
        ),
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            SizedBox(height: 10),
            Text("Name"),
            SizedBox(height: 5),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),                contentPadding: EdgeInsets.all(8),
              ),
            ),
            SizedBox(height: 10),
            Text("Date"),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    enabled: false,
                    controller: _dateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final _date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (_date != null) {
                      final _dateTime =
                          DateTime(_date.year, _date.month, _date.day);

                      print(_defaultFormat.format(_dateTime));
                      setState(() {
                        // _endDateTime = _dateTime;
                        _dateController = TextEditingController(
                          text: _defaultFormat.format(_dateTime),
                        );
                      });
                    }
                  },
                  icon: Icon(Icons.calendar_today),
                  color: Theme.of(context).colorScheme.primary,
                )
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context)
                      .push<List<Contact>>(MaterialPageRoute(
                          builder: (builder) => AddContactsPage()))
                      .then((value) {
                    if (value != null) {
                      setState(() {
                        _contacts = value;
                      });
                    }
                  });
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
            SizedBox(height: 20),
            if (_contacts.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Selected Contacts"),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => SizedBox(height: 10),
                    itemCount: _contacts.length,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (_, i) => ListTile(
                      leading: CircleAvatar(
                        backgroundColor: strToColor(_contacts[i].name),
                        child: Text(_contacts[i].name.substring(0, 1)),
                      ),
                      title: Text(_contacts[i].name),
                    ),
                  )
                ],
              ),
            SizedBox(height: 50),
            Center(
              child: MaterialButton(
                onPressed: () {
                  if (_nameController.text.isNotEmpty ||
                      _dateController.text.isNotEmpty) {
                    BlocProvider.of<AddMeetingBloc>(context).add(
                      StartAddMeetingEvent(MeetingWithContact(
                        meeting: Meeting(
                          title: _nameController.text,
                          id: 0,
                          date: _defaultFormat.parse(_dateController.text),
                        ),
                        contact: _contacts,
                      )),
                    );
                    return;
                  }
                  SnackBarWidget.errorSnackBar(context, "Please add name and/or date");
                },
                child: Text(
                  "Add meeting",
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
