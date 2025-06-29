
import 'package:elwekala/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomProfileImage extends StatelessWidget {
  const CustomProfileImage({
    super.key,
    required this.isEditing,
  });

  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const CircleAvatar(
            radius: 48,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              size: 50,
              color: AppColors.primaryPurple,
            ),
          ),
        ),
        if (isEditing)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.primaryPurple,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
      ],
    );
  }
}