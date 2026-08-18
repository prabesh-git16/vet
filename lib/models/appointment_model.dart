class AppointmentModel {
  final String id;
  final String pet;
  final String owner;
  final String doctor;
  final String service;
  final String time;
  final String status;

  const AppointmentModel({
    required this.id,
    required this.pet,
    required this.owner,
    required this.doctor,
    required this.service,
    required this.time,
    required this.status,
  });
}
