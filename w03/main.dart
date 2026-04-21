class PatientRecord {
  final String name;
  final int age;
  final double glucoseLevel;

  PatientRecord(this.name, this.age, this.glucoseLevel);

  @override
  String toString() => '$name (age $age, glucose: $glucoseLevel)';
}

void main() {
  final patients = [
    PatientRecord('Alice', 34, 95.2),
    PatientRecord('Bob', 67, 142.8),
    PatientRecord('Carol', 45, 88.1),
    PatientRecord('Dave', 72, 198.5),
    PatientRecord('Eve', 29, 102.3),
  ];

  // .where() — filter patients with elevated glucose (>100)
  final elevated = patients.where((p) => p.glucoseLevel > 100).toList();
  print('Elevated glucose:');
  elevated.forEach(print);

  // .map() — extract just the names
  final names = patients.map((p) => p.name).toList();
  print('\nAll patients: $names');

  // .reduce() — find the highest glucose reading
  final highest = patients.reduce(
    (a, b) => a.glucoseLevel > b.glucoseLevel ? a : b,
  );
  print('\nHighest glucose: $highest');

  // Challenge: compute the average glucose level
  final avg = patients
      .map((p) => p.glucoseLevel)
      .reduce((a, b) => a + b) / patients.length;
  print('Average glucose: ${avg.toStringAsFixed(1)}');
}