class BookModel {
  final int id;
  final String title;
  final String description;
  final String price;
  final String image;

  BookModel(
      {required this.title,
      required this.description,
      required this.price,
      required this.image,
      required this.id});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      title: json['title'],
      description: json['description'],
      price: json['price'].toString(),
      image: json['image'],
      id: json['id'],
    );
  }
}
