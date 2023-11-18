import 'package:dartz/dartz.dart';
import 'package:test1/core/error/failure.dart';
import 'package:test1/features/article/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<Article>>> getArticles();
  Future<Either<Failure, bool>> editArticle();
}
