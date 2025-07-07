import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wallpaper_app/core/routes/app_router_constants.dart';
import 'package:wallpaper_app/features/home/domain/entities/wallpaper_entity.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({super.key, required this.wallpapers});
  final List<WallpaperEntity> wallpapers;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: wallpapers.length,
      itemBuilder: (ctx, index, pageIndex) {
        final wallpaper = wallpapers[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            child: InkWell(
              onTap: () => context.pushNamed(
                AppRouterConstants.wallpaperView,
                pathParameters: {'imgUrl': wallpaper.imgUrl},
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: wallpaper.imgUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                ),
              ),
            ),
          ),
        );
      },
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 10),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        pauseAutoPlayOnTouch: true,
        pauseAutoPlayOnManualNavigate: true,
        enlargeCenterPage: true,
        viewportFraction: 1, // ✅ enables visual enlargement
        aspectRatio: 16 / 10,
        initialPage: 0, // ✅ starts from the first item
      ),
    );
  }
}
