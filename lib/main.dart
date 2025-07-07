import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toastification/toastification.dart';
import 'package:wallpaper_app/core/constants/app_constants.dart';
import 'package:wallpaper_app/core/routes/go_router_config.dart';
import 'package:wallpaper_app/core/secrets/app_secrets.dart';
import 'package:wallpaper_app/core/theme/theme_notifier.dart';
import 'package:wallpaper_app/features/home/data/data_sources/remote_data_source/pexels_api_remote_data_source.dart';
import 'package:wallpaper_app/features/home/data/repositories/wallpaper_repositories_impl.dart';
import 'package:wallpaper_app/features/home/domain/use_cases/wallpaper_use_case.dart';
import 'package:wallpaper_app/features/home/presentation/blocs/wallpapers_bloc/bloc/wallpaper_bloc.dart';
import 'package:wallpaper_app/features/search/data/remote_data_sources/pexel_remote_data_source.dart';
import 'package:wallpaper_app/features/search/data/repositories/search_repositories_impl.dart';
import 'package:wallpaper_app/features/search/domain/use_cases/search_wallpaper_use_case.dart';
import 'package:wallpaper_app/features/search/presentations/blocs/bloc/search_bloc.dart';

final themeNotifier = ThemeNotifier();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Future.wait([
    Hive.openBox(AppConstants.user),
    Hive.openBox(AppConstants.settings),
    Hive.openBox(AppConstants.favorites),
    Hive.openBox(AppConstants.history),
    Hive.openBox(AppConstants.downloads),
  ]);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: true,
          create: (context) => WallpaperBloc(
            WallpaperUseCase(
              repository: WallpaperRepositoriesImpl(
                remoteDataSource: PexelsApiRemoteDataSourceImpl(
                  apiKey: AppSecrets.pexelsApiKey,
                ),
              ),
            ),
          )..add(LoadWallpapersEvent()),
        ),
        BlocProvider(
          lazy: true,
          create: (context) => SearchBloc(
            SearchWallpaperUseCase(
              repository: SearchRepositoriesImpl(
                remoteDataSource: PexelRemoteDataSourceImpl(
                  apiKey: AppSecrets.pexelsApiKey,
                ),
              ),
            ),
          ),
        ),
      ],
      child: ToastificationWrapper(child: const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (context, theme, _) => MaterialApp.router(
        title: 'Wallpaper App',
        theme: theme,
        debugShowCheckedModeBanner: false,

        routerConfig: GoRouterConfig.routerConfig,
      ),
    );
  }
}
