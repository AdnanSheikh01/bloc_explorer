import 'package:bloc_explorer/api/api.dart';
import 'package:bloc_explorer/features/home/bloc/home_bloc.dart';
import 'package:bloc_explorer/features/home/ui/detailed_home.dart';
import 'package:bloc_explorer/models/blogs_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../favorite/ui/favorite.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateFavoriteState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FavoritePage(),
            ),
          );
        } else if (state is FavItemsSelectedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'Added to Favorites',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is HomeLoadingSuccessState) {
          final successState = state;

          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                title: const Text('Bloc Explorer'),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeFavoriteNavigateEvent());
                    },
                    icon: const Icon(Icons.favorite),
                  )
                ],
              ),
              body: FutureBuilder(
                  future: ApiServices.fetchBlogs(),
                  builder:
                      (context, AsyncSnapshot<List<BlogsModels>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return const Center(child: Text('No Data Available'));
                    }
                    return ListView.builder(
                        itemCount: successState.blogs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailedHomePage(
                                        image:
                                            '${successState.blogs[index].imageUrl}',
                                        title:
                                            '${successState.blogs[index].title}'),
                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.grey.shade200,
                                elevation: 4,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        '${successState.blogs[index].imageUrl}',
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                '${successState.blogs[index].title}',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  homeBloc.add(
                                                      HomeFavoriteClickedEvent(
                                                          slectedProduct:
                                                              successState
                                                                      .blogs[
                                                                  index]));
                                                },
                                                icon: const Icon(
                                                    Icons.favorite_border))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }));
        } else if (state is HomeErrorState) {
          return const Scaffold(
            body: Center(
              child: Text('Error Occured'),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
