import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/core/connection/network_info.dart';
import 'package:test1/core/error/failure.dart';
import 'package:test1/core/params/params.dart';
import 'package:test1/features/article/data/datasources/local/article_local_datasource.dart';
import 'package:test1/features/article/data/datasources/remote/article_remote_datasource.dart';
import 'package:test1/features/article/data/repositories/article_repository.dart';
import 'package:test1/features/article/domain/entities/article.dart';
import 'package:test1/features/article/domain/usecases/get_articles.dart';

class ArticleProvider extends ChangeNotifier {
  List<Article>? articles;
  Failure? failure;

  ArticleProvider({
    this.articles,
    this.failure,
  });

  void eitherFailureOrArticles() async {
    ArticleRepositoryImpl repository = ArticleRepositoryImpl(
      remoteDataSource: ArticleRemoteDataSource(dio: Dio()),
      localDataSource: ArticleLocalDataSource(
          sharedPreferences: await SharedPreferences.getInstance()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final failureOrArticles = await GetArticles(repository).call(
      NoParams(),
    );

    failureOrArticles.fold(
      (newFailure) {
        articles = null;
        failure = newFailure;
        notifyListeners();
      },
      (newArticles) {
        articles = newArticles;
        failure = null;
        notifyListeners();
      },
    );
  }
}
