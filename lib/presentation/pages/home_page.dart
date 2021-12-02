import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetinc/bloc/contact/contact_bloc.dart';
import 'package:meetinc/presentation/pages/dashboard_page.dart';
import 'package:meetinc/presentation/widgets/snackbar.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const route = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // _askPermissions();
    BlocProvider.of<ContactBloc>(context).add(GetContactEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      //
      await ContactsService.getContacts().then((contacts) =>
          BlocProvider.of<ContactBloc>(context)
              .add(AddContactEvent(contacts: contacts)));
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      // final snackBar = SnackBar(content: Text('Access to contact data denied'));
      const _message = "Access to contact data denied";
      SnackBarWidget.errorSnackBar(context, _message);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      const _message = "Contact data not available on device";
      // final snackBar =
      //     SnackBar(content: Text('Contact data not available on device'));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      SnackBarWidget.errorSnackBar(context, _message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state is ContactSuccess) {
            if (state.contacts.isEmpty) {
              _askPermissions();
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                DashBoardPage.route,
                (route) => false,
              );
              print("I guess I kinda like the way you made me escape");
            }
          }
        },
        builder: (context, state) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }
}
