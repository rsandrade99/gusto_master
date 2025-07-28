import 'package:flutter/material.dart';

class ButtonAnimadoWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData? icon;

  const ButtonAnimadoWidget({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle =
        ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
          backgroundColor: Colors.deepPurple.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 6,
          shadowColor: Colors.deepPurple.withOpacity(0.6),
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ).copyWith(
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.deepPurple.shade700;
            }
            return Colors.deepPurple.shade400;
          }),
          overlayColor: MaterialStateProperty.all(
            Colors.deepPurple.withOpacity(0.15),
          ),
        );

    return icon != null
        ? ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon, size: 26),
            label: Text(label),
            style: buttonStyle,
          )
        : SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: buttonStyle,
              child: Text(label, textAlign: TextAlign.center),
            ),
          );
  }
}
