import 'package:flutter/material.dart';
import 'package:wallpaper_app/features/home/presentation/screens/home_screen.dart';
import 'package:wallpaper_app/features/main_page/presentation/widgets/bottom_nav_widget.dart';
import 'package:wallpaper_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:wallpaper_app/features/search/presentations/screens/search_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    currentIndexNotifier;
  }

  @override
  void dispose() {
    super.dispose();
    currentIndexNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = const [
      HomeScreen(),
      SearchScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ValueListenableBuilder<int>(
        valueListenable: currentIndexNotifier,
        builder: (context, value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: BottomNavWidget(),
    );
  }
}
