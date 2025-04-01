import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/vet.dart';

final vetProvider = Provider<List<Vet>>((ref) {
  return [
    Vet(firstName: 'John', lastName: 'Smith'),
    Vet(firstName: 'Emily', lastName: 'Jones'),
    Vet(firstName: 'Sarah', lastName: 'Brown'),
    Vet(firstName: 'Michael', lastName: 'Davis'),
    Vet(firstName: 'Jane', lastName: 'Doe'),
    Vet(firstName: 'Charles', lastName: 'Wilson'),
    Vet(firstName: 'David', lastName: 'Simpsons'),
    Vet(firstName: 'Veronica', lastName: 'Johnson'),
    Vet(firstName: 'Cortney', lastName: 'Jordan'),
  ];
});
