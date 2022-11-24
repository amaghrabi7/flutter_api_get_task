import 'package:api_get_task/models/pet_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PetProvider extends ChangeNotifier {
  List<PetModel> pets = [];
  bool isLoading = true;

  PetProvider() {
    loadPets();
  }

  void loadPets() async {
    isLoading = true;
    notifyListeners();

    Dio client = Dio();

    var response =
        await client.get('https://coded-pets-api-crud.herokuapp.com/pets');

    var body = response.data as List;

    pets = body
        .map(
          (json) => PetModel.fromJson(json),
        )
        .toList();

    isLoading = false;
    notifyListeners();
  }
}
