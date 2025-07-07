import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:wallpaper_app/core/constants/app_constants.dart';
import 'package:wallpaper_app/core/routes/app_router_constants.dart';
import 'package:wallpaper_app/features/home/presentation/widgets/wallpaper_card.dart';
import 'package:wallpaper_app/features/search/presentations/blocs/bloc/search_bloc.dart';
import 'package:wallpaper_app/features/search/presentations/widgets/search_bar_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final box = Hive.box(AppConstants.history);

    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(15),
        child: Column(
          children: [
            SearchBarWidget(
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

            Expanded(
              child: ValueListenableBuilder(
                valueListenable: searchController,
                builder: (context, value, _) {
                  final history = box.keys.cast<String>().toList();
                  return value.text.isEmpty
                      ? ListView.builder(
                          itemCount: history.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                history[index],
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.close, size: 20),
                                onPressed: () async {
                                  await box.deleteAt(index);
                                  setState(() {});
                                },
                              ),
                            );
                          },
                        )
                      : BlocBuilder<SearchBloc, SearchState>(
                          builder: (context, state) {
                            if (state is SearchLoading) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (state is SearchLoaded) {
                              return GridView.builder(
                                itemCount: state.search.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 9 / 16,
                                    ),
                                itemBuilder: (context, index) {
                                  final wallpaper = state.search[index];
                                  return WallpaperCard(
                                    imgUrl: wallpaper.imgUrl,
                                    onTap: () {
                                      context.pushNamed(
                                        AppRouterConstants.wallpaperView,
                                        pathParameters: {
                                          'imgUrl': wallpaper.imgUrl,
                                        },
                                        extra: wallpaper.title,
                                      );
                                    },
                                  );
                                },
                              );
                            }
                            if (state is SearchError) {
                              return Text(state.message);
                            } else {
                              return Center();
                            }
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
