import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:wallpaper_app/core/routes/app_router_constants.dart';
import 'package:wallpaper_app/features/home/presentation/widgets/wallpaper_card.dart';

class FavouriteSection extends StatelessWidget {
  const FavouriteSection({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('favorites');
    final favorites = box.keys.cast<String>().toList();
    return GridView.builder(
      itemCount: favorites.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (ctx, index) {
        return WallpaperCard(
          onTap: () {
            context.pushNamed(
              AppRouterConstants.wallpaperView,
              pathParameters: {'imgUrl': favorites[index]},
            );
          },
          imgUrl: favorites[index],
        );
      },
    );
  }
}
