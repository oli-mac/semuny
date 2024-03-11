import 'package:flutter/material.dart';

class Notifiaction extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // navigatorKey: navigatorKey,

      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: Center(
        child: Text('This is the Notification Screen'),
      ),
    );
  }
}
