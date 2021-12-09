// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:meetinc/presentation/pages/add_contacts.dart';
import 'package:meetinc/presentation/pages/add_meeting_page.dart';
import 'package:meetinc/presentation/pages/contacts_page.dart';
import 'package:meetinc/presentation/pages/dashboard_page.dart';
import 'package:meetinc/presentation/pages/error_page.dart';
import 'package:meetinc/presentation/pages/home_page.dart';
import 'package:meetinc/presentation/pages/meeting_page.dart';
import 'package:meetinc/presentation/pages/settings_page.dart';
import 'package:meetinc/presentation/widgets/responsive_page.dart';

class Routes {
  /// Methods that generate all routes
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    try {
      switch (routeSettings.name) {
        case HomePage.route:
          return ResponsivePageRoute(builder: (builder) => const HomePage());
        case DashBoardPage.route:
          return ResponsivePageRoute(
            builder: (builder) => const DashBoardPage(),
          );
        case MeetinPage.route:
          return ResponsivePageRoute(
            builder: (builder) => MeetinPage(),
          );
        case ContactsPage.route:
          return ResponsivePageRoute(
            builder: (builder) => ContactsPage(),
          );
        case SettingsPage.route:
          return ResponsivePageRoute(
            builder: (builder) => SettingsPage(),
          );
        case AddMeetingPage.route:
          return ResponsivePageRoute(
            builder: (builder) => AddMeetingPage(),
          );
        case AddContactsPage.route:
          return ResponsivePageRoute(builder: (builder) => ContactsPage());
        default:
          return errorRoute(routeSettings);
      }
    } catch (e, s) {
      print(e);
      print(s);
      return errorRoute(routeSettings);
    }
  }

  /// Method that calles the error screen when neccesary
  static Route<dynamic> errorRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (_) => const ErrorPage(),
    );
  }
}

class ResponsivePageRoute extends PageRouteBuilder {
  ResponsivePageRoute({
    RouteSettings? settings,
    required WidgetBuilder builder,
    Color barrierColor = const Color(0x80000000),
    Duration transitionDuration = const Duration(milliseconds: 200),
    Curve transitionCurve = Curves.linear,
  }) : super(
          settings: settings,
          pageBuilder: (context, animation, _) => FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: transitionCurve,
            ),
            child: ResponsivePage(child: builder(context)),
          ),
          transitionDuration: transitionDuration,
          reverseTransitionDuration: transitionDuration,
          opaque: false,
          barrierDismissible: true,
          barrierColor: barrierColor,
          fullscreenDialog: true,
        );
}
