import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_explorer/models/blogs_model.dart';
import 'package:bloc_explorer/models/favorite_items.dart';
import 'package:flutter/material.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<FavoriteInitialEvent>(favoriteInitialEvent);
    on<FavoriteRemoveEvent>(favoriteRemoveEvent);
  }

  FutureOr<void> favoriteInitialEvent(
      FavoriteInitialEvent event, Emitter<FavoriteState> emit) {
    emit(FavoriteSuccessState(favItems: favoriteItems));
  }

  FutureOr<void> favoriteRemoveEvent(
      FavoriteRemoveEvent event, Emitter<FavoriteState> emit) {
    favoriteItems.remove(event.blogsModels);
    emit(FavoriteSuccessState(favItems: favoriteItems));
    emit(FavItemsRemovedActionState());
  }
}
