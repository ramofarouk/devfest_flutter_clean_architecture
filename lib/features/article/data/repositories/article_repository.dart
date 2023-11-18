import 'package:dartz/dartz.dart';
import 'package:test1/core/connection/network_info.dart';
import 'package:test1/core/error/exceptions.dart';
import 'package:test1/core/error/failure.dart';
import 'package:test1/features/article/data/datasources/local/article_local_datasource.dart';
import 'package:test1/features/article/data/datasources/remote/article_remote_datasource.dart';
import 'package:test1/features/article/data/models/article_model.dart';
import 'package:test1/features/article/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remoteDataSource;

  final ArticleLocalDataSource localDataSource;

  final NetworkInfo networkInfo;

  ArticleRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ArticleModel>>> getArticles() async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteArticles = await remoteDataSource.getArticles();

        localDataSource.cacheArticles(remoteArticles);

        return Right(remoteArticles);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      try {
        final articles = await localDataSource.getCachedArticles();
        return Right(articles);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'No local data found'));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> editArticle() {
    // TODO: implement editArticle
    throw UnimplementedError();
  }
}
