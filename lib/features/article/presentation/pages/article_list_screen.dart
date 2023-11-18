import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test1/core/error/failure.dart';
import 'package:test1/features/article/domain/entities/article.dart';
import 'package:test1/features/article/presentation/providers/article_provider.dart';
import 'package:test1/features/article/presentation/widgets/article_list_item.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Utilisez un ChangeNotifierProvider ou un autre gestionnaire d'état
    // pour fournir le UseCase approprié et gérer l'état de l'écran.
    List<Article>? articles = Provider.of<ArticleProvider>(context).articles;
    Failure? failure = Provider.of<ArticleProvider>(context).failure;
    late Widget widget;

    if (articles != null) {
      widget = ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return ArticleListItem(
            article: articles[index],
          );
        },
      );
    } else if (failure != null) {
      widget = Center(
        child: Text(failure.errorMessage),
      );
    } else {
      widget = const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des chambres'),
      ),
      body: widget,
    );
  }
}
