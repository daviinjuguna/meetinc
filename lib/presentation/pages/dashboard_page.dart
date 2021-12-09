import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meetinc/bloc/meeting/meeting_bloc.dart';
import 'package:meetinc/models/meeting_with_contact.dart';
import 'package:meetinc/presentation/components/big_tip.dart';
import 'package:meetinc/presentation/pages/add_meeting_page.dart';
import 'package:meetinc/presentation/pages/contacts_page.dart';
import 'package:meetinc/presentation/pages/meeting_page.dart';
import 'package:meetinc/presentation/pages/settings_page.dart';

class DashBoardPage extends StatefulWidget {
  static const route = "/dashboard";

  const DashBoardPage({Key? key}) : super(key: key);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  // late final _meetingBloc=
  List<MeetingWithContact> _meetingWithContact = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MeetingBloc>(context).add(StreamAllMeetingEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     // crossAxisAlignment: CrossAxisAlignment.start,
      //     padding: EdgeInsets.zero,
      //     shrinkWrap: true,
      //     children: [
      //       DrawerHeader(
      //         child: Container(
      //           width: double.infinity,
      //           child: Text(
      //             "MEETINC",
      //             style: TextStyle(
      //               color: Theme.of(context).colorScheme.onPrimary,
      //             ),
      //           ),
      //         ),
      //         decoration:
      //         BoxDecoration(color: Theme.of(context).colorScheme.primary),
      //       ),
      //       // SizedBox(height: 20),
      //       ListTile(
      //         onTap: () => Navigator.of(context).pushNamed(MeetinPage.route),
      //         leading: Icon(
      //           Icons.meeting_room,
      //           color: Theme.of(context).colorScheme.primary,
      //         ),
      //         title: Text(
      //           "Meeting",
      //           style: TextStyle(
      //             color: Theme.of(context).colorScheme.primaryVariant,
      //           ),
      //         ),
      //       ),
      //       ListTile(
      //         onTap: () => Navigator.of(context).pushNamed(ContactsPage.route),
      //         leading: Icon(
      //           Icons.people,
      //           color: Theme.of(context).colorScheme.primary,
      //         ),
      //         title: Text(
      //           "Contacts",
      //           style: TextStyle(
      //             color: Theme.of(context).colorScheme.primaryVariant,
      //           ),
      //         ),
      //       ),
      //       ListTile(
      //         onTap: () => Navigator.of(context).pushNamed(SettingsPage.route),
      //         leading: Icon(
      //           Icons.settings,
      //           color: Theme.of(context).colorScheme.primary,
      //         ),
      //         title: Text(
      //           "Settings",
      //           style: TextStyle(
      //             color: Theme.of(context).colorScheme.primaryVariant,
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Scheduled Meeting",
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 10),
            BlocBuilder<MeetingBloc, MeetingState>(
              builder: (context, state) {
                if (state is MeetingSuccess) {
                  _meetingWithContact = state.model;
                  if (state.model.isEmpty) {
                    return BigTip(
                      icon: Icon(Icons.block),
                      title: Text("No meetings scheduled"),
                      action: Text("Click here to schedule meeting"),
                      actionCallback: () {
                        // print("Hello");
                        Navigator.of(context).pushNamed(AddMeetingPage.route);
                      },
                    );
                  }
                }

                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _meetingWithContact.length,
                  itemBuilder: (_, i) => Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(_meetingWithContact[i].meeting.title),
                      subtitle: Text(
                        DateFormat.yMMMEd()
                            .add_jm()
                            .format(_meetingWithContact[i].meeting.date),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
