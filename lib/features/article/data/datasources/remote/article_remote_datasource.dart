import 'package:dio/dio.dart';
import 'package:test1/core/constants/constants.dart';
import 'package:test1/core/error/exceptions.dart';
import 'package:test1/features/article/data/models/article_model.dart';

class ArticleRemoteDataSource {
  final Dio dio;

  ArticleRemoteDataSource({required this.dio});

  Future<List<ArticleModel>> getArticles() async {
    final response = await dio.get(host);

    if (response.statusCode == 200) {
      final List<ArticleModel> articles = (response.data as List)
          .map((json) => ArticleModel.fromJson(json: json))
          .toList();
      return articles;
    } else {
      throw ServerException();
    }
  }
}
