import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:wallpaper_app/core/constants/app_constants.dart';
import 'package:wallpaper_app/core/routes/app_router_constants.dart';
import 'package:wallpaper_app/features/home/presentation/blocs/wallpapers_bloc/bloc/wallpaper_bloc.dart';
import 'package:wallpaper_app/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:wallpaper_app/features/home/presentation/widgets/carousel_widget.dart';
import 'package:wallpaper_app/features/home/presentation/widgets/wallpaper_card.dart';
import 'package:wallpaper_app/features/search/presentations/blocs/bloc/search_bloc.dart';
import 'package:wallpaper_app/features/search/presentations/widgets/search_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box(AppConstants.history);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            AppBarWidget(
              title: SearchBarWidget(
                hintText: 'Search',
                controller: searchController,
                onChange: (query) {
                  context.read<SearchBloc>().add(PerformSearch(query: query));
                },
                onEditingComplete: () {
                  box.put(searchController.text, DateTime.now());

                  // Optional: only delete if > 9 items exist
                  if (!box.containsKey(searchController.text)) {
                    box.put(searchController.text, DateTime.now());
                  }
                },
              ),
            ),

            BlocBuilder<WallpaperBloc, WallpaperState>(
              builder: (context, state) {
                if (state is WallpaperLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (state is WallpaperLoaded) {
                  final wallpapers = state.wallpapers;

                  return SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(
                        height: 300,
                        child: CarouselWidget(wallpapers: wallpapers),
                      ),
                    ]),
                  );
                }

                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
            ValueListenableBuilder(
              valueListenable: searchController,
              builder: (context, query, _) {
                return searchController.text.isEmpty
                    ? BlocBuilder<WallpaperBloc, WallpaperState>(
                        builder: (context, state) {
                          if (state is WallpaperLoaded) {
                            final wallpapers = state.wallpapers;
                            return SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 2 / 3,
                                  ),
                              delegate: SliverChildBuilderDelegate((
                                context,
                                index,
                              ) {
                                final wallpaper = wallpapers[index];
                                return WallpaperCard(
                                  imgUrl: wallpaper.imgUrl,
                                  onTap: () => context.pushNamed(
                                    AppRouterConstants.wallpaperView,
                                    pathParameters: {
                                      'imgUrl': wallpaper.imgUrl,
                                    },
                                    extra: wallpaper.alt,
                                  ),
                                );
                              }, childCount: wallpapers.length),
                            );
                          }
                          return const SliverToBoxAdapter(
                            child: SizedBox.shrink(),
                          );
                        },
                      )
                    : BlocBuilder<SearchBloc, SearchState>(
                        builder: (context, state) {
                          if (state is SearchLoaded) {
                            final searchs = state.search;
                            return SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 2 / 3,
                                  ),
                              delegate: SliverChildBuilderDelegate((
                                context,
                                index,
                              ) {
                                final wallpaper = searchs[index];
                                return WallpaperCard(
                                  imgUrl: wallpaper.imgUrl,
                                  onTap: () => context.pushNamed(
                                    AppRouterConstants.wallpaperView,
                                    pathParameters: {
                                      'imgUrl': wallpaper.imgUrl,
                                    },
                                    extra: wallpaper.imgUrl,
                                  ),
                                );
                              }, childCount: searchs.length),
                            );
                          }
                          if (state is SearchLoading) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return SizedBox();
                        },
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
