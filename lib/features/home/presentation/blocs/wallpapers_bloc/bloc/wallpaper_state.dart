part of 'wallpaper_bloc.dart';

abstract class WallpaperState {}

//Wallpaper Loading State
class WallpaperInitial extends WallpaperState {}

class WallpaperLoading extends WallpaperState {}

class WallpaperLoaded extends WallpaperState {
  final List<WallpaperEntity> wallpapers;
  final bool hasMore;

  WallpaperLoaded({required this.wallpapers, required this.hasMore});
}

class WallpaperError extends WallpaperState {
  final String message;

  WallpaperError({required this.message});
}
