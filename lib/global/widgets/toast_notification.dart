import 'package:flutter/material.dart';

class ToastNotificationWidget {
  static sucessNotification(
      {required BuildContext context,
      required String? title,
      required String? description}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Durations.extralong4,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 10), // works when behavior is floating
        backgroundColor: Colors.green,
        content: ListTile(
          visualDensity: const VisualDensity(vertical: -4, horizontal: 0),
          isThreeLine: true,
          title: Text(
            title ?? "Success",
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            description ?? "",
            style: const TextStyle(color: Colors.white),
          ),
        )));
  }

  static failedNotification(
      {required BuildContext context,
      required String? title,
      required String? description}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Durations.extralong4,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 10), // works when behavior is floating
        backgroundColor: Colors.red,
        content: ListTile(
          visualDensity: const VisualDensity(vertical: -4, horizontal: 0),
          isThreeLine: true,
          title: Text(
            title ?? "Error",
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            description ?? "",
            style: const TextStyle(color: Colors.white),
          ),
        )));
  }
}
