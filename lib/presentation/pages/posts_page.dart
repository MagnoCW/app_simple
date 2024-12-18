import 'package:app_simples/presentation/bloc/post_event.dart';
import 'package:app_simples/presentation/bloc/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/post_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  ElevatedButton(
                    onPressed: () {
                      context.read<PostBloc>().add(LoadPosts());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is PostLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      post.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(post.body),
                    trailing: IconButton(
                      icon: Icon(
                        post.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: post.isFavorite ? Colors.red : null,
                      ),
                      onPressed: () {
                        context
                            .read<PostBloc>()
                            .add(TogglePostFavorite(post.id));
                      },
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
