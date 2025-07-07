import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToast(
  String title,
  ToastificationType type,
  ToastificationStyle minimal, {
  ToastificationStyle style = ToastificationStyle.flat,
  String description = '',
}) {
  toastification.show(
    title: Text(title),
    description: description.isNotEmpty ? Text(description) : null,
    type: type,
    style: style,
    autoCloseDuration: const Duration(seconds: 3),
  );
}
