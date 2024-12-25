import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.height,
    required this.width,
    required this.child,
  });

  final double height;
  final double width;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Container(
        height: height * 0.22,
        width: width * 0.45,
        decoration: BoxDecoration(
          color: isDarkMode ? Color(0xff141414) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? Colors.white30 : Colors.black,
              blurRadius: 5,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
