import 'package:test1/features/article/domain/entities/article.dart';

class ArticleModel extends Article {
  // Les propriétés du modèle représentant les données de l'API
  const ArticleModel({
    required String label,
    required String description,
  }) : super(
          label: label,
          description: description,
        );

  factory ArticleModel.fromJson({required Map<String, dynamic> json}) {
    return ArticleModel(
      label: json["label"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "label": label,
      "description": description,
    };
  }
}
