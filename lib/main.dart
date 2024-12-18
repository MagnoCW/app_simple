import 'package:app_simples/presentation/bloc/post_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/post_remote_datasource.dart';
import 'data/repositories/post_repository_impl.dart';
import 'domain/usecases/get_posts.dart';
import 'presentation/bloc/post_bloc.dart';
import 'presentation/pages/posts_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Posts App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) {
          final client = http.Client();
          final remoteDataSource = PostRemoteDataSourceImpl(client: client);
          final repository =
              PostRepositoryImpl(remoteDataSource: remoteDataSource);
          final getPostsUseCase = GetPosts(repository);
          return PostBloc(getPosts: getPostsUseCase.call)..add(LoadPosts());
        },
        child: const PostsPage(),
      ),
    );
  }
}
