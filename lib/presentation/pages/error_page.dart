import 'package:flutter/material.dart';
import 'package:meetinc/presentation/components/big_tip.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BigTip(
        title: const Text('An error ocurred'),
        subtitle: const Text('This page is not available'),
        action: const Text('GO BACK'),
        actionCallback: () => Navigator.pop(context),
        icon: const Icon(Icons.error_outline),
      ),
    );
  }
}
