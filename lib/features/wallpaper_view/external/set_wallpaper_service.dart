import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class SetWallpaperService {
  final wallpaperManager = WallpaperManagerFlutter();
  Future setWallpaper(String imgUrl, String title, int type) async {
    try {
      final response = await http.get(Uri.parse(imgUrl));
      if (response.statusCode != 200) {
        throw Exception('Failed to set as wallpaper');
      }
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filePath = '${tempDir.path}/$title`_`$timestamp.jpg';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      wallpaperManager.setWallpaper(file, type);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future downloadWallpaper(String imgUrl, String title) async {
    final response = await http.get(Uri.parse(imgUrl));
    try {
      if (response.statusCode != 200) {
        throw Exception('Failed to download wallpaper');
      }
      final tempDir = await getTemporaryDirectory();
      final timeStamp = DateTime.now().microsecondsSinceEpoch;
      final filePath = '${tempDir.path}/${title}_$timeStamp';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
    } catch (e) {
      throw Exception(e);
    }
  }
}
