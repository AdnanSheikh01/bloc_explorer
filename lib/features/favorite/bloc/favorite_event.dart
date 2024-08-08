part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}

class FavoriteInitialEvent extends FavoriteEvent {}

class FavoriteRemoveEvent extends FavoriteEvent {
  final BlogsModels blogsModels;
  FavoriteRemoveEvent({
    required this.blogsModels,
  });
}

class FavItemsRemovedActionState extends FavActionState {}
