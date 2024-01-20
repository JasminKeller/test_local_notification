import 'package:flutter/material.dart';
import 'package:test_local_notification/notification_manager/notification_manager.dart';
import 'package:test_local_notification/util/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(onPressed: () {
            NotificationManager().simpleNotificationShow();
          }, title: "Einfache Benachrichtigung"),
        ],
      ),
    );
  }
}
