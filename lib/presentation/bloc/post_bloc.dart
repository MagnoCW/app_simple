import 'package:app_simples/presentation/bloc/post_event.dart';
import 'package:app_simples/presentation/bloc/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/post.dart';

typedef GetPostsFunction = Future<List<Post>> Function();

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostsFunction getPosts;

  PostBloc({required this.getPosts}) : super(PostInitial()) {
    on<LoadPosts>(_onLoadPosts);
    on<TogglePostFavorite>(_onTogglePostFavorite);
  }

  Future<void> _onLoadPosts(
    LoadPosts event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoading());
    try {
      final posts = await getPosts();
      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onTogglePostFavorite(
    TogglePostFavorite event,
    Emitter<PostState> emit,
  ) async {
    final currentState = state;
    if (currentState is PostLoaded) {
      final updatedPosts = currentState.posts.map((post) {
        if (post.id == event.postId) {
          return post.copyWith(isFavorite: !post.isFavorite);
        }
        return post;
      }).toList();
      emit(PostLoaded(updatedPosts));
    }
  }
}
