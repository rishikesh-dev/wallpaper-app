import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wallpaper_app/core/errors/failure.dart';
import 'package:wallpaper_app/features/home/domain/entities/wallpaper_entity.dart';
import 'package:wallpaper_app/features/home/domain/use_cases/wallpaper_use_case.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  final WallpaperUseCase wallpaperUseCase;
  int _page = 1;
  final List<WallpaperEntity> _wallpapers = [];
  bool _hasMore = true;
  bool _isFetching = false;

  WallpaperBloc(this.wallpaperUseCase) : super(WallpaperInitial()) {
    on<LoadWallpapersEvent>(_onLoadWallpapers);
    on<RefreshWallpapersEvent>(_onRefreshWallpapers);
  }

  Future<void> _onLoadWallpapers(
    LoadWallpapersEvent event,
    Emitter<WallpaperState> emit,
  ) async {
    if (_isFetching || !_hasMore) return;
    _isFetching = true;

    if (_wallpapers.isEmpty) emit(WallpaperLoading());

    final Either<Failure, List<WallpaperEntity>> result = await wallpaperUseCase
        .call(_page);

    result.fold(
      (failure) {
        emit(WallpaperError(message: failure.message));
      },
      (newWallpapers) {
        if (newWallpapers.isEmpty) {
          _hasMore = false;
        } else {
          _wallpapers.addAll(newWallpapers);
          _page++;
        }

        emit(
          WallpaperLoaded(
            wallpapers: List.from(_wallpapers),
            hasMore: _hasMore,
          ),
        );
      },
    );

    _isFetching = false;
  }

  Future<void> _onRefreshWallpapers(
    RefreshWallpapersEvent event,
    Emitter<WallpaperState> emit,
  ) async {
    _page = 1;
    _wallpapers.clear();
    _hasMore = true;
    _isFetching = false;
    add(LoadWallpapersEvent());
  }
}
