import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        CupertinoIcons.back,
        color: Colors.white, 
      ),
      onPressed: onPressed ?? () => Navigator.of(context).maybePop(),
    );
  }
}
