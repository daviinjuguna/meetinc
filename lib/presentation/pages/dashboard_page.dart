import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: Drawer(
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            DrawerHeader(
              child: Container(
                width: double.infinity,
                child: Text(
                  "MEETINC",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.primary),
            ),
            // SizedBox(height: 20),
            ListTile(
              onTap: () => Navigator.of(context).pushNamed(MeetinPage.route),
              leading: Icon(
                Icons.meeting_room,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                "Meeting",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primaryVariant,
                ),
              ),
            ),
            ListTile(
              onTap: () => Navigator.of(context).pushNamed(ContactsPage.route),
              leading: Icon(
                Icons.people,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                "Contacts",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primaryVariant,
                ),
              ),
            ),
            ListTile(
              onTap: () => Navigator.of(context).pushNamed(SettingsPage.route),
              leading: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                "Settings",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primaryVariant,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
