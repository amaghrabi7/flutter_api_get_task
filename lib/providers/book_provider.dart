import 'dart:io';
import 'package:api_get_task/models/book_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'client.dart';

class BookProvider extends ChangeNotifier {
  List<BookModel> books = [];
  bool isLoading = false;

  BookProvider() {
    loadBooks();
  }

  Future<void> loadBooks() async {
    isLoading = true;
    notifyListeners();

    books.clear();

    var response = await Client.dio.get('/books');

    var body = response.data as List;

    books = body
        .map(
          (json) => BookModel.fromJson(json),
        )
        .toList();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addBook({
    required String title,
    required String description,
    required String price,
    required File image,
  }) async {
    await Client.dio.post('/books',
        data: FormData.fromMap({
          'title': title,
          'description': description,
          'price': price,
          'image': await MultipartFile.fromFile(image.path),
        }));

    loadBooks();
  }

  Future<void> editBook({
    required int id,
    required String title,
    required String description,
    required String price,
    required File image,
  }) async {
    await Client.dio.put('/books/${id}',
        data: FormData.fromMap({
          'title': title,
          'description': description,
          'price': price,
          'image': await MultipartFile.fromFile(image.path),
        }));

    loadBooks();
  }

  void deleteBook(int id) async {
    await Client.dio.delete('/books/$id');

    loadBooks();
  }
}
