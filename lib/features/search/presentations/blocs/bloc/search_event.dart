part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class PerformSearch extends SearchEvent {
  final String query;

  PerformSearch({required this.query});
}
