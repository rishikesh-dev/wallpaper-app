import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FavButton extends StatelessWidget {
  const FavButton({super.key, required this.imgUrl});
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('favorites');

    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (context, Box box, _) {
        final isFavorite = box.get(imgUrl, defaultValue: false);

        return IconButton(
          onPressed: () {
            if (isFavorite) {
              box.delete(imgUrl);
            } else {
              box.put(imgUrl, true);
            }
          },
          icon: Icon(isFavorite ? Icons.favorite : LucideIcons.heart),
          style: IconButton.styleFrom(
            foregroundColor: isFavorite ? Colors.pink : Colors.white,
          ),
        );
      },
    );
  }
}
