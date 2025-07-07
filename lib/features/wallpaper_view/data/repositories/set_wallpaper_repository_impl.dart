import 'package:wallpaper_app/features/wallpaper_view/domain/repositories/set_wallpaper_repository.dart';
import 'package:wallpaper_app/features/wallpaper_view/external/set_wallpaper_service.dart';

class SetWallpaperRepositoryImpl extends SetWallpaperRepository {
  final SetWallpaperService service;

  SetWallpaperRepositoryImpl({required this.service});
  @override
  Future<void> setWallpaper(String imgUrl, String title, int type) async {
    return await service.setWallpaper(imgUrl, title, type);
  }

  @override
  Future<void> downloadWallpaper(String imgUrl, String title) async {
    return await service.downloadWallpaper(imgUrl, title);
  }
}
