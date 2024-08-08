part of 'favorite_bloc.dart';

abstract class FavoriteState {}

abstract class FavActionState extends FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteSuccessState extends FavoriteState {
  final List<BlogsModels> favItems;
  FavoriteSuccessState({
    required this.favItems,
  });
}
