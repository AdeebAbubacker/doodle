import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlushbarHelper {
  static void show(
    BuildContext context, {
    required bool status,
    required String title,
    required String content,
  }) {
    Flushbar(
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(12),
      backgroundColor: Colors.white,
      flushbarPosition: FlushbarPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      duration: const Duration(milliseconds: 1900),
      icon: status
          ? const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 28,
            )
          : const Icon(
              Icons.cancel,
              color: Colors.red,
              size: 28,
            ),
      titleText: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.black,
        ),
      ),
      messageText: Text(
        content,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.black54,
        ),
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          spreadRadius: 2,
          offset: const Offset(0, 2),
        ),
      ],
    ).show(context);
  }
}
