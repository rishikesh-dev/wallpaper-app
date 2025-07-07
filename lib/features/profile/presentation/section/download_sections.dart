import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wallpaper_app/features/home/presentation/widgets/wallpaper_card.dart';

class DownloadSections extends StatelessWidget {
  const DownloadSections({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('downloads');
    final downloads = box.keys.cast<String>().toList();
    return GridView.builder(
      itemCount: downloads.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (ctx, index) {
        return WallpaperCard(onTap: () {}, imgUrl: downloads[index]);
      },
    );
  }
}
