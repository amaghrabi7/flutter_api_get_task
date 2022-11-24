import 'package:api_get_task/providers/pet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PetslistPage extends StatelessWidget {
  const PetslistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text('Pets List')),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.replay_outlined),
        onPressed: () {
          context.read<PetProvider>().loadPets();
        },
      ),
      body: context.watch<PetProvider>().isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                context.read<PetProvider>().loadPets();
              },
              child: ListView.builder(
                itemCount: context.watch<PetProvider>().pets.length,
                itemBuilder: (context, index) {
                  var petProvider = context.watch<PetProvider>();
                  var pet = petProvider.pets[index];
                  return ListTile(
                    title: Text(pet.name),
                    subtitle: Text('Age: ${pet.age.toString()}'),
                    leading: Image.network(
                      pet.image,
                    ),
                  );
                },
              ),
            ),
    );
  }
}
