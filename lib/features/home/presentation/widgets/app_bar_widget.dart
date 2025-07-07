import 'package:flutter/material.dart';
import 'package:wallpaper_app/main.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.title});
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      title: title,
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            themeNotifier.toggleTheme();
          },
          icon: Icon(
            themeNotifier.isDarkMode ? Icons.dark_mode : Icons.light_mode,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
