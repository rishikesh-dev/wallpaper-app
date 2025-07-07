import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/core/widgets/fav_button.dart';

class WallpaperCard extends StatelessWidget {
  final String imgUrl;
  final VoidCallback onTap;

  const WallpaperCard({super.key, required this.imgUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imgUrl,
      child: Material(
        child: InkWell(
          enableFeedback: true,
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: CachedNetworkImageProvider(imgUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: FavButton(imgUrl: imgUrl),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
