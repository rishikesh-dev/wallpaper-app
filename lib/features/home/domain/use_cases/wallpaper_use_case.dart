import 'package:fpdart/fpdart.dart';
import 'package:wallpaper_app/core/errors/failure.dart';
import 'package:wallpaper_app/features/home/domain/entities/wallpaper_entity.dart';
import 'package:wallpaper_app/features/home/domain/repositories/wallpaper_repository.dart';

class WallpaperUseCase {
  final WallpaperRepository repository;
  WallpaperUseCase({required this.repository});
  Future<Either<Failure, List<WallpaperEntity>>> call(int page) async {
    return repository.getWallpapers();
  }
}
