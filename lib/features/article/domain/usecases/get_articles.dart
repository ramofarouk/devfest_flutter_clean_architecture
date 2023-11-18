import 'package:dartz/dartz.dart';
import 'package:test1/core/error/failure.dart';
import 'package:test1/core/params/params.dart';
import 'package:test1/core/usecases/usecase.dart';
import 'package:test1/features/article/domain/entities/article.dart';
import 'package:test1/features/article/domain/repositories/article_repository.dart';

class GetArticles implements UseCase<List<Article>, NoParams> {
  final ArticleRepository repository;

  GetArticles(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call(NoParams params) async {
    return await repository.getArticles();
  }
}
