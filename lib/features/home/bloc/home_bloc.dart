import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_explorer/api/api.dart';
import 'package:bloc_explorer/models/blogs_model.dart';
import 'package:bloc_explorer/models/favorite_items.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeFavoriteClickedEvent>(homeFavoriteClickedEvent);
    on<HomeFavoriteNavigateEvent>(homeFavoriteNavigateEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    List<BlogsModels> blogs = await ApiServices.fetchBlogs();
    emit(
      HomeLoadingSuccessState(blogs: blogs),
    );
  }

  FutureOr<void> homeFavoriteClickedEvent(
      HomeFavoriteClickedEvent event, Emitter<HomeState> emit) {
    favoriteItems.add(event.slectedProduct);
    emit(FavItemsSelectedActionState());
  }

  FutureOr<void> homeFavoriteNavigateEvent(
      HomeFavoriteNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateFavoriteState());
  }
}
