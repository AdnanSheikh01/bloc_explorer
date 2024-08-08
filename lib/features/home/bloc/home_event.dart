part of 'home_bloc.dart';

abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeFavoriteClickedEvent extends HomeEvent {
  final BlogsModels slectedProduct;
  HomeFavoriteClickedEvent({required this.slectedProduct});
}

class HomeFavoriteNavigateEvent extends HomeEvent {}

class FavItemsSelectedActionState extends HomeActionState {}
