import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  File? imageFile;

  String? imageError;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Book'),
        ),
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: 'Title'),
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return "Field is required";
                    }
                    return null;
                  }),
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(hintText: 'Description'),
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return "Field is required";
                    }
                    if (value.length <= 5) {
                      return "Description too short";
                    }
                    return null;
                  }),
                ),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(hintText: 'Price'),
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return "Field is required";
                    }
                    if (double.tryParse(value) == null) {
                      return "Input must be a number";
                    }
                    return null;
                  }),
                ),
                if (imageFile != null)
                  Image.file(imageFile!, width: 100, height: 100)
                else
                  Container(width: 100, height: 100),
                ElevatedButton(
                  onPressed: () async {
                    var file = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (file == null) {
                      print("User didn't select a file");
                      return;
                    }
                    setState(() {
                      imageFile = File(file.path);
                      imageError = null;
                    });
                  },
                  child: Text('Add Image'),
                ),
                if (imageError != null)
                  Text(
                    imageError!,
                    style: TextStyle(color: Colors.red),
                  ),
                Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    if (imageFile == null) {
                      setState(() {
                        imageError = "Required Field";
                      });
                    }
                    if (formKey.currentState!.validate() && imageFile != null) {
                      await context.read<BookProvider>().addBook(
                            title: titleController.text,
                            description: descriptionController.text,
                            price: priceController.text,
                            image: imageFile!,
                          );
                      context.pop();
                    }
                  },
                  child: Text('Add Book'),
                ),
              ],
            ),
          ),
        ));
  }
}
