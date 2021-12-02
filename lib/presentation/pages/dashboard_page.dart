import 'package:flutter/material.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              child: Text(
                "MEETINC",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.primary),
            )
          ],
        ),
      ),
    );
  }
}
