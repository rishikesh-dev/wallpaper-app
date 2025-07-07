import 'package:fpdart/fpdart.dart';
import 'package:wallpaper_app/core/errors/failure.dart';
import 'package:wallpaper_app/features/home/domain/entities/wallpaper_entity.dart';

abstract class WallpaperRepository {
  Future<Either<Failure, List<WallpaperEntity>>> getWallpapers();
}
