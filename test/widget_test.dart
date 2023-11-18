// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test1/core/error/failure.dart';
import 'package:test1/core/params/params.dart';
import 'package:test1/features/article/domain/entities/article.dart';
import 'package:test1/features/article/domain/repositories/article_repository.dart';
import 'package:test1/features/article/domain/usecases/get_articles.dart';

class MockArticleRepository extends Mock implements ArticleRepository {
  @override
  Future<Either<Failure, List<Article>>> getArticles() async {
    // Vous pouvez ajuster cette implémentation en fonction de vos besoins de test
    // Par exemple, retournez des articles pré-définis ou des erreurs de manière contrôlée.
    return const Right([
      Article(label: "Test", description: ''),
    ]); // Pour un exemple avec une liste vide.
    // Ou retournez Left(Failure("Test failure")); pour simuler une erreur.
  }
}

void main() {
  late GetArticles usecase;
  late MockArticleRepository mockRepository;

  setUp(() {
    mockRepository = MockArticleRepository();
    usecase = GetArticles(mockRepository);
  });

  final List<Article> testArticles = [
    const Article(label: "Test", description: ''),
  ];

  test('should get a list of articles from the repository', () async {
    // Arrange
    when(mockRepository.getArticles())
        .thenAnswer((_) async => Right(testArticles));

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, Right(testArticles));
    verify(mockRepository.getArticles());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return a failure when the repository call is unsuccessful',
      () async {
    // Arrange
    when(mockRepository.getArticles()).thenAnswer(
        (_) async => Left(TestingFailure(errorMessage: "Test failure")));

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, Left(TestingFailure(errorMessage: "Test failure")));
    verify(mockRepository.getArticles());
    verifyNoMoreInteractions(mockRepository);
  });
}
