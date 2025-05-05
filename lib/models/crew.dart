class Crew {
  final int id;
  final String name;

  Crew({required this.id, required this.name});

  /// Acepta json nulo y da valores por defecto
  factory Crew.fromJson(Map<String, dynamic>? j) {
    if (j == null) return Crew(id: 0, name: 'Unknown');
    return Crew(
      id:   j['id']   as int?    ?? 0,
      name: j['name'] as String? ?? 'Unknown',
    );
  }
}