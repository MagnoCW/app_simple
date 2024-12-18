import 'package:app_simples/data/datasources/post_remote_datasource.dart';
import 'package:app_simples/domain/repositories/post_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  PostRepository,
  PostRemoteDataSource,
  http.Client,
])
void main() {}
