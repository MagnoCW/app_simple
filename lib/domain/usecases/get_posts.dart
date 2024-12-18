import 'package:app_simples/domain/entities/post.dart';
import 'package:app_simples/domain/repositories/post_repository.dart';

class GetPosts {
  final PostRepository repository;

  GetPosts(this.repository);

  Future<List<Post>> call() async {
    return await repository.getPosts();
  }
}
