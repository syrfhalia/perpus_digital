import 'package:flutter/material.dart';

enum NotificationType { dueSoon, available, info, success }

/// An in-app notification item.
class AppNotification {
  final String title;
  final String message;
  final String time;
  final NotificationType type;
  final bool unread;

  const AppNotification({
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.unread = false,
  });

  IconData get icon {
    switch (type) {
      case NotificationType.dueSoon:
        return Icons.schedule;
      case NotificationType.available:
        return Icons.menu_book;
      case NotificationType.success:
        return Icons.check_circle;
      case NotificationType.info:
        return Icons.info;
    }
  }

  Color get color {
    switch (type) {
      case NotificationType.dueSoon:
        return const Color(0xFFF59E0B);
      case NotificationType.available:
        return const Color(0xFF15A196);
      case NotificationType.success:
        return const Color(0xFF16A34A);
      case NotificationType.info:
        return const Color(0xFF3B82F6);
    }
  }
}
