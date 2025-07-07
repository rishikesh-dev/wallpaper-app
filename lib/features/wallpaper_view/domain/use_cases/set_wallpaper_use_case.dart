import 'package:wallpaper_app/features/wallpaper_view/domain/repositories/set_wallpaper_repository.dart';

class SetWallpaperUseCase {
  final SetWallpaperRepository repository;
  SetWallpaperUseCase(this.repository);

  Future<void> call(String path, String title, int type) {
    return repository.setWallpaper(path, title, type);
  }

  Future<void> downloadWallpaper(String path, String title) {
    return repository.downloadWallpaper(path, title);
  }
}
