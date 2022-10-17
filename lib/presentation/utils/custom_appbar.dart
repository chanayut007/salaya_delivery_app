import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final double height;
  final Widget? leading;
  final Widget child;
  final List<Widget>? trailing;

  const CustomAppBar({Key? key, this.leading, required this.child, this.trailing, this.height = 60}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: child,
      actions: trailing,
    );
  }
}
