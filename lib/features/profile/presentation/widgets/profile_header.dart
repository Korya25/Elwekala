import 'package:elwekala/core/widgets/custom_header_app.dart';
import 'package:elwekala/features/profile/presentation/widgets/custom_profile_image.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final bool isEditing;
  final VoidCallback onEditPressed;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.isEditing,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomHeaderApp(
          icon: CustomProfileImage(isEditing: isEditing),
          title: name,
          subTitle: email,
        ),
        Positioned(
          top: 16,
          right: 16,
          child: IconButton(
            onPressed: onEditPressed,
            icon: Icon(
              isEditing ? Icons.close : Icons.edit,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
