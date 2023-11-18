import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/theme/app_themes.dart';
import 'features/article/presentation/pages/article_list_screen.dart';
import 'features/article/presentation/providers/article_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TestApp',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ArticleProvider(),
          ),
        ],
        child: const Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    Provider.of<ArticleProvider>(context, listen: false)
        .eitherFailureOrArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const ArticleListScreen();
  }
}
