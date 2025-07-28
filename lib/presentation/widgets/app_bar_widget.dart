import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color backgroundColor;

  const AppBarWidget({
    super.key,
    required this.title,
    this.actions,
    this.backgroundColor = Colors.deepPurple,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      centerTitle: true,
      elevation: 4,
      shadowColor: Colors.deepPurple.shade200,
      shape: const RoundedRectangleBorder(
        // Bordes redondeados abajo
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      title: Text(
        title.toUpperCase(),
        style: const TextStyle(
          letterSpacing: 2.0,
          fontWeight: FontWeight.w800,
          fontSize: 22,
          color: Colors.white,
          shadows: [
            Shadow(color: Colors.black26, offset: Offset(1, 1), blurRadius: 3),
          ],
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
