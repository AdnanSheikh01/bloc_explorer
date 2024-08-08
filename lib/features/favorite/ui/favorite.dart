import 'package:bloc_explorer/features/favorite/bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final FavoriteBloc favoriteBloc = FavoriteBloc();

  @override
  void initState() {
    favoriteBloc.add(FavoriteInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: BlocConsumer<FavoriteBloc, FavoriteState>(
        bloc: favoriteBloc,
        listenWhen: (previous, current) => current is FavActionState,
        buildWhen: (previous, current) => current is! FavActionState,
        listener: (context, state) {
          if (state is FavItemsRemovedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                  'Removed from Favorites',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is FavoriteSuccessState) {
            final successState = state;
            return successState.favItems.isEmpty
                ? const Center(
                    child: Text('No Favorite Blogs.'),
                  )
                : ListView.builder(
                    itemCount: successState.favItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: Card(
                          color: Colors.grey.shade200,
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
                                    '${successState.favItems[index].imageUrl}'),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          '${successState.favItems[index].title}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          favoriteBloc.add(FavoriteRemoveEvent(
                                              blogsModels: successState
                                                  .favItems[index]));
                                        },
                                        icon: const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
          }
          return const Center(child: Text('Loading favorites...'));
        },
      ),
    );
  }
}
