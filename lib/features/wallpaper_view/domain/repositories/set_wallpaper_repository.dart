abstract class SetWallpaperRepository {
  Future setWallpaper(String imgUrl, String title, int type);
  Future downloadWallpaper(String imgUrl, String title);
}
