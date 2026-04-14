class MedicationModel {
  final String name;
  final String dosage;
  final String frequency;
  final String duration;
  final String? notes;

  const MedicationModel({
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.duration,
    this.notes,
  });
}

class PrescriptionModel {
  final String id;
  final String patientId;
  final String doctorId;
  final DateTime date;
  final List<MedicationModel> medications;
  final String? diagnosis;

  const PrescriptionModel({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.date,
    required this.medications,
    this.diagnosis,
  });
}
