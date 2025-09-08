import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final Widget child;
  const BackgroundImage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - kToolbarHeight - kBottomNavigationBarHeight,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/bg.jpeg'), fit: BoxFit.cover),
      ),
      child: Container(
        color: Colors.white.withValues(alpha: 0.7),
        child: Column(children: [child]),
      ),
    );
  }
}
