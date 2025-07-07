import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wallpaper_app/core/constants/app_constants.dart';
import 'package:wallpaper_app/core/routes/app_router_constants.dart';
import 'package:wallpaper_app/features/get_started/presentation/screens/details_screen.dart';
import 'package:wallpaper_app/features/get_started/presentation/screens/get_started.dart';
import 'package:wallpaper_app/features/main_page/presentation/screens/main_page.dart';
import 'package:wallpaper_app/features/wallpaper_view/presentation/screens/wallpaper_view.dart';

class GoRouterConfig {
  static final routerConfig = GoRouter(
    redirect: (context, state) {
      final box = Hive.box(AppConstants.user);
      final user = box.get('name');

      final loggingIn =
          state.matchedLocation == '/getStarted' ||
          state.matchedLocation == '/details';

      final isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);

      if (user == null && !loggingIn && isMobile && !kIsWeb) {
        return '/getStarted';
      }

      if (user != null && loggingIn) {
        return '/';
      }
      return null;
    },

    routes: [
      GoRoute(
        path: '/getStarted',
        name: AppRouterConstants.getStarted,
        builder: (context, state) => GetStarted(),
      ),
      GoRoute(
        path: '/details',
        name: AppRouterConstants.detailsScreen,
        builder: (context, state) => DetailsScreen(),
      ),
      GoRoute(
        path: '/',
        name: AppRouterConstants.homeScreen,
        builder: (context, state) => MainPage(),
      ),
      GoRoute(
        path: '/view/:imgUrl',
        name: AppRouterConstants.wallpaperView,
        builder: (context, state) {
          final imgUrl = state.pathParameters['imgUrl'] ?? '';
          final title = state.extra as String? ?? 'Untitled';
          return WallpaperView(imgUrl: imgUrl, title: title);
        },
      ),
    ],
  );
}
