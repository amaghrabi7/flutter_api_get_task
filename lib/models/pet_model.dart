class PetModel {
  final String name;
  final int age;
  final String image;

  PetModel({required this.name, required this.age, required this.image});

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(name: json['name'], age: json['age'], image: json['image']);
  }
}
