// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import 'package:wallpaper_app/core/errors/failure.dart';
import 'package:wallpaper_app/features/home/data/data_sources/remote_data_source/pexels_api_remote_data_source.dart';
import 'package:wallpaper_app/features/home/domain/entities/wallpaper_entity.dart';
import 'package:wallpaper_app/features/home/domain/repositories/wallpaper_repository.dart';

class WallpaperRepositoriesImpl extends WallpaperRepository {
  final PexelsApiRemoteDataSource remoteDataSource;

  WallpaperRepositoriesImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<WallpaperEntity>>> getWallpapers({
    int page = 1,
  }) async {
    try {
      final wallpapers = await remoteDataSource.getWallpapers(page);
      return right(wallpapers);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
