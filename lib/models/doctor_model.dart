class DoctorModel {
  final String id;
  final String name;
  final String specialty;
  final String hospital;
  final double rating;
  final int reviewCount;
  final int yearsExperience;
  final String? avatarEmoji;
  final bool isAvailable;
  final double consultationFee;

  const DoctorModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.hospital,
    required this.rating,
    required this.reviewCount,
    required this.yearsExperience,
    this.avatarEmoji,
    this.isAvailable = true,
    required this.consultationFee,
  });
}
