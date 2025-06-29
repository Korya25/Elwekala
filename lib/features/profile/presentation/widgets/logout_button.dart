
import 'package:elwekala/core/constants/app_colors.dart';
import 'package:elwekala/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key, });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: AppColors.cardBackground,
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              content: const Text(
                'Are you sure you want to logout?',
                style: TextStyle(color: Colors.grey),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigate to login screen
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: AppColors.errorRed),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        icon: const Icon(Icons.logout, color: Color(0xFFEF4444)),
        label: const Text(
          AppStrings.logout,
          style: TextStyle(
            color: Color(0xFFEF4444),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
