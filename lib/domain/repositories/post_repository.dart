import 'package:app_simples/domain/entities/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
}
