class HealthMetrics {
  final int healthScore;
  final int heartRate;
  final String bloodPressure;
  final int steps;
  final double weight;
  final double temperature;

  const HealthMetrics({
    required this.healthScore,
    required this.heartRate,
    required this.bloodPressure,
    required this.steps,
    required this.weight,
    required this.temperature,
  });
}
