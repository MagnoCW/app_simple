import 'package:app_simples/domain/usecases/get_posts.dart';
import 'package:app_simples/presentation/bloc/post_bloc.dart';
import 'package:app_simples/presentation/bloc/post_event.dart';
import 'package:app_simples/presentation/pages/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MockPostRepository mockPostRepository;

  setUp(() {
    mockPostRepository = MockPostRepository();
  });

  testWidgets('PostsPage shows loading indicator when loading',
      (WidgetTester tester) async {
    // Mock the repository to simulate a delay
    when(mockPostRepository.getPosts()).thenAnswer(
      (_) async => Future.delayed(
        const Duration(seconds: 1),
        () => [],
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) {
            final getPosts = GetPosts(mockPostRepository);
            return PostBloc(getPosts: getPosts.call)..add(LoadPosts());
          },
          child: const PostsPage(),
        ),
      ),
    );

    // Verify that the CircularProgressIndicator is shown initially
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the async operation to complete
    await tester.pumpAndSettle();

    // After loading, the CircularProgressIndicator should be gone
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
