class BookModel {
  final String title;
  final String price;
  final String image;

  BookModel({required this.title, required this.price, required this.image});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
        title: json['title'],
        price: json['price'].toString(),
        image: json['image']);
  }
}
