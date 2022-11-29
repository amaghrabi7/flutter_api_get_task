import 'package:api_get_task/providers/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        child: Icon(Icons.add),
        onPressed: () {
          context.push('/add');
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
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Price: ${book.price.toString()}',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    leading: Image.network(
                      book.image,
                    ),
                    trailing: Column(
                      children: [
                        InkWell(
                          onTap: () =>
                              context.read<BookProvider>().deleteBook(book.id),
                          child: Icon(Icons.delete),
                        ),
                        InkWell(
                          onTap: () {
                            context.push('/edit', extra: book);
                          },
                          child: Icon(Icons.edit),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
