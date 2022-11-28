import 'package:api_get_task/providers/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BooksslistPage extends StatelessWidget {
  const BooksslistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text('Books List')),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.replay_outlined),
        onPressed: () {
          context.read<BookProvider>().loadBooks();
        },
      ),
      body: context.watch<BookProvider>().isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                context.read<BookProvider>().loadBooks();
              },
              child: ListView.builder(
                itemCount: context.watch<BookProvider>().books.length,
                itemBuilder: (context, index) {
                  var bookProvider = context.watch<BookProvider>();
                  var book = bookProvider.books[index];
                  return ListTile(
                    title: Text(book.title),
                    subtitle: Text('Age: ${book.price.toString()}'),
                    leading: Image.network(
                      book.image,
                    ),
                  );
                },
              ),
            ),
    );
  }
}
