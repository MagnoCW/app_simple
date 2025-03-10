import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class LoadPosts extends PostEvent {}

class TogglePostFavorite extends PostEvent {
  final int postId;

  const TogglePostFavorite(this.postId);

  @override
  List<Object?> get props => [postId];
}
