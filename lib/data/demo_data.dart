import '../models/appointment_model.dart';
import '../models/pet_model.dart';
import '../models/user_model.dart';

class DemoData {
  static const List<UserModel> clients = [
    UserModel(
      id: 'c1',
      name: 'Sabo Luffy',
      email: 'sabo@example.com',
      role: UserRole.client,
    ),
    UserModel(
      id: 'c2',
      name: 'Ram Sharma',
      email: 'ram@example.com',
      role: UserRole.client,
    ),
    UserModel(
      id: 'c3',
      name: 'Anita KC',
      email: 'anita@example.com',
      role: UserRole.client,
    ),
  ];

  static const List<UserModel> doctors = [
    UserModel(
      id: 'd1',
      name: 'Dr. Sharma',
      email: 'sharma@pawcare.com',
      role: UserRole.doctor,
    ),
    UserModel(
      id: 'd2',
      name: 'Dr. Anisha',
      email: 'anisha@pawcare.com',
      role: UserRole.doctor,
    ),
    UserModel(
      id: 'd3',
      name: 'Dr. Raj',
      email: 'raj@pawcare.com',
      role: UserRole.doctor,
    ),
  ];

  static const List<PetModel> pets = [
    PetModel(
      id: 'p1',
      name: 'Max',
      species: 'Dog',
      breed: 'Golden Retriever',
      age: '3 Years',
      owner: 'Sabo Luffy',
    ),
    PetModel(
      id: 'p2',
      name: 'Milo',
      species: 'Cat',
      breed: 'Persian',
      age: '2 Years',
      owner: 'Ram Sharma',
    ),
    PetModel(
      id: 'p3',
      name: 'Rocky',
      species: 'Dog',
      breed: 'Labrador',
      age: '4 Years',
      owner: 'Anita KC',
    ),
  ];

  static const List<AppointmentModel> appointments = [
    AppointmentModel(
      id: 'a1',
      pet: 'Max',
      owner: 'Sabo Luffy',
      doctor: 'Dr. Sharma',
      service: 'General Checkup',
      time: '10:30 AM',
      status: 'Confirmed',
    ),
    AppointmentModel(
      id: 'a2',
      pet: 'Milo',
      owner: 'Ram Sharma',
      doctor: 'Dr. Anisha',
      service: 'Vaccination',
      time: '12:00 PM',
      status: 'Pending',
    ),
    AppointmentModel(
      id: 'a3',
      pet: 'Rocky',
      owner: 'Anita KC',
      doctor: 'Dr. Sharma',
      service: 'Skin Treatment',
      time: '2:30 PM',
      status: 'Confirmed',
    ),
    AppointmentModel(
      id: 'a4',
      pet: 'Bella',
      owner: 'Sunita Rai',
      doctor: 'Dr. Raj',
      service: 'Dental Checkup',
      time: '4:00 PM',
      status: 'Cancelled',
    ),
  ];
}
