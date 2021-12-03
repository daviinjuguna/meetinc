import 'package:flutter/material.dart';

class MeetinPage extends StatefulWidget {
  MeetinPage({Key? key}) : super(key: key);
  static const route = "/dashboard/meeting";

  @override
  _MeetinPageState createState() => _MeetinPageState();
}

class _MeetinPageState extends State<MeetinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meeting"),
      ),
    );
  }
}
