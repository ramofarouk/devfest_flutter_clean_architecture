import 'package:flutter/material.dart';
import 'package:test1/features/article/domain/entities/article.dart';

class ArticleListItem extends StatelessWidget {
  final Article article;

  const ArticleListItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(article.label),
        subtitle: Text(article.description),
      ),
    );
  }
}
