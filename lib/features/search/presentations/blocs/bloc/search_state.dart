part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String message;

  SearchError({required this.message});
}

class SearchLoaded extends SearchState {
  final List<SearchEntity> search;

  SearchLoaded({required this.search});
}
