import '../../../../core/models/pet.dart';
import '../../../../core/models/vet.dart';
import '../../../../core/services/database_service.dart';
import '../models/appointment.dart';

class AppointmentRepository {
  final DatabaseService dbService;

  AppointmentRepository(this.dbService);

  Future<List<Appointment>> getAppointments() async {
    final db = await dbService.database;
    final result = await db.query('appointments', orderBy: 'date_time DESC');
    final appointments = <Appointment>[];
    for (final map in result) {
      final petResult =
          await db.query('pets', where: 'id = ?', whereArgs: [map['pet_id']]);
      final pet = petResult.isNotEmpty
          ? Pet.fromMap(petResult.first)
          : throw Exception('Pet not found');
      final vet = Vet(
          firstName: map['vet_first_name'] as String,
          lastName: map['vet_last_name'] as String);
      appointments.add(Appointment.fromMap(map, pet, vet));
    }
    return appointments;
  }

  Future<void> addAppointment(Appointment appointment) async {
    final db = await dbService.database;
    await db.insert('appointments', appointment.toMap());
  }
}
