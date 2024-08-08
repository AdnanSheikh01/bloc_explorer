part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadingSuccessState extends HomeState {
  final List<BlogsModels> blogs;
  HomeLoadingSuccessState({
    required this.blogs,
  });
}

class HomeErrorState extends HomeState {}

class HomeNavigateFavoriteState extends HomeActionState {}
