import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Circular avatar showing the user's photo, or their initials as a fallback.
class UserAvatar extends StatelessWidget {
  final String initials;
  final Uint8List? imageBytes;
  final double radius;
  final double fontSize;

  const UserAvatar({
    super.key,
    required this.initials,
    this.imageBytes,
    this.radius = 22,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.primaryDark,
      backgroundImage: imageBytes != null ? MemoryImage(imageBytes!) : null,
      child: imageBytes == null
          ? Text(
              initials,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: fontSize,
              ),
            )
          : null,
    );
  }
}
