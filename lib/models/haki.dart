class Haki {
  final int    id;
  final String name;
  final String type;

  Haki({
    required this.id,
    required this.name,
    required this.type,
  });

  factory Haki.fromJson(Map<String, dynamic>? j) {
    if (j == null) return Haki(id: 0, name: 'Unknown', type: '');
    return Haki(
      id:   j['id']   as int?    ?? 0,
      name: j['name'] as String? ?? 'Unknown',
      type: j['type'] as String? ?? '',
    );
  }
}
