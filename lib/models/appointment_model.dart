enum AppointmentStatus { upcoming, completed, cancelled }
enum AppointmentType { inPerson, online }

class AppointmentModel {
  final String id;
  final String doctorId;
  final String doctorName;
  final String doctorSpecialty;
  final String patientId;
  final DateTime dateTime;
  final AppointmentStatus status;
  final AppointmentType type;
  final String? notes;

  const AppointmentModel({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.patientId,
    required this.dateTime,
    required this.status,
    required this.type,
    this.notes,
  });
}
