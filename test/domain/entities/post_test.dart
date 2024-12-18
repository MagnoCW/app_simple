import 'package:app_simples/domain/entities/post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Post Entity', () {
    test('two posts with same properties should be equal', () {
      final post1 = Post(id: 1, title: 'Test', body: 'Body', isFavorite: false);
      final post2 = Post(id: 1, title: 'Test', body: 'Body', isFavorite: false);

      expect(post1, equals(post2));
    });

    test('should toggle favorite correctly', () {
      final post = Post(id: 1, title: 'Test', body: 'Body', isFavorite: false);
      final toggledPost = post.copyWith(isFavorite: true);

      expect(toggledPost.isFavorite, true);
    });
  });
}
