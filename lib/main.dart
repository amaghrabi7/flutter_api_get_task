import 'package:api_get_task/pages/add_book_page.dart';
import 'package:api_get_task/pages/books_list_page.dart';
import 'package:api_get_task/pages/edit_book_page.dart';
import 'package:api_get_task/providers/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'models/book_model.dart';

void main() {
  runApp(const MyApp());
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BooksslistPage(),
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) => AddBookPage(),
    ),
    GoRoute(
      path: '/edit',
      builder: (context, state) => EditBookPage(
        book: state.extra as BookModel,
      ),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BookProvider(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: router,
      ),
    );
  }
}
