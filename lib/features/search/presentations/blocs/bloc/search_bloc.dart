import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wallpaper_app/core/errors/failure.dart';
import 'package:wallpaper_app/features/search/domain/entities/search_entity.dart';
import 'package:wallpaper_app/features/search/domain/use_cases/search_wallpaper_use_case.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchWallpaperUseCase useCase;

  SearchBloc(this.useCase) : super(SearchInitial()) {
    on<PerformSearch>((event, emit) async {
      final query = event.query;
      emit(SearchLoading());
      final Either<Failure, List<SearchEntity>> result = await useCase.call(
        query,
      );
      result.fold(
        (failure) => emit(SearchError(message: failure.message)),
        (search) => emit(SearchLoaded(search: search)),
      );
    });
  }
}
