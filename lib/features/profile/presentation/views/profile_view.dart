import 'package:elwekala/core/constants/app_colors.dart';
import 'package:elwekala/core/widgets/animate_do.dart';
import 'package:elwekala/features/profile/presentation/widgets/logout_button.dart';
import 'package:elwekala/features/profile/presentation/widgets/profile_content.dart';
import 'package:elwekala/features/profile/presentation/widgets/profile_header.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(child: ProfileViewBody()),
      ),
    );
  }
}

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  bool _isEditing = false;
  bool _isLoading = false;

  void _loadUserData() {
    _nameController.text = "Mahmoud Mohamed ";
    _emailController.text = "mahmoud@gmail.com";
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false;
      _isEditing = false;
    });

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: AppColors.successGreen,
      ),
    );
  }

  void _toggleEditMode() {
    setState(() => _isEditing = !_isEditing);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileHeader(
          name: _nameController.text,
          email: _emailController.text,
          isEditing: _isEditing,
          onEditPressed: _toggleEditMode,
        ),
        CustomFadeInLeft(
          duration: 800,
          child: ProfileContent(
            formKey: _formKey,
            isEditing: _isEditing,
            nameController: _nameController,
            emailController: _emailController,
            isLoading: _isLoading,
            onSave: _handleSave,
          ),
        ),
        CustomFadeInUp(duration: 800, child: LogoutButton()),
      ],
    );
  }
}
