import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Rounded book cover image with a subtle shadow.
class BookCover extends StatelessWidget {
  final String asset;
  final double width;
  final double height;
  final double radius;

  const BookCover({
    super.key,
    required this.asset,
    this.width = 48,
    this.height = 64,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.asset(
          asset,
          width: width,
          height: height,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            width: width,
            height: height,
            color: AppColors.primaryLight,
            child: Icon(Icons.menu_book, color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
