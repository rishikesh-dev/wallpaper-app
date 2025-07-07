import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toastification/toastification.dart';
import 'package:wallpaper_app/core/widgets/fav_button.dart';
import 'package:wallpaper_app/core/widgets/toast_widget.dart';
import 'package:wallpaper_app/features/wallpaper_view/data/repositories/set_wallpaper_repository_impl.dart';
import 'package:wallpaper_app/features/wallpaper_view/domain/use_cases/set_wallpaper_use_case.dart';
import 'package:wallpaper_app/features/wallpaper_view/external/set_wallpaper_service.dart';
import 'package:wallpaper_app/features/wallpaper_view/presentation/widgets/bottom_sheet_widget.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class WallpaperView extends StatelessWidget {
  const WallpaperView({super.key, required this.imgUrl, required this.title});

  final String imgUrl;
  final String title;

  Future<void> _setWallpaper(
    BuildContext context,
    SetWallpaperUseCase useCase,
    int location,
    String message,
  ) async {
    try {
      await useCase(imgUrl, title, location);
      await Future.delayed(const Duration(milliseconds: 200));

      if (context.mounted) context.pop(); // safely close sheet

      showToast(
        message,
        ToastificationType.success,
        ToastificationStyle.minimal,
      );
    } catch (e) {
      showToast(
        'Failed to set wallpaper',
        ToastificationType.error,
        ToastificationStyle.minimal,
        description: e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final useCase = SetWallpaperUseCase(
      SetWallpaperRepositoryImpl(service: SetWallpaperService()),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(forceMaterialTransparency: true),
      body: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: imgUrl,
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                fit: BoxFit.cover,
                placeholder: (_, _) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (_, __, ___) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FavButton(imgUrl: imgUrl),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 30,
                        ),
                        backgroundColor: const Color.fromARGB(73, 0, 0, 0),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        await showModalBottomSheet(
                          context: context,
                          builder: (_) => BottomSheetWidget(
                            label: [
                              'Home Screen',
                              'Lock Screen',
                              'Home & Lock Screen',
                            ],
                            onPressed: [
                              () => _setWallpaper(
                                context,
                                useCase,
                                WallpaperManagerFlutter.homeScreen,
                                'Wallpaper set to Home Screen',
                              ),
                              () => _setWallpaper(
                                context,
                                useCase,
                                WallpaperManagerFlutter.lockScreen,
                                'Wallpaper set to Lock Screen',
                              ),
                              () => _setWallpaper(
                                context,
                                useCase,
                                WallpaperManagerFlutter.bothScreens,
                                'Wallpaper set to Both Screens',
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text('Set as Wallpaper'),
                    ),
                    const SizedBox(width: 16),
                    IconButton.filled(
                      padding: const EdgeInsets.all(10),
                      icon: const Icon(LucideIcons.download),
                      style: IconButton.styleFrom(
                        iconSize: 30,
                        backgroundColor: const Color.fromARGB(73, 0, 0, 0),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        try {
                          await useCase.downloadWallpaper(imgUrl, title);
                          final box = Hive.box('downloads');
                          await box.put(imgUrl, title);
                          showToast(
                            'Wallpaper Downloaded',
                            ToastificationType.success,
                            ToastificationStyle.minimal,
                          );
                        } catch (e) {
                          showToast(
                            'Download Failed',
                            ToastificationType.error,
                            ToastificationStyle.minimal,
                            description: e.toString(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
