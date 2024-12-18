import 'package:app_simples/presentation/bloc/post_bloc.dart';
import 'package:app_simples/presentation/bloc/post_event.dart';
import 'package:app_simples/presentation/bloc/post_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MockPostRepository mockPostRepository;
  late PostBloc postBloc;

  setUp(() {
    mockPostRepository = MockPostRepository();
    postBloc = PostBloc(getPosts: mockPostRepository.getPosts);
  });

  tearDown(() {
    postBloc.close();
  });

  test('initial state should be PostInitial', () {
    expect(postBloc.state, equals(PostInitial()));
  });

  blocTest<PostBloc, PostState>(
    'emits [PostLoading, PostLoaded] when FetchPosts is added successfully',
    build: () {
      when(mockPostRepository.getPosts()).thenAnswer((_) async => []);
      return postBloc;
    },
    act: (bloc) => bloc.add(LoadPosts()),
    expect: () => [
      PostLoading(),
      const PostLoaded([]),
    ],
  );

  blocTest<PostBloc, PostState>(
    'emits [PostLoading, PostError] when FetchPosts fails',
    build: () {
      when(mockPostRepository.getPosts())
          .thenThrow(Exception('Failed to fetch posts'));
      return PostBloc(getPosts: mockPostRepository.getPosts);
    },
    act: (bloc) => bloc.add(LoadPosts()),
    expect: () => [
      PostLoading(),
      isA<PostError>().having(
          (e) => e.message, 'message', contains('Failed to fetch posts')),
    ],
  );
}
