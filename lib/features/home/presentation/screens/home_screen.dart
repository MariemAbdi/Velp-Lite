import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velp_lite/core/widgets/app_scaffold.dart';
import 'package:velp_lite/core/widgets/empty_list.dart';

import '../../../../core/widgets/app_listview.dart';
import '../../view_model/pet_viewmodel.dart';
import '../widgets/greetings_section.dart';
import '../widgets/pet_card.dart';
import 'add_pet.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petState = ref.watch(petProvider);
    void goToAddPetScreen() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AddPet()),
      );
    }

    return AppScaffold(
      currentRoute: 'My Pets',
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: petState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : petState.error != null
              ? Center(child: Text(petState.error!))
              : Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 20,
                    children: [
                      const GreetingsSection(),
                      petState.pets.isEmpty
                          ? Expanded(
                              child: EmptyList(
                                title: 'No pets added yet',
                                message: 'Tap + to add your first pet',
                                icon: Icons.pets,
                              ),
                            )
                          : Expanded(
                              child: AppListview(
                                  itemCount: petState.pets.length,
                                  itemBuilder: (context, index) {
                                    return PetCard(pet: petState.pets[index]);
                                  }),
                            )
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToAddPetScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}
