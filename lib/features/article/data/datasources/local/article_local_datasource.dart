import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/features/article/data/models/article_model.dart';

class ArticleLocalDataSource {
  final SharedPreferences sharedPreferences;

  ArticleLocalDataSource({required this.sharedPreferences});

  // Méthode pour sauvegarder les articles localement
  Future<void> cacheArticles(List<ArticleModel> articles) async {
    final jsonList =
        articles.map((article) => jsonEncode(article.toJson())).toList();
    await sharedPreferences.setStringList('articles', jsonList);
  }

  // Méthode pour récupérer les articles localement
  Future<List<ArticleModel>> getCachedArticles() async {
    final jsonStringList = sharedPreferences.getStringList('articles') ?? [];
    final jsonList = jsonStringList
        .map(
            (jsonString) => ArticleModel.fromJson(json: jsonDecode(jsonString)))
        .toList();
    return jsonList.cast<ArticleModel>();
  }
}
